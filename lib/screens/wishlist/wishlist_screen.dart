import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/theme.dart';
import '../../core/dummy_data.dart';
import '../../widgets/product_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // For dummy data, let's just show the trending products as wishlist
    final wishlistItems = DummyData.products.where((p) => p.isTrending).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        centerTitle: true,
      ),
      body: wishlistItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.heart, size: 80.sp, color: Colors.grey.shade300),
                  SizedBox(height: 16.h),
                  Text('Your wishlist is empty', style: TextStyle(fontSize: 18.sp, color: AppTheme.textSecondary)),
                ],
              ),
            )
          : GridView.builder(
              padding: EdgeInsets.all(16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
              ),
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                return ProductCard(product: wishlistItems[index]);
              },
            ),
    );
  }
}
