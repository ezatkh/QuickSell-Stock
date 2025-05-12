import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constants/app_color.dart';
import '../../../../Services/LocalizationService.dart';

class CheckoutButton extends StatelessWidget {
  final VoidCallback onPressed;  // Add a parameter to accept onPressed function

  const CheckoutButton({super.key, required this.onPressed});  // Make onPressed required

  @override
  Widget build(BuildContext context) {
    var appLocalization = Provider.of<LocalizationService>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,  // Use the passed in onPressed function
        child: Text(
          '${appLocalization.getLocalizedString("submit")} 🛒',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
