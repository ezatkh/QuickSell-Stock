import 'package:flutter/material.dart';
import '../Models/CartModel.dart';

class HistoryCartState extends ChangeNotifier {
  List<CartModel> _carts = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<CartModel> get carts => _carts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Setter for carts
  set carts(List<CartModel> newCarts) {
    _carts = newCarts;
    notifyListeners();  // Notify listeners that the state has changed
  }

  // Clear the entire state (for logout)
  void clearState() {
    _carts = [];
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
