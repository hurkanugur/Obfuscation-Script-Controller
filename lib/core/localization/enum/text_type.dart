enum TextType {
  applicationName('APPLICATION_NAME'),
  settings('SETTINGS'),
  languages('LANGUAGES'),
  english('ENGLISH'),
  turkish('TURKISH'),
  themes('THEMES'),
  lightTheme('LIGHT_THEME'),
  darkTheme('DARK_THEME'),
  dragAndDropObfuscationFile('DRAG_AND_DROP_OBFUSCATION_FILE'),
  dragAndDropDependencyFolder('DRAG_AND_DROP_DEPENDENCY_FOLDER'),
  noResultsFound('NO_RESULTS_FOUND'),
  obfuscationFile('OBFUSCATION_FILE'),
  dependencyFolder('DEPENDENCY_FOLDER'),
  clear('CLEAR'),
  start('START'),
  back('BACK'),
  refresh('REFRESH');

  final String name;

  const TextType(this.name);
}
