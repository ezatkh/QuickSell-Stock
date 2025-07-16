import 'package:flutter/material.dart';

import '../../../../Models/ItemModel.dart';

class ProductCard extends StatelessWidget {
  final ItemModel item; // Changed to accept StoreItemModel instead of Map
  final VoidCallback onTap;

  const ProductCard({required this.item, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Default base sizes
    double baseTitleFontSize = 16;
    double basePriceFontSize = 14;
    double baseSubFontSize = 12;
    double baseBorderRadius = 12;

    double baseWidth = 390;
    double scale = screenWidth / baseWidth;
    scale = scale.clamp(0.70, 1.2);
    // Apply scaling
    double titleFontSize = baseTitleFontSize * scale;
    double priceFontSize = basePriceFontSize * scale;
    double subFontSize = baseSubFontSize * scale;
    double borderRadius = baseBorderRadius * scale;

    final itemName = item.itemName?.trim();
    final showItemName = itemName != null && itemName.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showItemName)
                Text(
                  itemName,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              Text(
                "${item.sellingPrice}",
                style: TextStyle(
                  fontSize: priceFontSize,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${item.purchasePrice}",
                style: TextStyle(
                  fontSize: subFontSize,
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
