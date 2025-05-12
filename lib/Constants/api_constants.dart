class ApiConstants {
  static const String baseUrl = 'https://testing99-a48017231505.herokuapp.com/api';
  static const String loginEndPoint = '$baseUrl/auth/login';
  static const String fetchStoresEndPoint = '$baseUrl/auth/Stores';
  static const String fetchExpensesEndPoint = '$baseUrl/GetExp';
  static const String fetchHistoryExpensesEndPoint = '$baseUrl/GetExpensesHistory';
  static const String fetchStoreItemsEndPoint = '$baseUrl/StoreItems'; // need query param
  static const String fetchItemSizesEndPoint = '$baseUrl/GetItemSizes'; // need query param
  static const String createOrderEndPoint = '$baseUrl/orders'; //create order items
  static const String fetchOrdersEndPoint = '$baseUrl/OrdersByDateRange';
  static const String creatGetOrderByIdEndPoint = '$baseUrl/OrderItemsByOrderId';
  static const String createExpenseOrdersEndPoint = '$baseUrl/CreateExpenses';
  static const String fetchTodayProfitReportEndPoint = '$baseUrl/GetDailtProfit';
  static const String fetchAllOrderItemsReportEndPoint = '$baseUrl/OrderItemsReport';


}