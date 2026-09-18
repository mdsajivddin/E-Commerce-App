import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../core/theme.dart';
import '../core/dummy_data.dart';
import '../screens/home/search_screen.dart';
import '../screens/home/location_screen.dart';
import '../screens/profile/notifications_screen.dart';

class ShopMateHeader extends StatelessWidget {
  final VoidCallback? onCartTap;
  final VoidCallback? onWishlistTap;

  const ShopMateHeader({
    super.key,
    this.onCartTap,
    this.onWishlistTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        final cartCount = AppState.instance.cartCount;

        return Container(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 14.h),
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            border: Border(
              bottom: BorderSide(
                color: AppTheme.borderColor.withValues(alpha: 0.6),
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              // Top Brand Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo + Tagline
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(7.w),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          LucideIcons.shoppingBag,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'ShopMate',
                                style: GoogleFonts.outfit(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.textPrimary,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 4.w, top: 2.h),
                                width: 6.w,
                                height: 6.w,
                                decoration: const BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'CURATED LIFESTYLE',
                            style: GoogleFonts.outfit(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.primaryColor,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Actions: Notifications + Wishlist + Cart
                  Row(
                    children: [
                      // Store Selector
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LocationScreen()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(999.r),
                            border: Border.all(color: AppTheme.borderColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                LucideIcons.mapPin,
                                size: 12.sp,
                                color: AppTheme.primaryColor,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Downtown Store',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 16.sp,
                                color: AppTheme.textSecondary,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),

                      // Notification Icon
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                          );
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.all(8.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999.r),
                            side: const BorderSide(color: AppTheme.borderColor),
                          ),
                        ),
                        icon: Icon(
                          LucideIcons.bell,
                          size: 16.sp,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      SizedBox(width: 6.w),

                      // Cart Icon with Badge
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                            onPressed: onCartTap,
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.all(8.w),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999.r),
                                side: const BorderSide(color: AppTheme.borderColor),
                              ),
                            ),
                            icon: Icon(
                              LucideIcons.shoppingBag,
                              size: 16.sp,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          if (cartCount > 0)
                            Positioned(
                              right: -2.w,
                              top: -2.h,
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
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Search Bar & Scan Button Row
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SearchScreen()),
                        );
                      },
                      child: Container(
                        height: 44.h,
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(999.r),
                          border: Border.all(color: AppTheme.borderColor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              LucideIcons.search,
                              size: 16.sp,
                              color: AppTheme.textSecondary,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                'Search sneakers, hoodies, watches, decor...',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.sp,
                                  color: AppTheme.textMuted,
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
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
