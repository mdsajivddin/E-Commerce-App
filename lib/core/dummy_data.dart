import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

enum AvailabilityStatus {
  onlineOnly(
    label: 'Online Exclusive',
    badgeLabel: 'Online Only',
    subtitle: 'Direct Home Delivery Available • Store Pickup N/A',
    icon: LucideIcons.globe,
    color: Color(0xFF2563EB),
    isDeliveryAvailable: true,
    isStorePickupAvailable: false,
  ),
  storeOnly(
    label: 'In-Store Exclusive',
    badgeLabel: 'In-Store Only',
    subtitle: 'Physical Store Pickup Only • Home Delivery N/A',
    icon: LucideIcons.store,
    color: Color(0xFFD97706),
    isDeliveryAvailable: false,
    isStorePickupAvailable: true,
  ),
  both(
    label: 'Online & In-Store',
    badgeLabel: 'Online & Store',
    subtitle: 'Delivery & Local Store Pickup Both Available',
    icon: LucideIcons.badgeCheck,
    color: Color(0xFF059669),
    isDeliveryAvailable: true,
    isStorePickupAvailable: true,
  );

  final String label;
  final String badgeLabel;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isDeliveryAvailable;
  final bool isStorePickupAvailable;

  const AvailabilityStatus({
    required this.label,
    required this.badgeLabel,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.isDeliveryAvailable,
    required this.isStorePickupAvailable,
  });
}

class Category {
  final String id;
  final String name;
  final String icon;

