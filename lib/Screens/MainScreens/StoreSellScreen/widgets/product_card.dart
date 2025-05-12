import 'package:flutter/material.dart';

import '../../../../Models/ItemModel.dart';

class ProductCard extends StatelessWidget {
  final ItemModel item; // Changed to accept StoreItemModel instead of Map
  final VoidCallback onTap;

  const ProductCard({required this.item, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(item.itemName != null || item.itemName.toString() !='null' || item.itemName.toString().trim() != "")
              Text(
                "${item.itemName}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${item.sellingPrice}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${item.purchasePrice}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
