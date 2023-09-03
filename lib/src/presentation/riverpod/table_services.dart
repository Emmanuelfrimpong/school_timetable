import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/tables/table_model.dart';
import '../../domain/usercases/import_data_usercase.dart';

final tableListProvider = StateNotifierProvider<TableListNotifier, List<TableModel>>((ref) {
  return TableListNotifier();
});

class TableListNotifier extends StateNotifier<List<TableModel>> {
  TableListNotifier() : super(ImportDataUseCase().getTables()) {
    getTables();
  }
  final ImportDataUseCase importDataUseCase = ImportDataUseCase();
  
  void getTables() {
    state = importDataUseCase.getTables();
  }

}