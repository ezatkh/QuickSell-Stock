class ItemSizeModel {
  int clotheId;
  int sizeId;
  int quantity;
  String sizeLabel;

  ItemSizeModel({
    required this.clotheId,
    required this.sizeId,
    required this.quantity,
    required this.sizeLabel,
  });

  factory ItemSizeModel.fromJson(Map<String, dynamic> json) {
    return ItemSizeModel(
      clotheId: json["ClothesID"] != null ? int.parse(json["ClothesID"].toString()) : 0,
      sizeId: json["SizeID"] != null ? int.parse(json["SizeID"].toString()) : 0,
      quantity: json["Quantity"] != null ? int.parse(json["Quantity"].toString()) : 0,
      sizeLabel: json["SizeLabel"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ClotheId": clotheId,
      "SizeId": sizeId,
      "Quantity": quantity,
      "SizeLabel": sizeLabel,
    };
  }

  @override
  String toString() {
    return 'ItemSizeModel(clotheId: $clotheId, sizeId: $sizeId, quantity: $quantity, sizeLabel: $sizeLabel)';
  }
}
