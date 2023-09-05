import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_timetable/src/core/widgets/smart_dialog.dart';
import 'package:school_timetable/src/data/models/class_subject_model.dart';
import 'package:school_timetable/src/data/models/period_model.dart';
import 'package:school_timetable/src/data/models/teacher_class_model.dart';
import 'package:school_timetable/src/presentation/riverpod/classes_services.dart';
import 'package:school_timetable/src/presentation/riverpod/teachers_services.dart';
import 'package:collection/collection.dart';
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
    //save tables to hive
    importDataUseCase.saveTables(tables);
    //save periods to hive
    var periods = ref.watch(periodDataProvider);
    importDataUseCase.savePeriods(periods);
    //get tables from hive
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
    for (var element in csp) {
      for (var item in tcp) {
        if (element.classCode == item.classCode && element.subjectName==item.subjectName) {
          teacherClassSubjectPairs.add(ClassTecherSubjectModel(
              classId: element.classId,
              className: element.className,
              classCode: element.classCode,
              subjectName: element.subjectName,
              subjectCode: element.subjectCode,
              teacherId: item.teacherId,
              teacherName: item.teacherName));
        }
      }
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
    //time to pair TCSP with PDP
    //check and avoid same teacher teaching more than one class at the same time
    //check and avoid same class having more than one subject at the same time
    List<TableModel> tables = [];
    // group TCSP by classId
    var groupedTCSP = groupBy(tcsp, (obj) => obj.classId);
    Random random = Random();
    var element=groupedTCSP.keys.elementAt(0);
    if (element == null) {
      var pdpList = pdp;
      pdpList.shuffle(random);
      List<ClassTecherSubjectModel> classList = groupedTCSP['$element']!;
      // randomly a classList to pdp
      // check if the teacher is not teaching another class at the same time else get  another pdp
      // check if the class is not having another subject at the same time else get another pdp
      // if both are true then add to table
      for (var item in classList) {
        var existenTable = tables.where(
            (tab) => element == tab.classId || item.teacherId == tab.teacherId);
        for (var pdpItem in pdpList) {
          var usedPeriod = existenTable.where(
              (tab) => pdpItem.period == tab.period && pdpItem.day == tab.day);
          if (usedPeriod.isEmpty) {
            tables.add(TableModel(
              id: '${element}_${item.teacherId}_${pdpItem.period}_${pdpItem.day}'
                  .hashCode
                  .toString(),
              classId: element,
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
            //remove the pdp from the list
            pdpList.remove(pdpItem);
            break;
          }else{
            //remove the pdp from the list
            pdpList.remove(pdpItem);
          }
        }
        
      }

    }
    return tables;
  }
}
