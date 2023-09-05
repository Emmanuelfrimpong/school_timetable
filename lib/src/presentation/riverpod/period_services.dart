import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_timetable/src/data/models/period_model.dart';
import 'package:school_timetable/src/domain/usercases/import_data_usercase.dart';

final periodDataProvider= StateNotifierProvider<PeriodDataNotifier, List<PeriodModel>>((ref) {
  return PeriodDataNotifier();
});

class PeriodDataNotifier extends StateNotifier<List<PeriodModel>> {
  PeriodDataNotifier() : super(ImportDataUseCase().getPeriods()){
    getPeriods();
  }
  void addPeriod(PeriodModel period) {
    state = [...state, period];
  }

  void removePeriod(PeriodModel period) {
    state = state.where((element) => element.period != period.period).toList();
  }
  
  void getPeriods() {
    state = ImportDataUseCase().getPeriods();
  }
}

final singlePeriodProvider = StateNotifierProvider<SinglePeriodProvider, PeriodModel?>((ref) {
  return SinglePeriodProvider();
});

class SinglePeriodProvider extends StateNotifier<PeriodModel?> {
  SinglePeriodProvider() : super(PeriodModel());



}