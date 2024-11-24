class WorkEntity {
  final int id; // 
  final String craftsmanId;
  final String image; // رابط الصورة (download URL)
  final String title;
  final String description;
  final DateTime createdAt;

  WorkEntity({
    required this.id,
    required this.craftsmanId,
    required this.image,
    required this.title,
    required this.description,
    required this.createdAt,
  });
}
