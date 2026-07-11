import 'package:scroll_bottom_navigation_bar/scroll_bottom_navigation_bar.dart';
import 'package:clothes/Features/Screens/Account/account_screen.dart';
import 'package:clothes/Features/Screens/Cart/cart_screen.dart';
import 'package:clothes/Features/Screens/Home/home_screen.dart';
import 'package:flutter/material.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  final ScrollController controller = ScrollController();


  final List<Widget> pages = const [
    HomeScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: controller.bottomNavigationBar.tabNotifier,
        builder: (context, tabIndex, child) => pages[tabIndex],
      ),
      bottomNavigationBar: ScrollBottomNavigationBar(
        controller: controller,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Account",
          ),
        ],
      ),
    );
  }
}