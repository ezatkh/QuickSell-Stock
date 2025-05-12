import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Models/ItemCartModel.dart';
import '../../../../Models/ItemSizeModel.dart';
import '../../../../Services/ItemSizeService.dart';
import '../../../../Services/LocalizationService.dart';
import '../../../../Constants/app_color.dart';
import '../../../../States/CartState.dart';
import '../widgets/custom_text_field.dart';
import '../../../../Models/ItemModel.dart';

class BottomSheetWidget extends StatefulWidget {
  final ItemModel item;
  const BottomSheetWidget({required this.item, Key? key}) : super(key: key);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final TextEditingController _quantityController = TextEditingController(text: '1');
  final TextEditingController _offerPriceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<List<ItemSizeModel>>? _itemSizesFuture;
  ItemSizeModel? _selectedSize;
  bool sizeError=false;
  @override
  void initState() {
    super.initState();
    _itemSizesFuture = ItemSizeService.fetchItemsSizes(context, widget.item.itemId);
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _offerPriceController.dispose();
    super.dispose();
  }

  void _confirmSale() {
    print("_confirmSale invoked");
    final cartState = context.read<CartState>();
    final currentItemId=widget.item.itemId;
    final int enteredQuantity = int.tryParse(_quantityController.text) ?? 0;

    // Sum quantities of items in the cart that match the current itemId
    final int existingQuantityInCart = cartState.itemsList
        .where((item) => item.id == currentItemId && item.itemSizeId == _selectedSize?.sizeId)
        .fold(0, (sum, item) => sum + item.quantity);

    if ((existingQuantityInCart + enteredQuantity) > (_selectedSize?.quantity ?? 0)) {
      setState(() {
        sizeError=true;
      });
      print("_confirmSale canceled");
    }
    else{
      setState(() {
        sizeError=false;
      });
    if (_formKey.currentState?.validate() ?? false) {
      final soldItem = ItemCart(
        id: widget.item.itemId,
        quantity: int.tryParse(_quantityController.text) ?? 0,
        sellingPrice: _offerPriceController.text.isNotEmpty
            ? double.tryParse(_offerPriceController.text) ?? widget.item.sellingPrice
            : widget.item.sellingPrice,
        purchasePrice: widget.item.purchasePrice,
        itemName: widget.item.itemName,
        itemSizeId: _selectedSize!.sizeId,
        itemSizeName:_selectedSize!.sizeLabel,
      );

      cartState.addStoreItem(soldItem);
      debugPrint("Cart State: \${cartState.itemsList}");
      debugPrint("Total Price: \${cartState.totalPrice}");
    Navigator.pop(context);
      }
    }
  }

  void _discardSale() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var appLocalization = Provider.of<LocalizationService>(context, listen: false);
    return Directionality(
      textDirection: appLocalization.selectedLanguageCode == 'ar'
          ? TextDirection.rtl  // Arabic (Right-to-left)
          : TextDirection.ltr,      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: _discardSale,
                        color: AppColors.primaryColor,
                      ),
                      Spacer(),
                      Text(
                        appLocalization.getLocalizedString('confirmSellTitle'),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 24),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${appLocalization.getLocalizedString('name')}: ${widget.item.itemName}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${appLocalization.getLocalizedString('sellingPrice')}: ${widget.item.sellingPrice}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '${appLocalization.getLocalizedString('purchasePrice')}: ${widget.item.purchasePrice}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _offerPriceController,
                    labelText: appLocalization.getLocalizedString('offerPrice'),
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextField(
                    controller: _quantityController,
                    labelText: appLocalization.getLocalizedString('quantity'),
                    keyboardType: TextInputType.number,
                    required: true,
                  ),
                  if(sizeError)...[
                    Text(
                      appLocalization.getLocalizedString('quantityExceedsAvailable'),
                      style: const TextStyle(
                        color: AppColors.errorColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  const SizedBox(height: 10),
                  ],
                  FutureBuilder<List<ItemSizeModel>>(
                    future: _itemSizesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text(appLocalization.getLocalizedString('errorLoading'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text(appLocalization.getLocalizedString('noSizesAvailable'));
                      }
                      else {
                        final sizes = snapshot.data!;

                        // Auto-select the first size if none selected yet
                        _selectedSize ??= sizes.first;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: Colors.grey[200],         // Background of dropdown menu
                                highlightColor: Colors.transparent,    // Remove yellow highlight
                                splashColor: Colors.transparent,       // Remove splash on tap
                              ),
                              child: DropdownButtonFormField<ItemSizeModel>(
                                value: _selectedSize,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.cardBackgroundColor,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                ),
                                dropdownColor: Colors.white,
                                items: sizes.map((size) {
                                  return DropdownMenuItem<ItemSizeModel>(
                                    value: size,
                                    child: Text('${size.sizeLabel} - ${appLocalization.getLocalizedString('quantity')}: ${size.quantity}'),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSize = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return appLocalization.getLocalizedString('pleaseChooseSize');
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: ElevatedButton(
                                onPressed: _confirmSale,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  minimumSize: Size(120, 45),
                                ),
                                child: Text(
                                  appLocalization.getLocalizedString('confirmSale'),
                                  style: TextStyle(color: AppColors.lighterTextColor),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}