import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_sell/Constants/app_color.dart';

import '../../../../Services/LocalizationService.dart';

enum PaymentMethod { visa, cash, mix }

class PaymentMethodPopup extends StatefulWidget {
  final double total;
  final Function(PaymentMethod method, double cashAmount, double visaAmount) onSubmit;

  const PaymentMethodPopup({
    super.key,
    required this.total,
    required this.onSubmit,
  });

  @override
  State<PaymentMethodPopup> createState() => _PaymentMethodPopupState();
}

class _PaymentMethodPopupState extends State<PaymentMethodPopup> {
  PaymentMethod _selectedMethod = PaymentMethod.visa;
  final TextEditingController _cashController = TextEditingController();

  @override
  void dispose() {
    _cashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appLocalization = Provider.of<LocalizationService>(context, listen: false);
    double total = widget.total;
    double cashAmount = 0.0;
    double visaAmount = total;

    if (_selectedMethod == PaymentMethod.mix) {
      cashAmount = double.tryParse(_cashController.text) ?? 0.0;
      if (cashAmount > total) {
        cashAmount = total;
        _cashController.text = total.toString();
      }
      visaAmount = total - cashAmount;
    } else if (_selectedMethod == PaymentMethod.cash) {
      cashAmount = total;
      visaAmount = 0.0;
    }

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(appLocalization.getLocalizedString("choosePaymentMethod"),style:TextStyle(color: AppColors.hintTextColor),),
          Text(total.toString()),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<PaymentMethod>(
            title: Text(appLocalization.getLocalizedString("visa")),
            value: PaymentMethod.visa,
            groupValue: _selectedMethod,
            activeColor: AppColors.secondaryColor,
            onChanged: (value) {
              setState(() {
                _selectedMethod = value!;
              });
            },
          ),
          RadioListTile<PaymentMethod>(
            title: Text(appLocalization.getLocalizedString("cash")),
            value: PaymentMethod.cash,
            activeColor: AppColors.secondaryColor,
            groupValue: _selectedMethod,
            onChanged: (value) {
              setState(() {
                _selectedMethod = value!;
              });
            },
          ),
          RadioListTile<PaymentMethod>(
            title: Text(appLocalization.getLocalizedString("visaAndCash")),
            value: PaymentMethod.mix,
            activeColor: AppColors.secondaryColor,
            groupValue: _selectedMethod,
            onChanged: (value) {
              setState(() {
                _selectedMethod = value!;
              });
            },
          ),
          if (_selectedMethod == PaymentMethod.mix)
            TextField(
              controller: _cashController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: appLocalization.getLocalizedString("cashAmount"),
                filled: true,
                fillColor: AppColors.backgroundColor,
              ),
              onChanged: (_) => setState(() {}),
            ),
          const SizedBox(height: 10),
          if (_selectedMethod == PaymentMethod.cash)
            Text("${appLocalization.getLocalizedString("cash")}: ${cashAmount.toStringAsFixed(2)}"),
          if (_selectedMethod == PaymentMethod.visa)
            Text("${appLocalization.getLocalizedString("visa")}: ${visaAmount.toStringAsFixed(2)}"),
          if (_selectedMethod == PaymentMethod.mix)
            Text("${appLocalization.getLocalizedString("cash")}: ${cashAmount.toStringAsFixed(2)}, ${appLocalization.getLocalizedString("visa")}: ${visaAmount.toStringAsFixed(2)}"),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(appLocalization.getLocalizedString("cancel")),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onSubmit(_selectedMethod, cashAmount, visaAmount);
              },
              child: Text(appLocalization.getLocalizedString("submit")),
            ),

          ],
        ),
      ],
    );
  }
}
