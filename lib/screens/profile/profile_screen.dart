import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/theme.dart';
import '../auth/login_screen.dart';
import 'update_profile_screen.dart';
import 'my_orders_screen.dart';
import 'shipping_addresses_screen.dart';
import 'notifications_screen.dart';
import 'settings_screen.dart';
import 'payment_methods_screen.dart';
import 'help_support_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            // Header Profile Info
            Row(
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=11'),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'johndoe@example.com',
                        style: TextStyle(fontSize: 14.sp, color: AppTheme.textSecondary),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.edit2, color: AppTheme.primaryColor),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
                  },
                ),
              ],
            ),
            SizedBox(height: 32.h),

            // Profile Options
            _buildProfileOption(
              context, 
              icon: LucideIcons.box, 
              title: 'My Orders',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MyOrdersScreen())),
            ),
            _buildProfileOption(
              context, 
              icon: LucideIcons.mapPin, 
              title: 'Shipping Addresses',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ShippingAddressesScreen())),
            ),
            _buildProfileOption(
              context, 
              icon: LucideIcons.creditCard, 
              title: 'Payment Methods',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentMethodsScreen())),
            ),
            _buildProfileOption(
              context, 
              icon: LucideIcons.bell, 
              title: 'Notifications',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen())),
            ),
            _buildProfileOption(
              context, 
              icon: LucideIcons.settings, 
              title: 'Settings',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
            ),
            _buildProfileOption(
              context, 
              icon: LucideIcons.headphones, 
              title: 'Help & Support',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpSupportScreen())),
            ),
            
            SizedBox(height: 24.h),
            Divider(color: Colors.grey.shade300),
            SizedBox(height: 24.h),
            
            _buildProfileOption(
              context,
              icon: LucideIcons.logOut,
              title: 'Logout',
              isDestructive: true,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    bool isDestructive = false,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: isDestructive ? AppTheme.errorColor.withOpacity(0.1) : AppTheme.primaryColor.withOpacity(0.05),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isDestructive ? AppTheme.errorColor : AppTheme.primaryColor,
          size: 20.sp,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: isDestructive ? AppTheme.errorColor : AppTheme.textPrimary,
        ),
      ),
      trailing: isDestructive ? null : Icon(LucideIcons.chevronRight, color: AppTheme.textSecondary, size: 20.sp),
      onTap: onTap ?? () {},
    );
  }
}
