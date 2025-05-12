import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../Screens/LoginScreen/LoginScreen.dart';
import '../Services/api_request.dart';
import '../Services/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../Constants/api_constants.dart';
import 'CartState.dart';
import 'ExpenseState.dart';
import 'ItemsState.dart';
import 'StoreState.dart';

class LoginState with ChangeNotifier {
  String _username = '';
  String _password = '';
  bool _isLoading = false;
  bool _loginSccessful = false;

  bool get loginSccessful => _loginSccessful;
  bool get isLoading => _isLoading;
  String get username => _username;
  String get password => _password;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void isLoginSccessful(bool loginSccessful) {
    _loginSccessful = loginSccessful;
    notifyListeners();
  }

  void setUsername(String username) {
    _username = username;
    print("Username set to: $_username");
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String username, String password,BuildContext context) async {
    Map<String, dynamic> map = {
      "username": username.trim(),
      "password": password,
    };
    print("Attempting login with username, password: $map");

    try {
      // Make POST request to login API
      final result = await ApiRequest.post(ApiConstants.loginEndPoint, map,context: context);

      // Check if the response contains a valid token
      if (result['success']) {
        // Check if the response contains a valid token
        if (result['data'] != null && result['data'].containsKey('token')) {
          String token = result['data']['token'].toString();
          String userId = result['data']['userId'].toString();

          // Store the username and token in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', username.toLowerCase());
          await prefs.setString('userId', userId);
          await prefs.setString('token', token);
          await prefs.setBool('isLoggedIn', true);

          print("Token stored successfully: $token");
          // Return success result
          return {
            'success': true,
            'status': 200,
          };
        } else {
          // Handle case where the token is not returned
          print("Login failed: Token not found in response.");
          return {
            'success': false,
            'error': 'Invalid credentials or unexpected response.',
            'status': 400,
          };
        }
      }
      else {
        // Handle case where the token is not returned
        print("Login failed: Token not found in response.");
        return {
          'success': false,
          'error': result['error'] ?? 'Unknown error occurred.',
          'status': result['status'] ?? 400,
        };
      }
    }
    catch (e) {
      print("Login failed: $e");
      return {
        'success': false,
        'error': 'An error occurred: $e',
        'status': 400,
      };
    }
  }

  Future<Map<String, dynamic>> autoLogin(BuildContext context) async {
    // Retrieve stored credentials
    Map<String, String?> credentials = await getCredentials();
    String? username = credentials['username'];
    String? password = credentials['password'];

    if (username != null && password != null) {
      print("Auto login attempt for: $username");

      // Attempt login with stored credentials
      var response = await login(username, password,context);

      if (response['success']) {
        print("Auto login successful!");
        _username = username;
        notifyListeners();
        print("data from login is L=:${response}");
        return response;
      } else {
        print("Auto login failed: ${response['error']}");
        await deleteCredentials(); // Clear invalid credentials
      }
    } else {
      print("No stored credentials found.");
    }
    return {
      'success': false,
      'error': 'Unknown error occurred.',
      'status': 400,
    };
  }
  // Clear the login state when logging out or resetting
  void clearState() {
    _username = '';
    _password = '';
    _loginSccessful = false;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    try {
      // Remove stored credentials from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token'); // Retrieve the stored token

      // Reset local state
      _username = '';
      _password = '';
      _loginSccessful = false;

      // Notify listeners to update the UI
      notifyListeners();

      if (token != null) {
          // Clear the token and username after successful logout
          await prefs.remove('username');
          await prefs.remove('token');
          print("Logged out successfully from server");

          // Clear the cart state using provider
          Provider.of<CartState>(context, listen: false).clearState(); // Clear the cart state
          Provider.of<LoginState>(context, listen: false).clearState(); // Clear the cart state
          Provider.of<StoresState>(context, listen: false).clearState(); // Clear the cart state
          Provider.of<ItemsState>(context, listen: false).clearState(); // Clear the cart state
          Provider.of<ExpenseState>(context, listen: false).clearState(); // Clear the cart state

          // Optionally navigate to the main screen or any other screen
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()), // Main screen or login screen
                (Route<dynamic> route) => false, // This removes all previous routes
          );
      } else {
        //needToDelete
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()), // Main screen or login screen
              (Route<dynamic> route) => false, // This removes all previous routes
        );
        print("No token found for logout");
      }
    } catch (e) {
      print("Logout failed: $e");
    }
  }


}
