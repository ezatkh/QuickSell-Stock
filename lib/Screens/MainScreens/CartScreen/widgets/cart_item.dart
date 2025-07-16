import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the provider package
import '../../../../Constants/app_color.dart';
import '../../../../Models/ItemCartModel.dart';
import '../../../../States/CartState.dart';

class CartItem extends StatelessWidget {
  final ItemCart item;
  final bool isLastItem;

  const CartItem({
    super.key,
    required this.item,
    this.isLastItem = false,
  });

  @override
  Widget build(BuildContext context) {
    final cartState = Provider.of<CartState>(context);
    bool isSelected = cartState.selectedItemId == item.guid;
    final screenSize = MediaQuery.of(context).size;
    final scale = (screenSize.width / 390).clamp(0.70, 1.2);

    return GestureDetector(
      onTap: () {
        // Toggle item selection
        cartState.selectItem(item.guid);
      },
      child: Container(
        color: isSelected ? Colors.grey[300] : Colors.transparent, // Change color if selected
        child: Column(
          children: [
            Table(
              columnWidths: {
                0: FlexColumnWidth(1.5), // Make "Store" column wider
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(2), // Adjust quantity column
              },
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:22),
                      child: Center(
                        child: Text(
                          '${item.itemName}', // Price display
                          style: TextStyle(fontSize: 12 * scale, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:22),
                      child: Center(
                        child: Text(
                          '${item.sellingPrice}', // Price display
                          style: TextStyle(fontSize: 12 * scale, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:22),
                      child: Center(
                        child: Text(
                          '${item.purchasePrice}', // Price display
                          style: TextStyle(fontSize: 12 * scale, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Quantity text at the top
                            Text(
                              item.quantity.toString(),
                              style: TextStyle(fontSize: 12 * scale, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8), // Space between quantity and buttons
                            // Vertical stack of the icons
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cartState.updateQuantityStoreItem(
                                      guid: item.guid,
                                      quantity: -1,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    color: Color(0xFFFF7043),
                                    size: 20 * scale,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    cartState.updateQuantityStoreItem(
                                      guid: item.guid,
                                      quantity: 1,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    color: Color(0xFF009688),
                                    size: 20 * scale,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (!isLastItem)
              Divider(
                color: AppColors.primaryColor,
                thickness: 0.1,
              ),
          ],
        ),
      ),
    );
  }
}
