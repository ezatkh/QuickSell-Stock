import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/api_constants.dart';
import '../Models/ExpensesItemModel.dart';
import '../Utils/idempotency_helper.dart';
import './api_request.dart';

class ExpensesService {
  static Future<List<ExpensesItemModel>> fetchExpenses(BuildContext context) async {

    final response = await ApiRequest.get(
      "${ApiConstants.fetchExpensesEndPoint}",
      context: context,  // context is passed correctly here
    );

    if (response['success']) {
      List<dynamic> data = response['data'];
      return data.map((json) => ExpensesItemModel.fromExpensesTypeJson(json)).toList();
    } else {
      throw Exception(response['error']);
    }
  }

  static Future<List<ExpensesItemModel>> fetchHistoryExpenses(BuildContext context,String startDate,String enddate) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final response = await ApiRequest.get(
      "${ApiConstants.fetchHistoryExpensesEndPoint}?startDate=${startDate}&endDate=${enddate}",
      context: context,  // context is passed correctly here
    );

    if (response['success']) {
      List<dynamic> data = response['data'];
      return data.map((json) => ExpensesItemModel.fromJson(json)).toList();
    } else {
      throw Exception(response['error']);
    }
  }

  static Future<bool> createExpenseOrder(BuildContext context, int id, String desc, int price) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? 'token';

    final requestOrderData = {
      "ExpID": id,
      "ExpDesc": desc,
      "TotalPrice": price,
    };

    try {
      final response = await ApiRequest.post(
        "${ApiConstants.createExpenseOrdersEndPoint}",
        requestOrderData,
        context: context,
      );

      // Check if the response indicates success
      if (response['success']) {
        return true; // Return true if the response is successful
      } else {
        // If not success, throw an exception with the error
        throw Exception(response['error']);
      }
    } catch (e) {
      // Catch any errors and log them, also return false
      debugPrint("Error occurred while creating expense order: $e");
      return false;
    }
  }
}
