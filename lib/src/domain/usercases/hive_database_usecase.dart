 import 'dart:async';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_timetable/src/data/models/classes/classes_model.dart';
import 'package:school_timetable/src/data/models/tables/table_model.dart';
import 'package:school_timetable/src/data/models/teachers/teacher_model.dart';
import 'package:school_timetable/src/domain/repos/hive_database_repo.dart';

class HiveDatabaseUseCase extends HiveDatabaseRepo{
  @override
  Future<(Exception?, void)> clearClasses() {
    try{
      Hive.box<ClassesModel>('classes').clear();
      return Future.value((null, null) );
    }catch(e){
      return Future.value((Exception(e.toString()), null));
    }
  }

  @override
  Future<(Exception?, void)> clearTeachers() {
    try{
      Hive.box<TeacherModel>('teachers').clear();
      return Future.value((null, null) );
    }catch(e){
      return Future.value((Exception(e.toString()), null));
    }
  }

  @override
  Future<(Exception?, void)> deleteClass(String id) {
    try{
      Hive.box<ClassesModel>('classes').delete(id);
      return Future.value((null, null) );
    }catch(e){
      return Future.value((Exception(e.toString()), null));
    }
  }

  @override
  Future<(Exception?, void)> deleteTeacher(String id) {
    try{
      Hive.box<TeacherModel>('teachers').delete(id);
      return Future.value((null, null) );
    }catch(e){
      return Future.value((Exception(e.toString()), null));
    }
  }

  @override
  Future<(Exception?, List<ClassesModel>?)> getClasses() {
    try{
      List<ClassesModel> classes = Hive.box<ClassesModel>('classes').values.toList();
      return Future.value((null, classes) );
    }catch(e){
      return Future.value((Exception(e.toString()), null));
    }
  }

  @override
  Future<(Exception?, List<TeacherModel>?)> getTeachers() {
    try{
      List<TeacherModel> teachers = Hive.box<TeacherModel>('teachers').values.toList();
      return Future.value((null, teachers) );
    }catch(e){
      return Future.value((Exception(e.toString()), null));
    }
  }

  @override
  Future<void> init()async {
    String path = Directory('${Directory.current.path}/Database').path;
    await Hive.initFlutter(path);
    Hive.registerAdapter(TeacherModelAdapter());
    Hive.registerAdapter(ClassesModelAdapter());
    Hive.registerAdapter(TableModelAdapter());
    await Hive.openBox<TeacherModel>('teachers');
    await Hive.openBox<ClassesModel>('classes');
    await Hive.openBox<TableModel>('tables');

  }

  @override
  Future<(Exception?, void)> saveClass(ClassesModel classes) {
    try{
      Hive.box<ClassesModel>('classes').put(classes.id, classes);
      return Future.value((null, null) );
    }catch(e){
      return Future.value((Exception(e.toString()), null));
    }
  }

  @override
  Future<(Exception?, void)> saveTeacher(TeacherModel teacher) {
    try{
      Hive.box<TeacherModel>('teachers').put(teacher.id, teacher);
      return Future.value((null, null) );
    }catch(e){
      return Future.value((Exception(e.toString()), null));
    }
  }

  @override
  Future<(Exception?, void)> updateClass(ClassesModel classes) {
    //delect existing class and save new one
    try{
      Hive.box<ClassesModel>('classes').delete(classes.id);
      Hive.box<ClassesModel>('classes').put(classes.id, classes);
      return Future.value((null, null) );
    }catch(e){
      return Future.value((Exception(e.toString()), null));
    }
  }

  @override
  Future<(Exception?, void)> updateTeacher(TeacherModel teacher) {
    //delect existing teacher and save new one
    try{
      Hive.box<TeacherModel>('teachers').delete(teacher.id);
      Hive.box<TeacherModel>('teachers').put(teacher.id, teacher);
      return Future.value((null, null) );
    }catch(e){
      return Future.value((Exception(e.toString()), null));
    }
  }
  
  }