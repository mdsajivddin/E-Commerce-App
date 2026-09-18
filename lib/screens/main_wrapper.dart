import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../core/theme.dart';
import '../core/dummy_data.dart';
import 'home/home_screen.dart';
import 'home/all_products_screen.dart';
import 'cart/cart_screen.dart';
import 'wishlist/wishlist_screen.dart';
import 'scanner/qr_scanner_screen.dart';

class MainWrapper extends StatefulWidget {
  final int initialIndex;
  const MainWrapper({super.key, this.initialIndex = 0});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabSelected(int index) {
    if (index == 2) {
      // Open QR scanner modal / screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const QrScannerScreen()),
      );
      return;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(onNavigateTab: _onTabSelected),
      const AllProductsScreen(title: 'Shop Catalog'),
      const SizedBox.shrink(), // Placeholder for QR Scanner center button
      const WishlistScreen(),
      const CartScreen(),
    ];

    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        final cartCount = AppState.instance.cartCount;
        final wishlistCount = AppState.instance.wishlistCount;

        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: screens,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: AppTheme.borderColor.withValues(alpha: 0.8),
                  width: 1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onTabSelected,
              backgroundColor: Colors.white,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppTheme.primaryColor,
              unselectedItemColor: AppTheme.textSecondary,
              selectedLabelStyle: GoogleFonts.outfit(
                fontSize: 11.sp,
                fontWeight: FontWeight.w800,
              ),
              unselectedLabelStyle: GoogleFonts.plusJakartaSans(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(LucideIcons.home),
                  activeIcon: Icon(LucideIcons.home, color: AppTheme.primaryColor),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(LucideIcons.layoutGrid),
                  activeIcon: Icon(LucideIcons.layoutGrid, color: AppTheme.primaryColor),
                  label: 'Shop',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withValues(alpha: 0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      LucideIcons.qrCode,
                      size: 18.sp,
                      color: Colors.white,
                    ),
                  ),
                  label: 'Scan QR',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(LucideIcons.heart),
                      if (wishlistCount > 0)
                        Positioned(
                          right: -8.w,
                          top: -4.h,
                          child: Container(
                            padding: EdgeInsets.all(3.w),
                            constraints: BoxConstraints(minWidth: 16.w, minHeight: 16.h),
                            decoration: const BoxDecoration(
                              color: AppTheme.accentPink,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$wishlistCount',
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  activeIcon: const Icon(LucideIcons.heart, color: AppTheme.primaryColor),
                  label: 'Wishlist',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(LucideIcons.shoppingBag),
                      if (cartCount > 0)
                        Positioned(
                          right: -8.w,
                          top: -4.h,
                          child: Container(
                            padding: EdgeInsets.all(3.w),
                            constraints: BoxConstraints(minWidth: 16.w, minHeight: 16.h),
                            decoration: const BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$cartCount',
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  activeIcon: const Icon(LucideIcons.shoppingBag, color: AppTheme.primaryColor),
                  label: 'Cart',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
