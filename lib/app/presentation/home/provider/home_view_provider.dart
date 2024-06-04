import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/domain/editor/provider/editor_domain_layer_provider.dart';
import 'package:obfuscation_controller/app/presentation/home/controller/home_view_controller.dart';

class HomeViewProvider {
  const HomeViewProvider._();

  static final homeViewProvider = StateNotifierProvider<HomeViewController, HomeViewState>(
    (ref) => HomeViewController(
      pickObfuscationFileUseCase: ref.watch(EditorDomainLayerProvider.pickObfuscationFileUseCaseProvider),
      pickDependencyFolderUseCase: ref.watch(EditorDomainLayerProvider.pickDependencyFolderUseCaseUseCaseProvider),
    ),
  );
}
