import 'dart:convert';

class Category {
  final String id;
  final String name;
  final String image;
  final String banner;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.banner,
  });

  // Serialization: Convert Category object to a map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'banner': banner,
    };
  }

  // Serialization: Convert map to json string
  String toJson() => json.encode(toMap());

  // Deserialization: Convert a map to a Category object
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['_id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      image: map['image'] as String? ?? '',
      banner: map['banner'] as String? ?? '',
    );
  }

  // Deserialization: Decode json string into a Category object
  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);
}
