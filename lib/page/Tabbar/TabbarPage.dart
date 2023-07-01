import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:workspace/Utils/AppColors.dart';
import 'package:workspace/Utils/Dimensions.dart';
import 'package:workspace/controllers/TabbarController.dart';
import 'package:workspace/page/Orders/OrderHistory.dart';
import 'package:workspace/page/cart/CartPage.dart';
import 'package:workspace/page/home/home_page.dart';

class TabbarPage extends StatelessWidget {
  final int selectedTabIndex;
  TabbarPage ({Key? key, required this.selectedTabIndex}) : super(key: key);

  List<Widget> pages = [
    HomePage(),
    const OrderHistory(),
    const CartPage(),
    Container(child: Center(child: Text("Next 2page")))
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: selectedTabIndex,
      length: 4,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          isScrollable: false,
          labelColor: Colors.white,
          unselectedLabelColor: AppColors.mainColor,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.gradient),
          tabs: const [
            Tab(icon: Icon(Icons.home_outlined), text: "Home",),
            Tab(icon: Icon(Icons.history_outlined), text: "Orders"),
            Tab(icon: Icon(Icons.shopping_cart_outlined), text: "Cart"),
            Tab(icon: Icon(Icons.person_outline), text: "Me"),
          ],
        ),
        body: TabBarView(
            children: pages
        ),
      ),
    );
  }
}
