class TreeButton {
  TreeButton({
    required this.title,
    this.subButtons = const [],
    this.subHeight = 0,
  });

  String title;
  List<TreeButton> subButtons;
  double subHeight;
}
