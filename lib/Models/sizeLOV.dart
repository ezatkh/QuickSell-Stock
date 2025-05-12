class SizeLOV {
  int id;
  String name;

  SizeLOV({
    required this.id,
    required this.name,
  });

  factory SizeLOV.fromJson(Map<String, dynamic> json) {
    return SizeLOV(
      id: json["id"] != null ? int.parse(json["id"].toString()) : 0,
      name: json["name"] ?? " ",
    );
  }

  @override
  String toString() {
    return 'SizeLOV(id: $id, name: $name)';
  }
}
