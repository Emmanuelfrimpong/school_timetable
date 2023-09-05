import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_timetable/src/core/widgets/smart_dialog.dart';
import 'package:school_timetable/src/data/models/classes/classes_model.dart';
import 'package:school_timetable/src/domain/usercases/import_data_usercase.dart';

final classesListProvider =
    StateNotifierProvider<ClassesListNotifier, List<ClassesModel>>((ref) {
  return ClassesListNotifier();
});


class ClassesListNotifier extends StateNotifier<List<ClassesModel>> {
  ClassesListNotifier() : super(ImportDataUseCase().getClasses()) {
    getClasses();
  }
   final ImportDataUseCase importDataUseCase = ImportDataUseCase();

// get classes from hive
  void getClasses() {
    state= importDataUseCase.getClasses();
  }

  void addClass(ClassesModel classes) {
    state = [...state, classes];
  }

  void removeClass(ClassesModel classes) {
    //delete class from hive
    importDataUseCase.deleteClass(classes);
    state = state
        .where((element) => element.className != classes.className)
        .toList();
  }

  void updateClass(ClassesModel classes) {
    state = state
        .map((e) => e.className == classes.className ? classes : e)
        .toList();
  }

  void clear() {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Deleting Class');
     importDataUseCase.clearClasses();
    state = [];
    CustomDialog.showSuccess(title: 'Success', message: 'Classes Deleted Successfully');
    CustomDialog.dismiss();

  }
}

final selectedClassProvider = StateNotifierProvider<SelectedClassesNotifier,List<ClassesModel>>((ref) {
  return SelectedClassesNotifier();
});

class SelectedClassesNotifier extends StateNotifier<List<ClassesModel>> {
  SelectedClassesNotifier() : super([]);

  void addClass(ClassesModel classes) {
    state = [...state, classes];
  }

  void removeClass(ClassesModel classes) {
    state = state
        .where((element) => element.className != classes.className)
        .toList();
  }

  void clear() {
    state = [];
  }
}

final classSearchProvider = StateProvider<String?>((ref) {
  return '';
});
final filteredClassListProvider = StateProvider<List<ClassesModel>>((ref) {
  final query = ref.watch(classSearchProvider);
  final classesList = ref.watch(classesListProvider);
  if(query == null || query.isEmpty) return classesList;
  return classesList
      .where((element) =>
          element.className!.toLowerCase().contains(query!.toLowerCase()) ||
          element.classCode!.toLowerCase().contains(query.toLowerCase()))
      .toList();
});

final classesImportProvider= StateNotifierProvider<ClassesImportNotifier, void>((ref){
  return ClassesImportNotifier();

});

class ClassesImportNotifier extends StateNotifier<void>{
  ClassesImportNotifier() : super(null);
  final ImportDataUseCase importDataUseCase = ImportDataUseCase();
  Future<void> importClasses(WidgetRef ref) async {
   
    final (exception, path) = await importDataUseCase.pickExcelFIle();
    if (exception != null) {
      CustomDialog.dismiss();
      CustomDialog.showError(title: 'Error', message: exception.toString());
    }else{
       CustomDialog.showLoading(message: 'Importing Classes...');
      final (exception, excel) = await importDataUseCase.readExcelData(path);
      if (exception != null) {
         CustomDialog.dismiss();
        CustomDialog.showError(title: 'Error', message: exception.toString());
      }else{
        final (exception, bool) = await importDataUseCase.validateClassesFile(excel);
        if (exception != null) {
           CustomDialog.dismiss();
          CustomDialog.showError(title: 'Error', message: exception.toString());
        }else{
          final (exception, classes) = await importDataUseCase.getClassesData(excel);
          if (exception != null) {
             CustomDialog.dismiss();
            CustomDialog.showError(title: 'Error', message: exception.toString());
          }else{
            final (exception) = await importDataUseCase.saveClasses(classes!);
            if (exception != null) {
               CustomDialog.dismiss();
              CustomDialog.showError(title: 'Error', message: exception.toString());
            }else{
              ref.read(classesListProvider.notifier).getClasses();
               CustomDialog.dismiss();
              CustomDialog.showSuccess(title: 'Success', message: 'Classes Imported Successfully');
            }
          }
        }
      }
    }
  }

  void downloadTemplate() {
    importDataUseCase.createClassesTemplate();
  }
}

