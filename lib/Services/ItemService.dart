import 'package:flutter/cupertino.dart';
import '../Constants/api_constants.dart';
import '../Models/ItemModel.dart';
import './api_request.dart';

class ItemService {
  static Future<List<ItemModel>> fetchItems(BuildContext context,int storeId) async {

    final response = await ApiRequest.get(
        "${ApiConstants.fetchStoreItemsEndPoint}/${storeId}", context: context
    );
    if (response['success']) {
      List<dynamic> data = response['data'];
      return data.map((json) => ItemModel.fromJson(json)).toList();
    } else {
      throw Exception(response['error']);
    }
  }


}