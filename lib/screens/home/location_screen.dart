import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/theme.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final List<String> _popularCities = [
    'New York, USA',
    'Los Angeles, USA',
    'London, UK',
    'Dubai, UAE',
    'Mumbai, India',
    'Tokyo, Japan'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search city or area...',
                prefixIcon: const Icon(LucideIcons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          // Current Location
          ListTile(
            leading: Icon(LucideIcons.navigation, color: AppTheme.primaryColor, size: 24.sp),
            title: Text(
              'Use Current Location',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
            ),
            subtitle: Text('New York, USA', style: TextStyle(fontSize: 12.sp, color: AppTheme.textSecondary)),
            onTap: () {
              Navigator.pop(context, 'New York, USA');
            },
          ),
          
          Divider(color: Colors.grey.shade200, height: 32.h, thickness: 1),
          
          // Popular Cities
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Popular Cities',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.separated(
              itemCount: _popularCities.length,
              separatorBuilder: (context, index) => Divider(color: Colors.grey.shade100, height: 1),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  leading: Icon(LucideIcons.mapPin, color: AppTheme.textSecondary, size: 20.sp),
                  title: Text(_popularCities[index], style: TextStyle(fontSize: 16.sp)),
                  onTap: () {
                    // In a real app, this would pass the selected city back.
                    // For the dummy UI, we just pop.
                    Navigator.pop(context, _popularCities[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
