import 'package:excel/excel.dart';

abstract class ImportDataRepo {
  Future<(Exception?, String?)> pickExcelFIle();
  Future<(Exception?, Excel?)> readExcelData(String path);
  Future<(Exception?, bool)> validateClassesFile(Excel data);
  Future<(Exception?, bool)> validateTeachersFile(Excel data);
}
   