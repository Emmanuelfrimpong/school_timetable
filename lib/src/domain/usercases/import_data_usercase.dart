import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:school_timetable/src/core/constants/additional_subjects.dart';
import 'package:school_timetable/src/data/models/classes/classes_model.dart';
import 'package:school_timetable/src/data/models/period_model.dart';
import 'package:school_timetable/src/data/models/teachers/teacher_model.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import '../../core/functions/excel_settings.dart';
import '../../core/widgets/smart_dialog.dart';
import '../../data/models/tables/table_model.dart';
import '../repos/import_data_repo.dart';
import 'package:path_provider/path_provider.dart';

class ImportDataUseCase extends ImportDataRepo {
  @override
  Future<(Exception?, String?)> pickExcelFIle() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xls', 'xlsx'],
        allowMultiple: false,
      );
      return Future.value((null, result!.files.single.path));
    } catch (e) {
      return Future.value((Exception(e.toString()), null));
    }
  }

  @override
  Future<(Exception?, Excel?)> readExcelData(String? path) {
    try {
      if (path != null) {
        var bytes = File(path).readAsBytesSync();
        return Future.value((null, Excel.decodeBytes(bytes)));
      } else {
        return Future.value((Exception('No file selected'), null));
      }
    } catch (e) {
      return Future.value((Exception(e.toString()), null));
    }
  }

  @override
  Future<(Exception?, bool)> validateClassesFile(Excel? data) {
    try {
      if (data == null) {
        return Future.value((Exception('No file selected'), false));
      }
      // GEt the header row
      List<Data?> headerRow = data.tables[data.getDefaultSheet()]!.row(1);
      List<String> fileColumns = headerRow
          .map<String>((row) => row != null ? row.value.toString() : '')
          .where((element) => element.isNotEmpty)
          .toList();
      // check if the file has the required columns
      if (fileColumns.contains('Class Name') &&
          fileColumns.contains('Class Code') &&
          fileColumns.contains('Programme (Full Name)') &&
          fileColumns.contains('Combinations')) {
        return Future.value((null, true));
      } else {
        return Future.value((Exception('Invalid file'), false));
      }
    } catch (e) {
      return Future.value((Exception(e.toString()), false));
    }
  }

  @override
  Future<(Exception?, bool)> validateTeachersFile(Excel? data) {
    try {
      if (data == null) {
        return Future.value((Exception('No file selected'), false));
      }
      // GEt the header row
      List<Data?> headerRow = data.tables[data.getDefaultSheet()]!.row(1);
      List<String> fileColumns = headerRow
          .map<String>((row) => row != null ? row.value.toString() : '')
          .where((element) => element.isNotEmpty)
          .toList();
      // check if the file has the required columns
      if (fileColumns.contains('Teacher Name') &&
          fileColumns.contains('Subject') &&
          fileColumns.contains('Classes')) {
        return Future.value((null, true));
      } else {
        return Future.value((Exception('Invalid file'), false));
      }
    } catch (e) {
      return Future.value((Exception(e.toString()), false));
    }
  }

  @override
  Future<(Exception?, List<ClassesModel>?)> getClassesData(Excel? data) {
    try {
      if (data == null) {
        return Future.value((Exception('No file selected'), null));
      }
      //get rows
      var rows = data.tables[data.getDefaultSheet()]!.rows;
      //remove header row
      List<ClassesModel> classes = rows.skip(2).map<ClassesModel>((row) {
        var subjects = row[3]!.value.toString().split(',');
         subjects.addAll(additionalSubjects);
        return ClassesModel(
          id: row[0].toString().toLowerCase().trim().hashCode.toString(),
          classCode: row[0]!.value.toString(),
          className: row[1]!.value.toString(),
          course: row[2]!.value.toString(),
          subjects: subjects,
          createdAt: DateTime.now().millisecondsSinceEpoch,
        );
      }).toList();
      return Future.value((null, classes));
    } catch (e) {
      return Future.value((Exception(e.toString()), null));
    }
  }

  @override
  Future<(Exception?, List<TeacherModel>?)> getTeachersData(Excel? data) {
    try {
      if (data == null) {
        return Future.value((Exception('No file selected'), null));
      }
      //get rows
      var rows = data.tables[data.getDefaultSheet()]!.rows;
      //remove header row
      List<TeacherModel> teachers = rows
          .skip(2)
          .map<TeacherModel>((row) {
            var classes=row[2]!.value.toString().split(',');
           
            return TeacherModel(
              id: row[0]!
                  .value
                  .toString()
                  .toLowerCase()
                  .trim()
                  .hashCode
                  .toString(),
              name: row[0]!.value.toString(),
              subject: row[1]!.value.toString(),
              classesCode: classes,
              classesName: [],
              createdAt: DateTime.now().millisecondsSinceEpoch,
            );
          })
          .where((element) => element.id!.isNotEmpty)
          .toList();
      return Future.value((null, teachers));
    } catch (e) {
      return Future.value((Exception(e.toString()), null));
    }
  }

  @override
  Future<Exception?> saveClasses(List<ClassesModel> classes) async {
    try {
      // open box and save data using ClassModelAdapter and id
      var box = await Hive.openBox<ClassesModel>('classes');
      await box.clear();
      await box.addAll(classes);
      return Future.value((null));
    } catch (e) {
      return Future.value((Exception(e.toString())));
    }
  }

  @override
  Future<Exception?> saveTeachers(List<TeacherModel> teachers) async {
    try {
      // open box and save data using ClassModelAdapter and id
      var box = await Hive.openBox<TeacherModel>('teachers');
      await box.clear();
      await box.addAll(teachers);
      return Future.value((null));
    } catch (e) {
      return Future.value((Exception(e.toString())));
    }
  }

  @override
  List<ClassesModel> getClasses() {
    try {
      // open box and save data using ClassModelAdapter and id
      var box = Hive.box<ClassesModel>('classes');
      return box.values.toList();
    } catch (e) {
      return [];
    }
  }

  @override
  List<TeacherModel> getTeachers() {
    try {
      // open box and save data using ClassModelAdapter and id
      var box = Hive.box<TeacherModel>('teachers');
      return box.values.toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Exception?> deleteClass(ClassesModel classes) {
    try {
      // open box and save data using ClassModelAdapter and id
      var box = Hive.box<ClassesModel>('classes');
      box.delete(classes.id);
      return Future.value((null));
    } catch (e) {
      return Future.value((Exception(e.toString())));
    }
  }

  @override
  Future<Exception?> deleteTeacher(TeacherModel teacher) {
    try {
      // open box and save data using ClassModelAdapter and id
      var box = Hive.box<TeacherModel>('teachers');
      box.delete(teacher.id);
      return Future.value((null));
    } catch (e) {
      return Future.value((Exception(e.toString())));
    }
  }

  @override
  Future<Exception?> clearClasses() {
    try {
      // open box and save data using ClassModelAdapter and id
      var box = Hive.box<ClassesModel>('classes');
      box.clear();
      return Future.value((null));
    } catch (e) {
      return Future.value((Exception(e.toString())));
    }
  }

  @override
  Future<Exception?> clearTeachers() {
    try {
      // open box and save data using ClassModelAdapter and id
      var box = Hive.box<TeacherModel>('teachers');
      box.clear();
      return Future.value((null));
    } catch (e) {
      return Future.value((Exception(e.toString())));
    }
  }

  @override
  void createClassesTemplate() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String fileName = '${appDocDir.path}/classes.xlsx';
      File file = File(fileName);
      if (File(fileName).existsSync()) {
        CustomDialog.showInfo(
          onPressed2: () {},
          title: 'File Exist',
          message:
              'File with the name classes.xlsx already exist. Do you want to view it or overwrite it ?',
          buttonText2: 'View Template',
          onConfirmText: 'Overwrite',
          onConfirm: () {
            CustomDialog.showLoading(message: 'Creating Template');
            final Workbook workbook = Workbook();
            ExcelSheetSettings(
              book: workbook,
              sheetName: 'Classes',
              columnCount: 4,
              headings: [
                'Class Code',
                'Class Name',
                'Programme (Full Name)',
                'Combinations'
              ],
            ).sheetSettings();

            file.writeAsBytesSync(workbook.saveAsStream());
            workbook.dispose();
            CustomDialog.dismiss();
            //open file
            CustomDialog.dismiss();
            OpenAppFile.open(fileName);
          },
        );
      } else {
        CustomDialog.showLoading(message: 'Creating Template');
        final Workbook workbook = Workbook();
        ExcelSheetSettings(
          book: workbook,
          sheetName: 'Classes',
          columnCount: 4,
          headings: [
            'Class Code',
            'Class Name',
            'Programme (Full Name)',
            'Combinations'
          ],
        ).sheetSettings();
        file.writeAsBytesSync(workbook.saveAsStream());
        workbook.dispose();
        CustomDialog.dismiss();
        //open file
        CustomDialog.dismiss();
        OpenAppFile.open(fileName);
      }
    } catch (e) {
      CustomDialog.dismiss();
      CustomDialog.showError(message: e.toString(), title: 'Error');
    }
  }

  @override
  void createTeachersTemplate() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String fileName = '${appDocDir.path}/teachers.xlsx';
      File file = File(fileName);
      if (File(fileName).existsSync()) {
        CustomDialog.showInfo(
          onPressed2: () {},
          title: 'File Exist',
          message:
              'File with the name Teachers.xlsx already exist. Do you want to view it or overwrite it ?',
          buttonText2: 'View Template',
          onConfirmText: 'Overwrite',
          onConfirm: () {
            CustomDialog.showLoading(message: 'Creating Template');
            final Workbook workbook = Workbook();
            ExcelSheetSettings(
              book: workbook,
              sheetName: 'Teacher',
              columnCount: 3,
              headings: ['Name', 'Subject', 'Classes'],
            ).sheetSettings();

            file.writeAsBytesSync(workbook.saveAsStream());
            workbook.dispose();
            CustomDialog.dismiss();
            //open file
            CustomDialog.dismiss();
            OpenAppFile.open(fileName);
          },
        );
      } else {
        CustomDialog.showLoading(message: 'Creating Template');
        final Workbook workbook = Workbook();
        ExcelSheetSettings(
          book: workbook,
          sheetName: 'Teacher',
          columnCount: 3,
          headings: ['Name', 'Subject', 'Classes'],
        ).sheetSettings();
        file.writeAsBytesSync(workbook.saveAsStream());
        workbook.dispose();
        CustomDialog.dismiss();
        //open file
        CustomDialog.dismiss();
        OpenAppFile.open(fileName);
      }
    } catch (e) {
      CustomDialog.dismiss();
      CustomDialog.showError(message: e.toString(), title: 'Error');
    }
  }
  
  @override
  Future<Exception?> clearTables() {
    // TODO: implement clearTables
    throw UnimplementedError();
  }
  
  @override
  List<TableModel> getTables() {
   try{
      var box=Hive.box<TableModel>('tables');
      print(box.values.toList().length);
      return box.values.toList();
   }catch(e){
     return [];
   }
  }
  
  @override
  Future<Exception?> saveTables(List<TableModel> tables) {
    try{
      var box=Hive.box<TableModel>('tables');
      box.clear();
      box.addAll(tables);
      return Future.value(null);
    }catch(e){
      return Future.value(Exception(e.toString()));
    }
  }

  @override
  List<PeriodModel> getPeriods() {
    try{
      var box=Hive.box<PeriodModel>('periods');
      return box.values.toList();
    }catch(e){
      return [];
    }
  }

  @override
  Future<Exception?> savePeriods(List<PeriodModel> periods) {
   try{
      var box=Hive.box<PeriodModel>('periods');
      box.clear();
      box.addAll(periods);
      return Future.value(null);

   }catch(e){
     return Future.value(Exception(e.toString()));
   }
  }
}
