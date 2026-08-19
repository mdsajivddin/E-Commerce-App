import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() {
              _currentStep += 1;
            });
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OrderSuccessScreen()),
            );
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        controlsBuilder: (context, details) {
          return Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: _currentStep == 2 ? 'Place Order' : 'Continue',
                    onPressed: details.onStepContinue ?? () {},
                  ),
                ),
                if (_currentStep > 0) ...[
                  SizedBox(width: 16.w),
                  Expanded(
                    child: CustomButton(
                      text: 'Back',
                      isOutlined: true,
                      onPressed: details.onStepCancel ?? () {},
                    ),
                  ),
                ],
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('Shipping Address'),
            content: Column(
              children: [
                const CustomTextField(hintText: 'Full Name', prefixIcon: LucideIcons.user),
                SizedBox(height: 16.h),
                const CustomTextField(hintText: 'Street Address', prefixIcon: LucideIcons.mapPin),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    const Expanded(child: CustomTextField(hintText: 'City')),
                    SizedBox(width: 16.w),
                    const Expanded(child: CustomTextField(hintText: 'Zip Code')),
                  ],
                ),
              ],
            ),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Payment Method'),
            content: Column(
              children: [
                _buildPaymentOption(LucideIcons.creditCard, 'Credit Card', true),
                SizedBox(height: 16.h),
                _buildPaymentOption(LucideIcons.smartphone, 'Apple Pay', false),
                SizedBox(height: 16.h),
                _buildPaymentOption(LucideIcons.landmark, 'Bank Transfer', false),
              ],
            ),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Review Order'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order Summary', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Items (3)', style: TextStyle(color: AppTheme.textSecondary)),
                    Text('\$368.99', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping', style: TextStyle(color: AppTheme.textSecondary)),
                    Text('Free', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                  ],
                ),
                Divider(height: 32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    Text('\$368.99', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                  ],
                ),
              ],
            ),
            isActive: _currentStep >= 2,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(IconData icon, String title, bool isSelected) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primaryColor.withOpacity(0.05) : Colors.white,
        border: Border.all(color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300, width: 1.5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary),
          SizedBox(width: 16.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimary,
            ),
          ),
          const Spacer(),
          if (isSelected)
            Icon(LucideIcons.checkCircle2, color: AppTheme.primaryColor),
        ],
      ),
    );
  }
}
