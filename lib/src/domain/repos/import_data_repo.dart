import 'dart:io';

import 'package:excel/excel.dart';
import 'package:school_timetable/src/data/models/classes/classes_model.dart';
import 'package:school_timetable/src/data/models/tables/table_model.dart';
import 'package:school_timetable/src/data/models/teachers/teacher_model.dart';

abstract class ImportDataRepo {
  Future<(Exception?, String?)> pickExcelFIle();
  Future<(Exception?, Excel?)> readExcelData(String? path);
  Future<(Exception?, bool)> validateClassesFile(Excel? data);
  Future<(Exception?, bool)> validateTeachersFile(Excel? data);

  //get date from excel file
  Future<(Exception?, List<ClassesModel>?)> getClassesData(Excel? data);
  Future<(Exception?, List<TeacherModel>?)> getTeachersData(Excel? data);

  //save data to hive
  Future<Exception?> saveClasses(List<ClassesModel> classes);
  Future<Exception?> saveTeachers(List<TeacherModel> teachers);

  //get data from hive
  List<ClassesModel> getClasses();
   List<TeacherModel> getTeachers();

   //delete data from hive
    Future<Exception?> deleteClass(ClassesModel classes);
    Future<Exception?> deleteTeacher(TeacherModel teacher);


    //clear data from hive
    Future<Exception?> clearClasses();
    Future<Exception?> clearTeachers();

    // create excel template
    void createClassesTemplate();
    void createTeachersTemplate();

    //get tables
    List<TableModel> getTables();

    //save tables
    Future<Exception?> saveTables(List<TableModel> tables);

    //clear tables
    Future<Exception?> clearTables();
}
   