import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_timetable/src/core/utils/text_style.dart';
import 'package:school_timetable/src/core/widgets/smart_dialog.dart';
import 'package:school_timetable/src/data/models/classes/classes_model.dart';
import 'package:school_timetable/src/presentation/riverpod/classes_services.dart';
import '../../core/utils/colors.dart';

class ClassesDataSource extends DataTableSource {
  final WidgetRef ref;
  ClassesDataSource(this.ref);
  @override
  DataRow? getRow(int index) {
    var data = ref.watch(filteredClassListProvider);
    var selectedClasses = ref.watch(selectedClassProvider);
    if (index >= data.length) return null;
    final classItem = data[index];
    return DataRow.byIndex(
        selected: selectedClasses.contains(classItem),
        onSelectChanged: (value) {
          if (value!) {
            ref.read(selectedClassProvider.notifier).addClass(classItem);
          } else {
            selectedClasses.remove(classItem);
            ref.read(selectedClassProvider.notifier).removeClass(classItem);
          }
        },
        color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            const Set<MaterialState> interactiveStates = <MaterialState>{
              MaterialState.pressed,
              MaterialState.hovered,
              MaterialState.focused,
            };

            if (states.any(interactiveStates.contains)) {
              return Colors.blue.withOpacity(.2);
            } else if (selectedClasses.contains(classItem)) {
              return Colors.blue.withOpacity(.7);
            }
            return null;
          },
        ),
        index: index,
        cells: [
          //show Checkbox
      if (selectedClasses.contains(classItem))
            DataCell(ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 50),
              child: IconButton(
                onPressed: () {
                  CustomDialog.showInfo(
                      title: 'Delete Class',
                      message: 'Are you sure you want to delete this class?',
                      onConfirmText: 'Delete',
                      onConfirm: () {
                        deleteClass(classItem);
                      });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ))
            else
            const DataCell(SizedBox()),
          DataCell(Text(
            classItem.classCode!,
            style: kTitleTextStyle(color: primaryColor),
          )),
          DataCell(Text(classItem.className!,
              style: kTitleTextStyle(color: primaryColor))),
          DataCell(Text(classItem.course!,
              style: kTitleTextStyle(color: primaryColor))),
          DataCell(Text(classItem.subjects!.join(', '),
              style: kTitleTextStyle(color: primaryColor))),
          // delete button when setected
        
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => ref.watch(filteredClassListProvider).length;

  @override
  int get selectedRowCount => 0;

  void deleteClass(ClassesModel classItem) {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Deleting Class...');
    ref.read(classesListProvider.notifier).removeClass(classItem);
    ref.read(selectedClassProvider.notifier).removeClass(classItem);
    CustomDialog.dismiss();
    CustomDialog.showSuccess(
        title: 'Success', message: 'Class deleted successfully');
  }
}
