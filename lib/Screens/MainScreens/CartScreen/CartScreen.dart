import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_sell/Screens/MainScreens/CartScreen/widgets/payment_method_popup.dart';
import '../../../Constants/app_color.dart';
import '../../../Custom_Components/CustomLoadingAvatar.dart';
import '../../../Custom_Components/CustomPopups.dart';
import '../../../Services/CartService.dart';
import '../../../Services/CheckConnectivity.dart';
import '../../../Services/LocalizationService.dart';
import '../../../States/CartState.dart';
import '../../LoginScreen/Custom_Widgets/CustomFailedPopup.dart';
import '../../MainScreen.dart';
import './widgets/cart_item.dart';
import './widgets/checkout_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appLocalization = Provider.of<LocalizationService>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Consumer<CartState>(
                  builder: (context, cartState, child) {
                    if (cartState.itemsList.isEmpty) {
                      // Display an empty cart message when no items exist
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              appLocalization.getLocalizedString("emptyCart"),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Column(
                      children: [
                        // Add header row for the table
                        Table(
                          columnWidths: {
                            0: FlexColumnWidth(1.5), // "Name" column
                            1: FlexColumnWidth(1), // "Actual Price" column
                            2: FlexColumnWidth(1), // "Price" column
                            3: FlexColumnWidth(1), // "Size" column
                            4: FlexColumnWidth(2), // "Actions" column
                          },
                          children: [
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center( // Center the header text vertically
                                    child: Text(
                                      appLocalization.getLocalizedString(
                                          "name"), // Header for price
                                      style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center( // Center the header text vertically
                                    child: Text(
                                      appLocalization.getLocalizedString(
                                          "sellingPrice"), // Header for price
                                      style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center( // Center the header text vertically
                                    child: Text(
                                      appLocalization.getLocalizedString(
                                          "actualPrice"),
                                      // Header for store name or item type
                                      style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center( // Center the header text vertically
                                    child: Text(
                                      appLocalization.getLocalizedString(
                                          "Stock"),
                                      // Header for store name or item type
                                      style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center( // Center the header text vertically
                                    child: Text(
                                      appLocalization.getLocalizedString(
                                          "actions"),
                                      // Header for actions (quantity control)
                                      style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // List of cart items
                        ListView.builder(
                          shrinkWrap: true,
                          // Avoid the listview from taking too much space
                          itemCount: cartState.itemsList.length,
                          itemBuilder: (context, index) {
                            final item = cartState.itemsList[index];
                            return CartItem(
                              item: item,
                              isLastItem: index ==
                                  cartState.itemsList.length - 1,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),

              Consumer<CartState>(
                builder: (context, cartState, child) {
                  if (cartState.itemsList.isEmpty)
                    return const SizedBox(); // Hide total when empty
                  return Column(
                    children: [
                      const Divider(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Divider to separate cart items from total and checkout button

                          Text(
                            '${appLocalization.getLocalizedString(
                                "totalPrice")}: ${cartState.totalPrice}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: cartState.selectedItemId != null
                                  ? const Color(0xFFFF7043)
                                  : Colors.grey,
                            ),
                            onPressed: cartState.selectedItemId != null
                                ? () {
                              CustomPopups.showCustomDialog(
                                context: context,
                                icon: const Icon(
                                    Icons.warning, color: Color(0xFFFF7043)),
                                title: appLocalization.getLocalizedString(
                                    "deleteConfirmationTitle"),
                                message: appLocalization.getLocalizedString(
                                    "deleteConfirmationBody"),
                                deleteButtonText: appLocalization
                                    .getLocalizedString("delete"),
                                onPressButton: () {
                                  // Clear the cart on confirmation
                                  cartState.deleteItemCart(
                                      cartState.selectedItemId!);
                                },
                              );
                            }
                                : null,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              Consumer<CartState>(
                builder: (context, cartState, child) {
                  return cartState.itemsList.isNotEmpty
                      ? CheckoutButton(
                    onPressed: () async {
                      bool isConnected = await checkConnectivity();
                      if (!isConnected) {
                        showLoginFailedDialog(
                          context,
                          appLocalization.getLocalizedString('noInternetConnection'),
                          appLocalization.getLocalizedString('noInternet'),
                          appLocalization.selectedLanguageCode,
                          appLocalization.getLocalizedString('ok'),
                        );
                        return;
                      }
                      final rootContext = context;
                      _showPaymentPopup(rootContext, cartState.totalPrice, appLocalization);
                    },
                  )
                      : const SizedBox(); // Hide checkout button when empty
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentPopup(BuildContext rootContext, double total, LocalizationService localizationService) {
    showDialog(
      context: rootContext,
      builder: (dialogContext) {
        return PaymentMethodPopup(
          total: total,
          onSubmit: (method, cash, visa) async {
            print("Chosen method: $method");
            print("Cash: $cash, Visa: $visa");
            // Proceed with checkout
            await _checkout(rootContext, localizationService,cash,visa);
          },
        );
      },
    );
  }


  Future<void> _checkout(BuildContext context,LocalizationService localizationService,double totalCash,double totalVisa) async {
    showLoadingAvatar(context);
    final cartState = Provider.of<CartState>(context, listen: false);

    try {
       await CartService.createOrder(context, cartState.itemsList,totalCash,totalVisa);

       Navigator.of(context).pop();
       // Show success message
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text("${localizationService.getLocalizedString("createOrderSuccess")}"),
           backgroundColor: Color(0xFF4CAF50),
         ),
       );

      cartState.clearState();

      Navigator.of(context).pushReplacement(
         _createRoute(MainScreen()), // Navigate to DashboardScreen on successful login
       );

    }
    catch (e) {
      print("Error _checkout:${e}");
      if (!context.mounted) return;
      Navigator.of(context).pop();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${localizationService.getLocalizedString("createOrderFailed")}:${e}"),
          backgroundColor: Color(0xFFD32F2F), // Custom red shade
        ),
      );
    }
  }

  Route _createRoute(Widget destination) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.slowMiddle;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var fadeAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: fadeAnimation,
          child: child,
        );
      },
    );
  }
}