  Category({required this.id, required this.name, required this.icon});
}

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviews;
  final List<String> images;
  final String categoryId;
  final bool isTrending;
  final AvailabilityStatus availabilityStatus;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviews,
    required this.images,
    required this.categoryId,
    this.isTrending = false,
    this.availabilityStatus = AvailabilityStatus.both,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class DummyData {
  static List<Category> categories = [
    Category(id: 'c1', name: 'Electronics', icon: 'smartphone'),
    Category(id: 'c2', name: 'Fashion', icon: 'shirt'),
    Category(id: 'c3', name: 'Home', icon: 'home'),
    Category(id: 'c4', name: 'Beauty', icon: 'smile'),
    Category(id: 'c5', name: 'Sports', icon: 'activity'),
  ];

  static List<Product> products = [
    // Electronics (c1)
    Product(
      id: 'p1',
      title: 'Premium Wireless Headphones',
      description: 'Experience high-fidelity audio with active noise cancellation and 30-hour battery life. Perfect for travel and focus.',
      price: 299.99,
      originalPrice: 349.99,
      rating: 4.8,
      reviews: 1240,
      images: [
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800&q=80',
        'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=800&q=80',
      ],
      categoryId: 'c1',
      isTrending: true,
      availabilityStatus: AvailabilityStatus.both,
    ),
    Product(
      id: 'p5',
      title: 'Smart Fitness Tracker Watch',
      description: 'Track your steps, heart rate, and sleep patterns with this sleek, water-resistant fitness band with OLED display.',
      price: 59.99,
      originalPrice: 79.99,
      rating: 4.5,
      reviews: 320,
      images: [
        'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b0?w=800&q=80',
      ],
      categoryId: 'c1',
      availabilityStatus: AvailabilityStatus.onlineOnly,
    ),
    Product(
      id: 'p7',
      title: 'Ultra HD 4K Action Camera',
      description: 'Waterproof action camera with image stabilization, wide-angle lens, and dual screens for crystal-clear video capture.',
      price: 189.00,
      originalPrice: 220.00,
      rating: 4.7,
      reviews: 540,
      images: [
        'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=800&q=80',
      ],
      categoryId: 'c1',
      isTrending: true,
      availabilityStatus: AvailabilityStatus.storeOnly,
    ),
    Product(
      id: 'p8',
      title: 'Portable Bluetooth Speaker',
      description: 'Compact 360-degree surround sound speaker with deep bass and IPX7 waterproof rating.',
      price: 89.99,
      originalPrice: 110.00,
      rating: 4.6,
      reviews: 780,
      images: [
        'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=800&q=80',
      ],
      categoryId: 'c1',
      availabilityStatus: AvailabilityStatus.both,
    ),

    // Fashion (c2)
    Product(
      id: 'p2',
      title: 'Minimalist Chronograph Watch',
      description: 'Elegant stainless steel watch with a sleek black dial and genuine leather strap.',
      price: 145.00,
      originalPrice: 180.00,
      rating: 4.6,
      reviews: 850,
      images: [
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800&q=80',
        'https://images.unsplash.com/photo-1542496658-e32569803b9f?w=800&q=80',
      ],
      categoryId: 'c2',
      isTrending: true,
      availabilityStatus: AvailabilityStatus.onlineOnly,
    ),
    Product(
      id: 'p9',
      title: 'Classic Leather Sneakers',
      description: 'Handcrafted premium white leather sneakers with cushioned insoles for all-day streetwear style.',
      price: 110.00,
      originalPrice: 140.00,
      rating: 4.8,
      reviews: 620,
      images: [
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&q=80',
      ],
      categoryId: 'c2',
      isTrending: true,
      availabilityStatus: AvailabilityStatus.both,
    ),
    Product(
      id: 'p10',
      title: 'Vintage Denim Jacket',
      description: 'Timeless light-wash denim jacket with buttoned chest pockets and relaxed comfortable fit.',
      price: 79.99,
      originalPrice: 99.99,
      rating: 4.7,
      reviews: 310,
      images: [
        'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=800&q=80',
      ],
      categoryId: 'c2',
      availabilityStatus: AvailabilityStatus.storeOnly,
    ),

    // Home (c3)
    Product(
      id: 'p3',
      title: 'Ergonomic Office Chair',
      description: 'Designed for all-day comfort with lumbar support, adjustable armrests, and breathable mesh.',
      price: 199.99,
      originalPrice: 249.99,
      rating: 4.7,
      reviews: 430,
      images: [
        'https://images.unsplash.com/photo-1505843490538-5133c6c7d0e1?w=800&q=80',
      ],
      categoryId: 'c3',
      availabilityStatus: AvailabilityStatus.storeOnly,
    ),
    Product(
      id: 'p11',
      title: 'Modern Table Lamp',
      description: 'Sleek matte finish desk lamp with touch controls, 3 color temperatures, and warm ambient lighting.',
      price: 49.99,
      originalPrice: 65.00,
      rating: 4.9,
      reviews: 410,
      images: [
        'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=800&q=80',
      ],
      categoryId: 'c3',
      availabilityStatus: AvailabilityStatus.both,
    ),
    Product(
      id: 'p12',
      title: 'Ceramic Pour-Over Coffee Set',
      description: 'Artisanal ceramic dripper and glass carafe set for brewing rich, aromatic coffee at home.',
      price: 38.50,
      originalPrice: 50.00,
      rating: 4.8,
      reviews: 290,
      images: [
        'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=800&q=80',
      ],
      categoryId: 'c3',
      availabilityStatus: AvailabilityStatus.onlineOnly,
    ),

    // Beauty (c4)
    Product(
      id: 'p4',
      title: 'Hydrating Face Serum',
      description: 'A deeply nourishing serum packed with hyaluronic acid and vitamin C for glowing skin.',
      price: 34.50,
      originalPrice: 40.00,
      rating: 4.9,
      reviews: 2100,
      images: [
        'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=800&q=80',
      ],
      categoryId: 'c4',
      isTrending: true,
      availabilityStatus: AvailabilityStatus.both,
    ),
    Product(
      id: 'p13',
      title: 'Organic Sunscreen Cream',
      description: 'SPF 50 broad spectrum mineral sunscreen with botanical extracts. Non-greasy and water-resistant.',
      price: 24.99,
      originalPrice: 30.00,
      rating: 4.6,
      reviews: 840,
      images: [
        'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=800&q=80',
      ],
      categoryId: 'c4',
      availabilityStatus: AvailabilityStatus.onlineOnly,
    ),

    // Sports (c5)
    Product(
      id: 'p6',
      title: 'Yoga Mat with Alignment Lines',
      description: 'Non-slip eco-friendly yoga mat with alignment markers to perfect your poses.',
      price: 28.00,
      originalPrice: 35.00,
      rating: 4.8,
      reviews: 950,
      images: [
        'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=800&q=80',
      ],
      categoryId: 'c5',
      availabilityStatus: AvailabilityStatus.storeOnly,
    ),
    Product(
      id: 'p14',
      title: 'Insulated Stainless Steel Bottle',
      description: 'Keep drinks cold for 24 hours or hot for 12 hours with this durable leak-proof sports bottle.',
      price: 22.99,
      originalPrice: 29.99,
      rating: 4.9,
      reviews: 1120,
      images: [
        'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=800&q=80',
      ],
      categoryId: 'c5',
      availabilityStatus: AvailabilityStatus.both,
    ),
  ];

  static List<CartItem> cartItems = [
    CartItem(product: products[0], quantity: 1),
    CartItem(product: products[3], quantity: 2),
  ];
}

