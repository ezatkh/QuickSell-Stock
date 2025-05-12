// lib/utils/validation_helper.dart

class ValidationHelper {
  // Validate email format
  static bool isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegExp.hasMatch(email);
  }

  // Validate phone number format (basic validation)
  static bool isValidPhoneNumber(String phoneNumber) {
    final RegExp phoneRegExp = RegExp(r'^[0-9]{10,15}$');
    return phoneRegExp.hasMatch(phoneNumber);
  }

  // Validate if a string is not empty
  static bool isNotEmpty(String value) {
    return value.isNotEmpty;
  }

  // Validate password (at least 8 characters, with at least 1 number and 1 letter)
  static bool isValidPassword(String password) {
    final RegExp passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return passwordRegExp.hasMatch(password);
  }

  // Validate URL format
  static bool isValidUrl(String url) {
    final RegExp urlRegExp = RegExp(
      r"^(https?|chrome):\/\/[^\s$.?#].[^\s]*$",
    );
    return urlRegExp.hasMatch(url);
  }
}
