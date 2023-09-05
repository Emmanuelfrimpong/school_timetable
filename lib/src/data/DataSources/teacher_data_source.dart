import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_timetable/src/data/models/teachers/teacher_model.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/text_style.dart';
import '../../core/widgets/smart_dialog.dart';
import '../../presentation/riverpod/teachers_services.dart';

class TeacherDataSource extends DataTableSource {
  final WidgetRef ref;
  TeacherDataSource(this.ref);
  
  @override
  DataRow? getRow(int index) {
    var data = ref.watch(filteredTeacherListProvider);
    var selectedTeachers = ref.watch(selectedTeacherProvider);
    if (index >= data.length) return null;
    final teacherItem = data[index];
    return DataRow.byIndex(
        selected: selectedTeachers.contains(teacherItem),
        onSelectChanged: (value) {
          if (value!) {
            ref.read(selectedTeacherProvider.notifier).addTeacher(teacherItem);
          } else {
            selectedTeachers.remove(teacherItem);
            ref.read(selectedTeacherProvider.notifier).removeTeacher(teacherItem);
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
            } else if (selectedTeachers.contains(teacherItem)) {
              return Colors.blue.withOpacity(.7);
            }
            return null;
          },
        ),
        index: index,
        cells: [
          //show Checkbox
          if (selectedTeachers.contains(teacherItem))
            DataCell(ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 50),
              child: IconButton(
                onPressed: () {
                  CustomDialog.showInfo(
                      title: 'Delete Teacher',
                      message: 'Are you sure you want to delete this teacher?',
                      onConfirmText: 'Delete',
                      onConfirm: () {
                        deleteTeacher(teacherItem);
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
          DataCell(Text('${teacherItem.name}',
            style: kTitleTextStyle(color: primaryColor),)),
          DataCell(Text('${teacherItem.subject}',
            style: kTitleTextStyle(color: primaryColor),)),
          DataCell(Text(teacherItem.classesCode!.join(', ').toString( ),
            style: kTitleTextStyle(color: primaryColor),)),
        ]);
  }
  
  @override
  bool get isRowCountApproximate => false;
  
  @override
  int get rowCount => ref.watch(filteredTeacherListProvider).length;
  
  @override
  int get selectedRowCount =>0;

  void deleteTeacher(TeacherModel teacherItem) {
    ref.read(teachersListProvider.notifier).removeTeacher(teacherItem);
    ref.read(selectedTeacherProvider.notifier).removeTeacher(teacherItem);
  }
}