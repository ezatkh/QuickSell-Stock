import 'package:flutter/material.dart';
import '../Models/ExpensesItemModel.dart';

class HistoryExpenseState extends ChangeNotifier {
  List<ExpensesItemModel> _expenses = [];  // Change the list type to ExpensesItemModel
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<ExpensesItemModel> get expenses => _expenses;  // Return expenses instead of carts
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Setter for expenses
  set expenses(List<ExpensesItemModel> newExpenses) {
    _expenses = newExpenses;
    notifyListeners();  // Notify listeners that the state has changed
  }

  // Clear the entire state (for logout)
  void clearState() {
    _expenses = [];  // Clear expenses
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
