import 'package:uuid/uuid.dart';

class ItemCart {
  int id;
  double purchasePrice; // Price when the item is purchased
  double sellingPrice; // Price at which the item is being sold
  int quantity; // Number of items in the cart
  final String guid;
  int? orderId;  // Optional orderId field, can be null
  String? itemName;  // Optional orderId field, can be null
  int? itemSizeId;
  String? itemSizeName;

  ItemCart({
    required this.id,  // Optional id parameter
    required this.purchasePrice, // Accept purchase price
    required this.sellingPrice, // Accept selling price
    this.itemSizeId,
    this.itemSizeName,
    this.quantity = 1,  // Default quantity is 1
    this.orderId,  // Optional orderId, defaults to null if not provided
    this.itemName,  // Optional orderId, defaults to null if not provided

  }) : guid = const Uuid().v4();

  // Create an ItemCart object from JSON
  factory ItemCart.fromJson(Map<String, dynamic> json) {
    return ItemCart(
      id: json["id"],  // Extract id from JSON
      purchasePrice: json["purchasePrice"],  // Extract purchase price
      sellingPrice: json["sellingPrice"],  // Extract selling price
      quantity: json["quantity"],  // Default quantity is 1 if null
      itemName: json["ItemName"] ?? " ",
    );
  }

  factory ItemCart.fromOrderItemJson(Map<String, dynamic> json) {
    return ItemCart(
      id:-1,  // Default to 0 if null
      purchasePrice: (json["ActualPrice"] as num?)?.toDouble() ?? 0.0,  // Convert to double, default to 0.0 if null
      sellingPrice: (json["UnitPrice"] as num?)?.toDouble() ?? 0.0,  // Convert to double, default to 0.0 if null
      quantity: json["Qty"] ?? 0,  // Default to 0 if null
      orderId: int.tryParse(json["OrderID"]?.toString() ?? '') ?? -1,
      itemName: json["ItemName"] ?? " ",
      itemSizeName: json["SizeLabel"] ?? "N/A",
    );
  }


  @override
  String toString() {
    return 'ItemCart{id: $id, purchasePrice: $purchasePrice, sellingPrice: $sellingPrice, quantity: $quantity}';
  }
}
