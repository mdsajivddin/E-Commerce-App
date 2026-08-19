import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/theme.dart';
import '../../core/dummy_data.dart';
import '../../widgets/custom_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                SizedBox(
                  height: 400.h,
                  width: double.infinity,
                  child: Hero(
                    tag: 'product_image_${product.id}',
                    child: Image.network(
                      product.images.first,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Details
                Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32.r),
                    ),
                  ),
                  transform: Matrix4.translationValues(0, -32.h, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              product.title,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),
                          Icon(
                            LucideIcons.heart,
                            color: AppTheme.textSecondary,
                            size: 28.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Icon(
                            LucideIcons.star,
                            color: Colors.amber,
                            size: 20.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${product.rating}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' (${product.reviews} reviews)',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      // Premium Fulfillment & Stock Availability Card
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Fulfillment Options',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: product.availabilityStatus.color
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                      color: product.availabilityStatus.color
                                          .withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        product.availabilityStatus.icon,
                                        color: product.availabilityStatus.color,
                                        size: 14.sp,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        product.availabilityStatus.label,
                                        style: TextStyle(
                                          color:
                                              product.availabilityStatus.color,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              product.availabilityStatus.subtitle,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppTheme.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Divider(height: 1, color: Colors.grey.shade200),
                            SizedBox(height: 12.h),
                            // Row 1: Home Delivery
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color:
                                        product
                                            .availabilityStatus
                                            .isDeliveryAvailable
                                        ? const Color(
                                            0xFF2563EB,
                                          ).withValues(alpha: 0.1)
                                        : Colors.grey.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    LucideIcons.truck,
                                    size: 16.sp,
                                    color:
                                        product
                                            .availabilityStatus
                                            .isDeliveryAvailable
                                        ? const Color(0xFF2563EB)
                                        : Colors.grey.shade400,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Home Delivery',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.textPrimary,
                                        ),
                                      ),
                                      Text(
                                        product
                                                .availabilityStatus
                                                .isDeliveryAvailable
                                            ? 'Standard 2-3 Days Delivery'
                                            : 'Not available for home shipping',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color:
                                              product
                                                  .availabilityStatus
                                                  .isDeliveryAvailable
                                              ? AppTheme.textSecondary
                                              : AppTheme.errorColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  product.availabilityStatus.isDeliveryAvailable
                                      ? LucideIcons.checkCircle2
                                      : LucideIcons.circleX,
                                  color:
                                      product
                                          .availabilityStatus
                                          .isDeliveryAvailable
                                      ? const Color(0xFF059669)
                                      : Colors.grey.shade400,
                                  size: 18.sp,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            // Row 2: Store Pickup
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color:
                                        product
                                            .availabilityStatus
                                            .isStorePickupAvailable
                                        ? const Color(
                                            0xFFD97706,
                                          ).withValues(alpha: 0.1)
                                        : Colors.grey.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    LucideIcons.store,
                                    size: 16.sp,
                                    color:
                                        product
                                            .availabilityStatus
                                            .isStorePickupAvailable
                                        ? const Color(0xFFD97706)
                                        : Colors.grey.shade400,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'In-Store Pickup',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.textPrimary,
                                        ),
                                      ),
                                      Text(
                                        product
                                                .availabilityStatus
                                                .isStorePickupAvailable
                                            ? 'Ready for pickup at nearest store'
                                            : 'Online exclusive item (No pickup)',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color:
                                              product
                                                  .availabilityStatus
                                                  .isStorePickupAvailable
                                              ? AppTheme.textSecondary
                                              : AppTheme.errorColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  product
                                          .availabilityStatus
                                          .isStorePickupAvailable
                                      ? LucideIcons.checkCircle2
                                      : LucideIcons.circleX,
                                  color:
                                      product
                                          .availabilityStatus
                                          .isStorePickupAvailable
                                      ? const Color(0xFF059669)
                                      : Colors.grey.shade400,
                                  size: 18.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        product.description,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppTheme.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 100.h), // space for bottom bar
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16.h,
            left: 16.w,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(LucideIcons.arrowLeft),
              ),
            ),
          ),

          // Bottom Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Price',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 24.w),
                    Expanded(
                      child: CustomButton(
                        text: 'Add to Cart',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
