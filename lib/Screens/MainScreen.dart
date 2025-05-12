import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants/app_color.dart';
import '../Constants/app_routeTransition.dart';
import '../Custom_Components/CustomLoadingAvatar.dart';
import '../Custom_Components/CustomPopups.dart';
import '../Services/LocalizationService.dart';
import '../States/LoginState.dart';
import '../States/StoreState.dart';
import 'DrawersScreen/CartHistoryScreen/CartHistoryScreen.dart';
import 'DrawersScreen/ReportScreen/ReportScreen.dart';
import 'MainScreens/CartScreen/CartScreen.dart';
import 'MainScreens/ExpenseScreen/ExpenseScreen.dart';
import 'MainScreens/StoreSellScreen/StoreSellScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      StoreSellScreen(),
      OtherSellScreen(),
      CartScreen(),
    ];

  }



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appLocalization = Provider.of<LocalizationService>(context, listen: false);
    final storesState = Provider.of<StoresState>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text("${storesState.selectedStore?["address"]}" ?? "Main Screen"),
        backgroundColor: AppColors.cardBackgroundColor,
        elevation: 1,
      ),
      body: _screens[_selectedIndex], // Display the selected screen
      drawer: _buildDrawer(context,appLocalization),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07), // Shadow color
              spreadRadius: 0, // Spread of the shadow
              blurRadius: 10, // Blur effect
              offset: Offset(0, -3), // Offset for the shadow (top shadow)
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.primaryTextColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          backgroundColor: AppColors.cardBackgroundColor,
          onTap: _onItemTapped,
          items:  [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.store, size: 20),
              label: appLocalization.getLocalizedString("sales"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sell, size: 20),
              label:  appLocalization.getLocalizedString("expenses"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, size: 20),
              label: appLocalization.getLocalizedString("cart"),
            ),
          ],
        ),
      ),
    );
  }

  // Use FutureBuilder to handle async data
  FutureBuilder<String?> _buildDrawer(BuildContext context,LocalizationService appLocalization) {
    return FutureBuilder<String?>(
      future: _getUserName(), // Fetch username from SharedPreferences
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Drawer(
            child: Center(child: CircularProgressIndicator()),
          ); // Loading state
        } else if (snapshot.hasError) {
          return Drawer(
            child: Center(child: Text(appLocalization.getLocalizedString("errorLoadingData"))),
          ); // Error state
        } else if (snapshot.hasData) {
          final userName = snapshot.data;

          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text("   $userName" ?? '****'),
                  accountEmail: Text(""),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: AppColors.backgroundColor,
                    child: Icon(Icons.person, size: 50, color: Colors.black),
                  ),
                  decoration: const BoxDecoration(color: AppColors.primaryColor),
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text(appLocalization.getLocalizedString("historyCart")),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      AppRouteTransition(page: CartHistoryScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.bar_chart),
                  title: Text(appLocalization.getLocalizedString("report")),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      AppRouteTransition(page: ReportScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text(appLocalization.getLocalizedString("changeLanguage")),
                  onTap: () async {
                    showLoadingAvatar(context);
                    await Future.delayed(Duration(seconds: 1));
                    String currentLang = appLocalization.selectedLanguageCode;
                    String newLang = currentLang == 'en' ? 'ar' : 'en';
                    appLocalization.selectedLanguageCode = newLang;
                    Navigator.popUntil(context, (route) => false);  // This will pop all routes
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),  // Push the CartScreen
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(appLocalization.getLocalizedString("logout")),
                  onTap: () {
                    // Show the custom dialog to confirm logout
                    CustomPopups.showCustomDialog(
                      context: context,
                      icon: Icon(Icons.exit_to_app, size: 40, color: AppColors.secondaryColor), // Custom icon for logout
                      title: appLocalization.getLocalizedString("logoutConfirmationTitle"), // Title for the popup
                      message: appLocalization.getLocalizedString("logoutConfirmationBody"),
                      deleteButtonText: appLocalization.getLocalizedString("logout"), // Button to confirm logout
                      onPressButton: () {
                        showLoadingAvatar(context);

                        Future.delayed(const Duration(milliseconds: 1000), () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Provider.of<LoginState>(context, listen: false).logout(context);
                        });
                      },

                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return Drawer(
            child: Center(child: Text(appLocalization.getLocalizedString("noDataAvailable"))),
          ); // No data state
        }
      },
    );
  }

  // Method to get the username from SharedPreferences
  Future<String?> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username'); // Fetch the username
  }}