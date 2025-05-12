class StoreModel {
  String storeId;
  String address;

  StoreModel({required this.storeId, required this.address});

  Map<String, dynamic> toJson() {
    return {
      "store": storeId,
      "address": address,
    };
  }

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
        storeId: json["store"] ?? "",
        address: json["address"] ?? ""
    );
  }

  @override
  String toString() {
    return 'StoreModel(storeId: $storeId, address: $address)';
  }
}