class ItemModel {
  final String title;
  final String description;
  final String? imagePath;
  final String? createAt;

  ItemModel({
    required this.title,
    required this.description,
     this.imagePath,
     this.createAt,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
      title: 'title',
      description: 'description',
      imagePath: 'image',
      createAt: 'createAt');
}
