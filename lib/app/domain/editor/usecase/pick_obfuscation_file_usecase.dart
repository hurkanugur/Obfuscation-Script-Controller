import 'package:obfuscation_controller/app/data/editor/repository/editor_repository.dart';
import 'package:obfuscation_controller/core/base/model/operation_result.dart';

class PickObfuscationFileUseCase {
  final EditorRepository _editorRepository;

  const PickObfuscationFileUseCase({
    required EditorRepository editorRepository,
  }) : _editorRepository = editorRepository;

  Future<OperationResult<String?>> execute() async {
    return await _editorRepository.pickObfuscationFile();
  }
}
