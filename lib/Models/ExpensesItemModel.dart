import 'package:flutter/cupertino.dart';

class ExpensesItemModel {
  int id;
  String name;
  double price;
  DateTime? createdAt;

  // Constructor with expenseId and type
  ExpensesItemModel({
    required this.id,
    required this.name,
    required this.price,
    this.createdAt,
  });

  // Convert the ExpensesItemModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
    };
  }

  // Create an ExpensesItemModel object from JSON
  factory ExpensesItemModel.fromJson(Map<String, dynamic> json) {
    return ExpensesItemModel(
      id: json["ExpID"] != null ? json["ExpID"] as int : 0,
      name: (json["ExpDesc"] != null) ? json["ExpDesc"].toString() : "N/A",
      price: json["TotalPrice"] != null ? (json["TotalPrice"] as num).toDouble() : 0.0,
      createdAt: json["CreatedAT"] != null ? DateTime.parse(json["CreatedAT"]) : null,
    );
  }

  // Create an ExpensesItemModel object from JSON
  factory ExpensesItemModel.fromExpensesTypeJson(Map<String, dynamic> json) {
    return ExpensesItemModel(
      id: json["id"] != null ? json["id"] as int : 0,
      name: (json["name"] != null) ? json["name"].toString() : "N/A",
      price: json["price"] != null ? (json["price"] as num).toDouble() : 0.0,
    );
  }

  @override
  String toString() {
    return 'ExpensesItemModel{id: $id, name: $name, price: $price}';
  }
}
