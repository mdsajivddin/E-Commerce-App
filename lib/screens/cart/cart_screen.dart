import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/theme.dart';
import '../../core/dummy_data.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _couponController = TextEditingController();
  String _couponMessage = '';
  bool _isCouponError = false;

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  void _applyCoupon() {
    final code = _couponController.text.trim();
    if (code.isEmpty) return;

    final success = AppState.instance.applyCoupon(code);
    setState(() {
      if (success) {
        _isCouponError = false;
        _couponMessage = 'Coupon applied: ${AppState.instance.appliedCoupon!.desc}';
      } else {
        _isCouponError = true;
        _couponMessage = 'Invalid coupon. Try "SHOP50" or "SAVE20"';
      }
    });
  }

  void _showCheckoutDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildCheckoutBottomSheet(),
    );
  }

  Widget _buildCheckoutBottomSheet() {
    final grandTotal = AppState.instance.grandTotal;

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Complete Checkout',
                style: GoogleFonts.outfit(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textPrimary,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  '₹${grandTotal.toStringAsFixed(0)}',
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // QR Code UPI Payment Box (Identical to live web app)
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              children: [
                Text(
                  'Instant UPI QR Self-Pay',
                  style: GoogleFonts.outfit(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: Image.network(
                    'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=upi://pay?pa=shopmate@upi&pn=ShopMate&am=${grandTotal.toStringAsFixed(2)}',
                    width: 120.w,
                    height: 120.w,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      LucideIcons.qrCode,
                      size: 80.sp,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'UPI ID: shopmate@upi',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    IconButton(
                      icon: Icon(LucideIcons.copy, size: 14.sp, color: AppTheme.primaryColor),
                      onPressed: () {
                        Clipboard.setData(const ClipboardData(text: 'shopmate@upi'));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('UPI ID copied to clipboard'),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Payment Options
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(LucideIcons.creditCard, color: AppTheme.primaryColor),
            title: Text(
              'Credit / Debit Card / NetBanking',
              style: GoogleFonts.outfit(fontSize: 13.sp, fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              'Visa, Mastercard, RuPay',
              style: GoogleFonts.plusJakartaSans(fontSize: 11.sp, color: AppTheme.textSecondary),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _confirmOrder(context),
          ),
          const Divider(height: 1),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(LucideIcons.banknote, color: AppTheme.primaryColor),
            title: Text(
              'Cash on Delivery / In-Store Counter',
              style: GoogleFonts.outfit(fontSize: 13.sp, fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              'Pay upon delivery or store pickup',
              style: GoogleFonts.plusJakartaSans(fontSize: 11.sp, color: AppTheme.textSecondary),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _confirmOrder(context),
          ),
          SizedBox(height: 16.h),

          // Confirm Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _confirmOrder(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999.r)),
              ),
              child: Text(
                'Place Order (₹${grandTotal.toStringAsFixed(0)})',
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  void _confirmOrder(BuildContext context) {
    Navigator.pop(context); // close bottom sheet
    AppState.instance.clearCart();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                LucideIcons.checkCheck,
                size: 44.sp,
                color: AppTheme.successColor,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Order Placed Successfully!',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: AppTheme.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Thank you for shopping with ShopMate! A confirmation email and SMS have been sent.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                color: AppTheme.textSecondary,
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999.r)),
              ),
              child: Text(
                'Continue Shopping',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        final cartItems = AppState.instance.cart;
        final subtotal = AppState.instance.subtotal;
        final discount = AppState.instance.discountAmount;
        final shipping = AppState.instance.shippingFee;
        final tax = AppState.instance.taxAmount;
        final grandTotal = AppState.instance.grandTotal;
        final appliedCoupon = AppState.instance.appliedCoupon;

        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          appBar: AppBar(
            title: Text(
              'My Shopping Cart (${AppState.instance.cartCount})',
              style: GoogleFonts.outfit(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: AppTheme.textPrimary,
              ),
            ),
            actions: [
              if (cartItems.isNotEmpty)
                TextButton(
                  onPressed: () {
                    AppState.instance.clearCart();
                  },
                  child: Text(
                    'Clear All',
                    style: GoogleFonts.outfit(
                      color: AppTheme.errorColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              SizedBox(width: 8.w),
            ],
          ),
          body: cartItems.isEmpty
              ? _buildEmptyCart()
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cart Item Cards List
                      ...cartItems.map((item) => _buildCartItemCard(item)),
                      SizedBox(height: 20.h),

                      // Coupon Promo Code Input Box
                      _buildCouponBox(appliedCoupon),
                      SizedBox(height: 20.h),

                      // Order Price Breakdown Summary
                      _buildPriceSummary(subtotal, discount, shipping, tax, grandTotal, appliedCoupon),
                      SizedBox(height: 24.h),

                      // Checkout Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _showCheckoutDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999.r),
                            ),
                            elevation: 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Proceed to Checkout • ₹${grandTotal.toStringAsFixed(0)}',
                                style: GoogleFonts.outfit(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(LucideIcons.arrowRight, size: 16.sp, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: AppTheme.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                LucideIcons.shoppingBag,
                size: 56.sp,
                color: AppTheme.primaryColor,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Your Cart is Empty',
              style: GoogleFonts.outfit(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: AppTheme.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Looks like you haven\'t added any lifestyle drops yet. Explore our latest arrivals!',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                color: AppTheme.textSecondary,
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999.r)),
              ),
              child: Text(
                'Start Exploring',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItemCard(CartItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              item.product.image,
              width: 80.w,
              height: 80.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 14.w),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        item.product.brand.toUpperCase(),
                        style: GoogleFonts.outfit(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => AppState.instance.removeFromCart(item),
                      child: Icon(
                        LucideIcons.trash2,
                        size: 16.sp,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  item.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                if (item.selectedSize.isNotEmpty || item.selectedColor.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    '${item.selectedColor.isNotEmpty ? item.selectedColor : ''} ${item.selectedSize.isNotEmpty ? '• ${item.selectedSize}' : ''}',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.sp,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${item.product.price.toInt()}',
                      style: GoogleFonts.outfit(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textPrimary,
                      ),
                    ),

                    // Stepper
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(999.r),
                        border: Border.all(color: AppTheme.borderColor),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () => AppState.instance.updateQuantity(item, -1),
                            borderRadius: BorderRadius.circular(999.r),
                            child: Padding(
                              padding: EdgeInsets.all(4.w),
                              child: const Icon(Icons.remove, size: 14),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: Text(
                              '${item.quantity}',
                              style: GoogleFonts.outfit(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => AppState.instance.updateQuantity(item, 1),
                            borderRadius: BorderRadius.circular(999.r),
                            child: Padding(
                              padding: EdgeInsets.all(4.w),
                              child: const Icon(Icons.add, size: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponBox(Coupon? appliedCoupon) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.tag, size: 16.sp, color: AppTheme.primaryColor),
              SizedBox(width: 8.w),
              Text(
                'Promotional Coupon',
                style: GoogleFonts.outfit(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          if (appliedCoupon != null) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppTheme.primaryLight,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(LucideIcons.checkCircle2, size: 16.sp, color: AppTheme.primaryColor),
                      SizedBox(width: 6.w),
                      Text(
                        '${appliedCoupon.code} Applied (${(appliedCoupon.discountPercent * 100).toInt()}% OFF)',
                        style: GoogleFonts.outfit(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      AppState.instance.removeCoupon();
                      setState(() {
                        _couponMessage = '';
                      });
                    },
                    child: Icon(Icons.close, size: 18.sp, color: AppTheme.primaryColor),
                  ),
                ],
              ),
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _couponController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      hintText: 'Try "SHOP50" or "SAVE20"',
                      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                ElevatedButton(
                  onPressed: _applyCoupon,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999.r)),
                  ),
                  child: Text(
                    'APPLY',
                    style: GoogleFonts.outfit(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            if (_couponMessage.isNotEmpty) ...[
              SizedBox(height: 6.h),
              Text(
                _couponMessage,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11.sp,
                  color: _isCouponError ? AppTheme.errorColor : AppTheme.successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildPriceSummary(
    double subtotal,
    double discount,
    double shipping,
    double tax,
    double grandTotal,
    Coupon? appliedCoupon,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Breakdown',
            style: GoogleFonts.outfit(
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          _buildSummaryRow('Items Subtotal', '₹${subtotal.toStringAsFixed(0)}'),
          if (discount > 0) ...[
            SizedBox(height: 8.h),
            _buildSummaryRow(
              'Coupon Discount (${appliedCoupon?.code})',
              '-₹${discount.toStringAsFixed(0)}',
              isGreen: true,
            ),
          ],
          SizedBox(height: 8.h),
          _buildSummaryRow(
            'Shipping & Handling',
            shipping == 0 ? 'FREE' : '₹${shipping.toStringAsFixed(0)}',
            isGreen: shipping == 0,
          ),
          SizedBox(height: 8.h),
          _buildSummaryRow('Estimated GST (12%)', '₹${tax.toStringAsFixed(0)}'),
          Divider(height: 24.h, color: AppTheme.borderColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Grand Total',
                style: GoogleFonts.outfit(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                '₹${grandTotal.toStringAsFixed(0)}',
                style: GoogleFonts.outfit(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            color: AppTheme.textSecondary,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: isGreen ? AppTheme.successColor : AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
