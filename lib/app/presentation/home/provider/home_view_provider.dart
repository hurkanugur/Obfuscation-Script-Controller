import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/presentation/home/controller/home_view_controller.dart';

class HomeViewProvider {
  const HomeViewProvider._();

  static final homeViewProvider = StateNotifierProvider<HomeViewController, HomeViewState>(
    (ref) => HomeViewController(),
  );
}
