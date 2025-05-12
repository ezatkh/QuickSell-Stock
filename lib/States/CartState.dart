import 'package:flutter/material.dart';
import '../Models/CartModel.dart';
import '../Models/ItemCartModel.dart';

class CartState extends ChangeNotifier {
  // State Properties
  List<ItemCart> _itemsList = [];
  double _totalPrice = 0.0;
  String? _selectedItemId;

  // Getters to access state properties
  List<ItemCart> get itemsList => _itemsList;
  double get totalPrice => _totalPrice;
  String? get selectedItemId => _selectedItemId; // Getter for selected item ID

  /// 2️⃣ Add Store Item to Cart
  void addStoreItem(ItemCart itemCart) {
    itemsList.add(itemCart);
    _updateCartTotals();
  }

  /// 3️⃣ Update Quantity of Store Item
  void updateQuantityStoreItem({required String guid, required int quantity}) {
    for (var item in itemsList) {
      if (item.guid == guid) {
        item.quantity += quantity; // Adjust quantity
        if (item.quantity < 1) item.quantity = 1; // Ensure quantity doesn't go below 1
        break;
      }
    }
    _updateCartTotals();
  }

  /// 6️⃣ Delete Item from cart by ID
  void deleteItemCart(String guid) {
    itemsList.removeWhere((item) => item.guid == guid);
    _selectedItemId = null;
    _updateCartTotals();
  }

  /// 7️⃣ Clear Cart (Empty Items List & Reset Totals)
  void clearState() {
    _itemsList.clear();
    _totalPrice = 0.0;
    _selectedItemId = null; // Reset selected item when cart is cleared
    notifyListeners();
  }

  /// 8️⃣ Select an Item
  void selectItem(String guid) {
    // Update the selected item
    if (_selectedItemId == guid) {
      _selectedItemId = null; // Deselect the item if it's already selected
    } else {
      _selectedItemId = guid; // Set the new selected item
    }
    notifyListeners();
  }

  /// 🔄 Update Total Price & Items Count
  void _updateCartTotals() {
    _totalPrice = itemsList.fold(0, (sum, item) => sum + (item.sellingPrice * item.quantity));
    notifyListeners();
  }

  /// Clear the selected item ID
  void clearSelectedItem() {
    _selectedItemId = null; // Set selected item ID to null
    notifyListeners(); // Notify listeners of the change
  }
}
