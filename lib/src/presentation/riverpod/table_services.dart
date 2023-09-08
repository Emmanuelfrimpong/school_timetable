import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_timetable/src/core/widgets/smart_dialog.dart';
import 'package:school_timetable/src/data/models/class_subject_model.dart';
import 'package:school_timetable/src/data/models/period_model.dart';
import 'package:school_timetable/src/data/models/teacher_class_model.dart';
import 'package:school_timetable/src/presentation/riverpod/classes_services.dart';
import 'package:school_timetable/src/presentation/riverpod/teachers_services.dart';
import 'package:collection/collection.dart';
import '../../core/constants/additional_subjects.dart';
import '../../core/constants/classes_constants.dart';
import '../../data/models/class_teacher_subject_model.dart';
import '../../data/models/period_day_model.dart';
import '../../data/models/tables/table_model.dart';
import '../../domain/usercases/import_data_usercase.dart';
import 'period_services.dart';

final tableListProvider =
    StateNotifierProvider<TableListNotifier, List<TableModel>>((ref) {
  return TableListNotifier();
});

class TableListNotifier extends StateNotifier<List<TableModel>> {
  TableListNotifier() : super(ImportDataUseCase().getTables()) {
    getTables();
  }
  final ImportDataUseCase importDataUseCase = ImportDataUseCase();

  void getTables() {
    state = importDataUseCase.getTables();
  }

  void generateTables(WidgetRef ref) {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Generating Tables...');
    List<ClassSubjectModel> csp = getClassSubjectPairs(ref);
    List<TeacherClassModel> tcp = getTeacherClassPairs(ref);
    List<ClassTecherSubjectModel> TCSP = getTecherClassSubjectPair(csp, tcp);
    List<PeriodDayModel> PDP = getPeriodDayPairs(ref);

    //time to pair TCSP with PDP
    //check and avoid same teacher teaching more than one class at the same time
    //check and avoid same class having more than one subject at the same time
    List<TableModel> tables = createTableItems(TCSP, PDP);

// group table by day and period
    // var tableGroup = groupBy(tables, (p0) => p0.day);
    // var  item= tableGroup.keys.where((element) => element=='Monday').toList();

    // print('start===================================================');
    // print(item);
    // for (var element in tableGroup[item.first]!) {
    //   print('${element.period}');
    // }
    // print('end===================================================');

    // print tables with day and period
    // for (var item in tables) {\
    //   print('${item.className} ${item.subject} ${item.day} ${item.period}');
    // }

    //save tables to hive
    importDataUseCase.saveTables(tables);
    //save periods to hive
    var periods = ref.watch(periodDataProvider);
    importDataUseCase.savePeriods(periods);
    //get tables from hive
    //print table

    getTables();
    CustomDialog.dismiss();
    CustomDialog.showSuccess(
        title: 'Success', message: 'Tables Generated Successfully');
  }

  List<ClassSubjectModel> getClassSubjectPairs(WidgetRef ref) {
    var classSubjectPairs = <ClassSubjectModel>[];
    var classes = ref.watch(classesListProvider);
    for (var element in classes) {
      var subjects = element.subjects;
      for (var subject in subjects!) {
        classSubjectPairs.add(ClassSubjectModel(
            classId: element.id,
            className: element.className,
            classCode: element.classCode,
            subjectName: subject.toString(),
            subjectCode: subject
                .toString()
                .toLowerCase()
                .replaceAll(' ', '_')
                .toLowerCase()
                .hashCode
                .toString()));
      }
    }
    return classSubjectPairs;
  }

  List<TeacherClassModel> getTeacherClassPairs(WidgetRef ref) {
    var teacherClassPairs = <TeacherClassModel>[];
    var teachers = ref.watch(teachersListProvider);
    for (var element in teachers) {
      var classes = element.classesCode;
      for (var classId in classes!) {
        teacherClassPairs.add(TeacherClassModel(
            teacherId: element.id,
            teacherName: element.name,
            id: '${element.id}_${classId.toString().toLowerCase()}',
            subjectName: element.subject,
            classCode: classId));
      }
    }
    return teacherClassPairs;
  }

