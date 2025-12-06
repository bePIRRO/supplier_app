import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';
import '../data/navigation_items_data.dart';
import '../enums/app_screens.dart';
import 'home_screen.dart';
import 'orders/orders_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

/// Main navigation screen that manages bottom navigation
/// and prevents re-rendering of the bottom nav bar
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  AppScreens _currentScreen = AppScreens.home;

  // PageController for smooth transitions
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(AppScreens screen) {
    if (screen != _currentScreen) {
      setState(() {
        _currentScreen = screen;
      });

      // Map screen to page index
      final index = _getPageIndex(screen);
      _pageController.jumpToPage(index);
    }
  }

  int _getPageIndex(AppScreens screen) {
    switch (screen) {
      case AppScreens.home:
        return 0;
      case AppScreens.orders:
        return 1;
      case AppScreens.cart:
        return 2;
      case AppScreens.profile:
        return 3;
      default:
        return 0;
    }
  }

  AppScreens _getScreenFromIndex(int index) {
    switch (index) {
      case 0:
        return AppScreens.home;
      case 1:
        return AppScreens.orders;
      case 2:
        return AppScreens.cart;
      case 3:
        return AppScreens.profile;
      default:
        return AppScreens.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe
        children: const [
          _KeepAlivePage(child: HomeScreen()),
          _KeepAlivePage(child: OrdersScreen()),
          _KeepAlivePage(child: CartScreen()),
          _KeepAlivePage(child: ProfileScreen()),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentScreen = _getScreenFromIndex(index);
          });
        },
      ),
      bottomNavigationBar: AppBottomNavigation(
        items: NavigationItemsData.withBadges(ordersBadge: 3, cartBadge: 2),
        selectedScreen: _currentScreen,
        onTap: _onNavItemTapped,
      ),
    );
  }
}

/// Wrapper to keep pages alive when switching tabs
class _KeepAlivePage extends StatefulWidget {
  final Widget child;

  const _KeepAlivePage({required this.child});

  @override
  State<_KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<_KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
