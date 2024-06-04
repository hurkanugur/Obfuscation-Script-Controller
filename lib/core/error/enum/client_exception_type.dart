enum ClientExceptionType {
  folderNotFoundError('FOLDER_NOT_FOUND_ERROR'),
  fileNotFoundError('FILE_NOT_FOUND_ERROR'),
  fileReadOperationError('FILE_READ_OPERATION_ERROR'),
  nullPointerError('NULL_POINTER_ERROR'),
  colorNotFoundError('COLOR_NOT_FOUND_ERROR'),
  translationNotFoundError('TRANSLATION_NOT_FOUND_ERROR'),
  translationUpdateError('TRANSLATION_UPDATE_ERROR'),
  stringOperationError('STRING_OPERATION_ERROR'),
  enumNotFoundError('ENUM_NOT_FOUND_ERROR');

  final String name;

  const ClientExceptionType(this.name);
}
