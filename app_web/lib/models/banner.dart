import 'dart:convert';

class BannerModel {
  final String id;
  final String image;

  BannerModel({required this.id, required this.image});

  // Serialization: Convert BannerModel object to a map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'image': image};
  }

  // Serialization: Convert map to json string
  String toJson() => json.encode(toMap());

  // Deserialization: Convert a map to a BannerModel object
  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'] as String? ?? '',
      image: map['image'] as String? ?? '',
    );
  }

  // Deserialization: Decode json string into a BannerModel object
  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