  List<ClassTecherSubjectModel> getTecherClassSubjectPair(
      List<ClassSubjectModel> csp, List<TeacherClassModel> tcp) {
    var teacherClassSubjectPairs = <ClassTecherSubjectModel>[];
    var paired = <String>[];
    var failed = <String>[];
    for (var element in csp) {
      var data = tcp
          .where((item) =>
              item.classCode!.replaceAll(' ', '').trim().toLowerCase() ==
                  element.classCode!.replaceAll(' ', '').trim().toLowerCase() &&
              item.subjectName!.replaceAll(' ', '').trim().toLowerCase() ==
                  element.subjectName!.replaceAll(' ', '').trim().toLowerCase())
          .toList();
      if (data.isNotEmpty) {
        var item = data.first;
        teacherClassSubjectPairs.add(ClassTecherSubjectModel(
          classId: element.classId,
          className: element.className,
          classCode: element.classCode,
          subjectName: element.subjectName,
          subjectCode: element.subjectCode,
          teacherId: item.teacherId,
          teacherName: item.teacherName,
        ));
        paired
            .add('${element.classId}_${element.subjectCode}_${item.teacherId}');
      } else {
        failed.add('${element.subjectName}_${element.classCode}');
      }
    }
    print('paired: ${paired.length}');
    print('failed: ${failed.length}');
    for (var item in failed) {
      print(item);
    }
    return teacherClassSubjectPairs;
  }

  List<PeriodDayModel> getPeriodDayPairs(WidgetRef ref) {
    List<PeriodModel> p = ref.watch(periodDataProvider);
    // remove break periods
    var periods = p
        .where(
            (element) => !element.periodName!.toLowerCase().contains('break'))
        .toList();
    List<PeriodDayModel> periodDayPairs = [];
    for (var element in periods) {
      for (var day in days) {
        periodDayPairs.add(PeriodDayModel(
          day: day,
          period: element.period,
          startTime: element.startTime,
          endTime: element.endTime,
          periodName: element.periodName,
        ));
      }
    }
    return periodDayPairs;
  }

  List<TableModel> createTableItems(
      List<ClassTecherSubjectModel> tcsp, List<PeriodDayModel> pdp) {
    //remove friday first and second period
    // var pdpList = pdp
    //     .where((element) => !(element.day == 'Friday' &&
    //         (element.period == 1 || element.period == 2)))
    //     .toList();
    List<TableModel> tables = [];
    var classGroup = groupBy(tcsp, (p0) => p0.classId);
    for (var singleClass in classGroup.keys) {
      var pdpList = pdp
          .where((element) => !(element.day == 'Friday' &&
              (element.period == 1 || element.period == 2)))
          .toList();
      //var singleClass = classGroup.keys.first;
      var singleClassData = classGroup[singleClass];
      for (int i = 0; i < 2; i++) {
        for (var item in singleClassData!) {
          pdpList.shuffle();
          var pdpItem = pdpList.first;
          tables.add(TableModel(
            id: '${item.teacherId}_${pdpItem.period}_${pdpItem.day}'
                .hashCode
                .toString(),
            classId: item.classId,
            subject: item.subjectName,
            className: item.className,
            programme: '',
            createdAt: DateTime.now().millisecondsSinceEpoch,
            classCode: item.classCode,
            teacherId: item.teacherId,
            teacherName: item.teacherName,
            period: pdpItem.period,
            day: pdpItem.day,
            periodMap: {
              'period': pdpItem.period,
              'periodName': pdpItem.periodName,
              'startTime': pdpItem.startTime,
              'endTime': pdpItem.endTime,
            },
          ));
          pdpList.remove(pdpItem);
        }
      }
      //check if the class has more than 35 tables
      //if no, add more tables
      var classTables2 =
          tables.where((element) => element.classId == singleClass).toList();

      //get all subjects
      var allSubjects = classTables2.map((e) => e.subject).toList();
      //remove additiional subjects
      var withoutAdditionalSubjects = allSubjects
          .where((element) => !additionalSubjects.contains(element))
          .toList();
      // get class subject pair for each subject
      var classSubjectPair = singleClassData!
          .where((element) =>
              withoutAdditionalSubjects.contains(element.subjectName))
          .toList();
      // create 3 tables for each classSubjectPair
      for (int i = 0; i < 2; i++) {
        for (var item in classSubjectPair) {
          pdpList.shuffle();
          var pdpItem = pdpList.first;
          tables.add(TableModel(
            id: '${item.teacherId}_${pdpItem.period}_${pdpItem.day}'
                .hashCode
                .toString(),
            classId: item.classId,
            subject: item.subjectName,
            className: item.className,
            programme: '',
            createdAt: DateTime.now().millisecondsSinceEpoch,
            classCode: item.classCode,
            teacherId: item.teacherId,
            teacherName: item.teacherName,
            period: pdpItem.period,
            day: pdpItem.day,
            periodMap: {
              'period': pdpItem.period,
              'periodName': pdpItem.periodName,
              'startTime': pdpItem.startTime,
              'endTime': pdpItem.endTime,
            },
          ));
          pdpList.remove(pdpItem);
        }
      }
    }
    return tables;
  }
}
