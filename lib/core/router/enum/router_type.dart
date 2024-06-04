enum RouterType {
  launch('/', '/'),
  home('/home', 'home'),
  editor('/editor', 'editor');

  final String absolutePath;

  final String relativePath;

  const RouterType(this.absolutePath, this.relativePath);
}
