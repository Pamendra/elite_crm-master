class ProfileItem {
  String name;
  String id;
  bool isSelected;

  ProfileItem({
    required this.name,
    required this.id,
    this.isSelected = false,
  });
}