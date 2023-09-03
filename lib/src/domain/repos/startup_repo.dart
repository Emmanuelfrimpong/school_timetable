import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class OnStartUpRepo{
  Future<void> init(WidgetRef ref);
}