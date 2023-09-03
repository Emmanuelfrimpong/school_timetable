import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_timetable/src/data/models/teachers/teacher_model.dart';
import '../../core/widgets/smart_dialog.dart';
import '../../domain/usercases/import_data_usercase.dart';

final teachersListProvider =
    StateNotifierProvider<TeachersListNotifier, List<TeacherModel>>((ref) {
  return TeachersListNotifier();
});

class TeachersListNotifier extends StateNotifier<List<TeacherModel>> {
  TeachersListNotifier() : super(ImportDataUseCase().getTeachers()) {
    getTeacher();
  }
  final ImportDataUseCase importDataUseCase = ImportDataUseCase();

// get classes from hive
  void getTeacher() {
    state = importDataUseCase.getTeachers();
  }

  void addTeacher(TeacherModel teacher) {
    state = [...state, teacher];
  }

  void removeTeacher(TeacherModel teacher) {
    //delete class from hive
    importDataUseCase.deleteTeacher(teacher);
    state = state.where((element) => element.name != teacher.name).toList();
  }

  void clear() {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Deleting Teachers');
    importDataUseCase.clearTeachers();
    state = [];
    CustomDialog.showSuccess(
        title: 'Success', message: 'Teachers Deleted Successfully');
    CustomDialog.dismiss();
  }
}

final selectedTeacherProvider =
    StateNotifierProvider<SelectedTeachersNotifier, List<TeacherModel>>((ref) {
  return SelectedTeachersNotifier();
});

class SelectedTeachersNotifier extends StateNotifier<List<TeacherModel>> {
  SelectedTeachersNotifier() : super([]);

  void addTeacher(TeacherModel teacher) {
    state = [...state, teacher];
  }

  void removeTeacher(TeacherModel teacher) {
    state = state.where((element) => element.name != teacher.name).toList();
  }
}

final teacherSearchProvider = StateProvider<String?>((ref) {
  return '';
});
final filteredTeacherListProvider = StateProvider<List<TeacherModel>>((ref) {
  final query = ref.watch(teacherSearchProvider);
  final teacherList = ref.watch(teachersListProvider);
  if (query == null || query.isEmpty) return teacherList;
  return teacherList
      .where((element) =>
          element.name!.toLowerCase().contains(query.toLowerCase()) ||
          element.subject!.toLowerCase().contains(query.toLowerCase()))
      .toList();
});

final teacherImportProvider =
    StateNotifierProvider<TeachersImportNotifier, void>((ref) {
  return TeachersImportNotifier();
});

class TeachersImportNotifier extends StateNotifier<void> {
  TeachersImportNotifier() : super(null);
  final ImportDataUseCase importDataUseCase = ImportDataUseCase();
  Future<void> importTeachers(WidgetRef ref) async {
    final (exception, path) = await importDataUseCase.pickExcelFIle();
    if (exception != null) {
      CustomDialog.showError(message: exception.toString(), title: 'Error');
      return;
    }
    CustomDialog.showLoading(message: 'Importing Teachers...');
    if (path == null) return;
    final (exception2, data) = await importDataUseCase.readExcelData(path);
    if (exception2 != null) {
      CustomDialog.dismiss();
      CustomDialog.showError(message: exception2.toString(), title: 'Error');
      return;
    }
    if (data == null) return;
    final (exception3, bool) =
        await importDataUseCase.validateTeachersFile(data);
    if (exception3 != null) {
      CustomDialog.dismiss();
      CustomDialog.showError(message: exception3.toString(), title: 'Error');
      return;
    }
    if (bool == false) return;
    final (exception4, teachers) =
        await importDataUseCase.getTeachersData(data);
    if (exception4 != null) {
      CustomDialog.showError(message: exception4.toString(), title: 'Error');
      return;
    }
    if (teachers == null) return;
    final excepption = await importDataUseCase.saveTeachers(teachers);
    if (excepption != null) {
      CustomDialog.dismiss();
      CustomDialog.showError(message: excepption.toString(), title: 'Error');
      return;
    }
    ref.read(teachersListProvider.notifier).getTeacher();
    CustomDialog.dismiss();
    CustomDialog.showSuccess(
        message: 'Teachers Imported Successfully', title: 'Success');
  }

  void downloadTemplate() {
    importDataUseCase.createTeachersTemplate();
  }
}
