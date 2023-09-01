import '../../data/models/classes/classes_model.dart';
import '../../data/models/teachers/teacher_model.dart';

abstract class HiveDatabaseRepo {
  Future<void> init();
  Future<(Exception?,void)> saveTeacher(TeacherModel teacher);
  Future<(Exception?,void)> saveClass(ClassesModel classes);
  Future<(Exception?,List<TeacherModel>?)> getTeachers();
  Future<(Exception?,List<ClassesModel>?)> getClasses();
  Future<(Exception?,void)> deleteTeacher(String id);
  Future<(Exception?,void)> deleteClass(String id);
  Future<(Exception?,void)> updateTeacher(TeacherModel teacher);
  Future<(Exception?,void)> updateClass(ClassesModel classes);
  Future<(Exception?,void)> clearTeachers();
  Future<(Exception?,void)> clearClasses();
  
}