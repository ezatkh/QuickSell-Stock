import 'package:flutter/material.dart';
import '../../../Constants/app_color.dart';
import '../../../Services/LocalizationService.dart';
import '../LoginScreen.dart'; // Ensure this import is correct

class CustomDropDown extends StatelessWidget {
  final LocalizationService localizationService;

  CustomDropDown({Key? key, required this.localizationService}) : super(key: key);

  String getLanguageName(String code) {
    // Function to return the language name based on the language code
    for (var language in LoginScreen.languages) {
      if (language['code'] == code) {
        return language['name']!;
      }
    }
    return ''; // Return empty string if language code not found (should not happen in ideal scenarios)
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          // Open the PopupMenu when the Row is tapped
          final dynamic state = context.findRenderObject();
          state.showButtonMenu();
        },
        child: PopupMenuButton<String>(
          onSelected: (String newValue) {
            localizationService.selectedLanguageCode = newValue;
          },
          itemBuilder: (BuildContext context) {
            return LoginScreen.languages.map((Map<String, String> language) {
              return PopupMenuItem<String>(
                value: language['code']!,
                child: ListTile(
                  title: Text(
                    language['name']!,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              );
            }).toList();
          },
          child: Row(
            children: [
              Icon(Icons.language, color: AppColors.cardBackgroundColor,),
              SizedBox(width: 8.0),
          Text(
            getLanguageName(localizationService.selectedLanguageCode),
            style: TextStyle(
              color: AppColors.cardBackgroundColor, // Set the text color to primary text color
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
