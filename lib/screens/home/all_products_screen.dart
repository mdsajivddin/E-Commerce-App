import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/theme.dart';
import '../../core/dummy_data.dart';
import '../../widgets/product_card.dart';

class AllProductsScreen extends StatefulWidget {
  final String title;

  const AllProductsScreen({super.key, required this.title});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  AvailabilityStatus? _selectedAvailabilityFilter;

  List<Product> get _filteredProducts {
    if (_selectedAvailabilityFilter == null) {
      return DummyData.products;
    }
    return DummyData.products
        .where((p) => p.availabilityStatus == _selectedAvailabilityFilter)
        .toList();
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter Products',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.x),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Availability Status',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    tileColor: _selectedAvailabilityFilter == null
                        ? AppTheme.primaryColor.withValues(alpha: 0.1)
                        : Colors.transparent,
                    leading: const Icon(LucideIcons.layoutGrid),
                    title: const Text('All Items'),
                    trailing: _selectedAvailabilityFilter == null
                        ? const Icon(LucideIcons.check, color: AppTheme.primaryColor)
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedAvailabilityFilter = null;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ...AvailabilityStatus.values.map((status) {
                    final isSelected = _selectedAvailabilityFilter == status;
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      tileColor: isSelected
                          ? status.color.withValues(alpha: 0.1)
                          : Colors.transparent,
                      leading: Icon(status.icon, color: status.color),
                      title: Text(status.label),
                      subtitle: Text(
                        status.subtitle,
                        style: TextStyle(fontSize: 11.sp),
                      ),
                      trailing: isSelected
                          ? Icon(LucideIcons.check, color: status.color)
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedAvailabilityFilter = status;
                        });
                        Navigator.pop(context);
                      },
                    );
                  }),
                  SizedBox(height: 16.h),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAvailabilityChip({
    required String label,
    required IconData icon,
    required bool isSelected,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? color : color.withValues(alpha: 0.25),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14.sp,
              color: isSelected ? Colors.white : color,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.slidersHorizontal),
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 8.h),
          SizedBox(
            height: 36.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                _buildAvailabilityChip(
                  label: 'All Items',
                  icon: LucideIcons.layoutGrid,
                  isSelected: _selectedAvailabilityFilter == null,
                  color: AppTheme.primaryColor,
                  onTap: () {
                    setState(() {
                      _selectedAvailabilityFilter = null;
                    });
                  },
                ),
                SizedBox(width: 8.w),
                ...AvailabilityStatus.values.map((status) {
                  final isSelected = _selectedAvailabilityFilter == status;
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: _buildAvailabilityChip(
                      label: status.badgeLabel,
                      icon: status.icon,
                      isSelected: isSelected,
                      color: status.color,
                      onTap: () {
                        setState(() {
                          _selectedAvailabilityFilter = isSelected ? null : status;
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Expanded(
            child: products.isEmpty
                ? Center(
                    child: Text(
                      'No products found for selected filter.',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.all(16.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.70,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
