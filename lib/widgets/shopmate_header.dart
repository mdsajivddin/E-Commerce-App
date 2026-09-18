import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../core/theme.dart';
import '../core/dummy_data.dart';
import '../screens/home/search_screen.dart';
import '../screens/home/location_screen.dart';
import '../screens/scanner/qr_scanner_screen.dart';
import '../screens/wishlist/wishlist_screen.dart';
import '../screens/seller/seller_login_modal.dart';
import '../screens/seller/seller_dashboard_screen.dart';

class ShopMateHeader extends StatelessWidget {
  final VoidCallback? onCartTap;
  final VoidCallback? onWishlistTap;

  const ShopMateHeader({super.key, this.onCartTap, this.onWishlistTap});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        final wishlistCount = AppState.instance.wishlistCount;
        final isVendor = AppState.instance.isVendorLoggedIn;
        final currentPersona = AppState.instance.currentVendorPersona;

        return Container(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFAF8F5).withValues(alpha: 0.98),
            border: Border(
              bottom: BorderSide(
                color: AppTheme.borderColor.withValues(alpha: 0.8),
                width: 1,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. TOP ACTIONS ROW: Logo + Location + QR + Wishlist + Become a Seller
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Brand Logo ("ShopMate" with squircle icon)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A5D4E),
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF4A5D4E,
                                ).withValues(alpha: 0.25),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              LucideIcons.shoppingBag,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.outfit(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.6,
                            ),
                            children: const [
                              TextSpan(
                                text: 'Shop',
                                style: TextStyle(color: Color(0xFF171717)),
                              ),
                              TextSpan(
                                text: 'Mate',
                                style: TextStyle(color: Color(0xFF4A5D4E)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 12.w),

                    // Location Selector Pill ("● 📍 Downtown Cen...")
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LocationScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0FDF4),
                          borderRadius: BorderRadius.circular(999.r),
                          border: Border.all(color: const Color(0xFFBBF7D0)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6.w,
                              height: 6.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Icon(
                              LucideIcons.mapPin,
                              size: 12.sp,
                              color: const Color(0xFF15803D),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Downtown Cen...',
                              style: GoogleFonts.outfit(
                                fontSize: 11.5.sp,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF15803D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),

                    // QR Scanner Button (Circular white button)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QrScannerScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            LucideIcons.qrCode,
                            size: 16.sp,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),

                    // Wishlist (Heart) Button (Opens WishlistScreen)
                    GestureDetector(
                      onTap: () {
                        if (onWishlistTap != null) {
                          onWishlistTap!();
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WishlistScreen(),
                            ),
                          );
                        }
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 36.w,
                            height: 36.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                LucideIcons.heart,
                                size: 16.sp,
                                color: wishlistCount > 0
                                    ? const Color(0xFFF43F5E)
                                    : const Color(0xFF334155),
                              ),
                            ),
                          ),
                          if (wishlistCount > 0)
                            Positioned(
                              right: -2.w,
                              top: -2.h,
                              child: Container(
                                padding: EdgeInsets.all(3.w),
                                constraints: BoxConstraints(
                                  minWidth: 16.w,
                                  minHeight: 16.h,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF43F5E),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '$wishlistCount',
                                    style: GoogleFonts.outfit(
                                      color: Colors.white,
                                      fontSize: 8.5.sp,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),

                    // "Become a Seller" Button (Opens SellerLoginModal / SellerDashboardScreen)
                    GestureDetector(
                      onTap: () {
                        if (isVendor) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SellerDashboardScreen(),
                            ),
                          );
                        } else {
                          SellerLoginModal.show(context);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 7.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A),
                          borderRadius: BorderRadius.circular(999.r),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF0F172A,
                              ).withValues(alpha: 0.25),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              LucideIcons.store,
                              color: const Color(0xFF10B981),
                              size: 15.sp,
                            ),
                            SizedBox(width: 7.w),
                            Text(
                              isVendor
                                  ? 'Seller: ${currentPersona?.role.split(' ').first ?? "Portal"}'
                                  : 'Become a Seller',
                              style: GoogleFonts.outfit(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10.h),

              // 2. SEARCH BAR ("Search products, kicks...") restored below the top row
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 42.h,
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999.r),
                    border: Border.all(color: AppTheme.borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.search,
                        size: 16.sp,
                        color: Colors.grey.shade400,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          'Search products, kicks...',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryLight,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          LucideIcons.slidersHorizontal,
                          size: 12.sp,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
