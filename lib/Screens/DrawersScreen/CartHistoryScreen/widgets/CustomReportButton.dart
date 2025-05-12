import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constants/app_color.dart';
import '../../../../Services/LocalizationService.dart';

class CustomReportButton extends StatelessWidget {
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;

  const CustomReportButton({
    super.key,
    required this.onPressed1,
    required this.onPressed2,
  });

  @override
  Widget build(BuildContext context) {
    var appLocalization = Provider.of<LocalizationService>(context, listen: false);

    return SingleChildScrollView(  // Make the screen scrollable if elements exceed height
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildButtonRow(appLocalization,'assets/images/expenseIcon.png', appLocalization.getLocalizedString("expensesReport"), onPressed1),
            const SizedBox(height: 20),
            _buildButtonRow(appLocalization,'assets/images/salesIcon.png', appLocalization.getLocalizedString("salesReport"), onPressed2),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(LocalizationService appLocalization, String imagePath, String text, VoidCallback onPressed) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: AppColors.backgroundColor,
        child: InkWell(
          onTap: onPressed,
          splashColor: AppColors.primaryColor.withOpacity(0.1),
          highlightColor: AppColors.primaryColor.withOpacity(0.05),
          child: Container(
            height: 140,
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                const SizedBox(width: 12),
                Align(
                  alignment: appLocalization.selectedLanguageCode == 'en'
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    margin: appLocalization.selectedLanguageCode == 'en'
                        ? const EdgeInsets.only(left: 12)
                        : const EdgeInsets.only(right: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        imagePath,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 20), // مسافة بين الصورة والنص

                Expanded(
                  child: Center(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
