import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_timetable/src/domain/repos/startup_repo.dart';
import 'package:school_timetable/src/presentation/riverpod/classes_services.dart';

class OnStartUpUseCase extends OnStartUpRepo{
  @override
  Future<void> init(WidgetRef ref) async{
  ref.watch(classesListProvider.notifier);
  }
}