import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:workspace/Widgets/small_text.dart';
import 'package:workspace/page/cart/CartPage.dart';

import '../../Utils/AppColors.dart';
import '../../Utils/Dimensions.dart';
import '../../Widgets/big_text.dart';
import '../../helper/RouteHelper.dart';

class CartConfirmationPage extends StatefulWidget {
  const CartConfirmationPage({Key? key, required this.callBack}) : super(key: key);
  final OrderConfirmedCallBack callBack;

  @override
  State<CartConfirmationPage> createState() => _PaymentOptionsState();
}
enum PaymentMode { COD, ApplePay, CreditDebit }

class _PaymentOptionsState extends State<CartConfirmationPage> {
  PaymentMode? _mode;
  bool _isLoading = false;

  void handleSelection(PaymentMode? value) {
    setState(() {
      _mode = value;
    });
  }

  void _startLoading() async {
    setState(() {
      _isLoading = true;
    });
    // Wait for 3 seconds
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isLoading = false;
      Navigator.pop(context);
      widget.callBack();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          Row(
              children: [
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: AppColors.gradient
                      ),
                      child: BigText(text: "Payment mode", color: Colors.white,)
                  ),
                ),
              ]
          ),
          RadioListTile(
            title: const Text('Cash on delivery'),
            value: PaymentMode.COD,
            groupValue: _mode,
            onChanged: handleSelection,
          ),
          RadioListTile(
            title: const Text('Apple Pay'),
            value: PaymentMode.ApplePay,
            groupValue: _mode,
            onChanged: handleSelection,
          ),
          RadioListTile(
            title: const Text("Credit or debit card"),
            value: PaymentMode.CreditDebit,
            groupValue: _mode,
            onChanged: handleSelection,
          ),
          Row(
              children: [
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: AppColors.gradient
                      ),
                      child: BigText(text: "Address", color: Colors.white,)
                  ),
                ),
              ]
          ),
          SizedBox(height: Dimensions.height20,),
          BigText(text: "705, Anime building, 7 Border St, Tst"),
          SizedBox(height: Dimensions.height10,),
          SmallText(text: "Change Address", color: AppColors.mainColor, size: Dimensions.font20,),
          SizedBox(height: Dimensions.height20,),
          Row(
            children: [
              Expanded(
                child: InkWell(child: Container(
                    decoration: BoxDecoration(
                        gradient: AppColors.gradient
                    ),
                    height: Dimensions.height45,
                    margin: EdgeInsets.only(bottom: Dimensions.height20),
                    child: Center(
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(AppColors.mainColor2),
                          ),
                          icon: _isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : const Icon(Icons.money),
                          onPressed: () {
                            if (_isLoading == false) {
                              _startLoading();
                            }
                          },
                          label: BigText(text:_isLoading ? "Confirming..." :"Place order", color: Colors.white,),
                        )
                      ),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}