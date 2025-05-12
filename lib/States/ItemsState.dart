import 'package:flutter/material.dart';
import '../Models/ItemModel.dart';
import '../Services/ItemService.dart';

class ItemsState extends ChangeNotifier {
  List<ItemModel> _item = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<ItemModel> get items => _item;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch items from API
  Future<void> fetchItems(BuildContext context,int storeId) async {
    debugPrint("fetchItems started");
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      List<ItemModel> fetchedItems = await ItemService.fetchItems(context,storeId);
      _item = fetchedItems;
      debugPrint("fetchedItems :${_item.toString()}");

    } catch (e) {
      _errorMessage = "Failed to load items: $e";
      _item = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Clear items when logging out
  void clearItems() {
    _item = [];
    notifyListeners();
  }

  // Clear the entire state (for logout)
  void clearState() {
    _item = [];
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}