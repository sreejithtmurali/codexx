import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/cartitem.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Sample cart items
  final List<CartItem> _items = [
    CartItem(
      id: '1',
      name: 'Carrot',
      unit: 'Per 1KG (Pcs)',
      price: 45.50,
      quantity: 2,
      imageUrl: 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=200',
    ),
    CartItem(
      id: '2',
      name: 'Carrot',
      unit: 'Per 1KG (Pcs)',
      price: 45.50,
      quantity: 2,
      imageUrl: 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=200',
    ),
  ];

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  double get itemTotal => _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  final double deliveryFee = 25;
  final double platformFee = 5;
  final double discount = 20;

  double get totalPayable => itemTotal + deliveryFee + platformFee - discount;

  void _updateQuantity(String id, int delta) {
    setState(() {
      final index = _items.indexWhere((item) => item.id == id);
      if (index != -1) {
        final newQty = _items[index].quantity + delta;
        if (newQty > 0) {
          _items[index] = _items[index].copyWith(quantity: newQty);
        } else {
          _items.removeAt(index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        body: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Cart Items
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Column(
                    children: [
                      ..._items.map((item) => _buildCartItem(item)),
                      const SizedBox(height: 20),
                      _buildOrderSummary(),
                    ],
                  ),
                ),
              ),

              // Checkout Button
              _buildCheckoutButton(),

              // Bottom Navigation

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Cart',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '$totalItems items',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.storefront_rounded,
                  color: Color(0xFF4CAF50),
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'George store',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.imageUrl,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 72,
                height: 72,
                color: Colors.grey.shade200,
                child: const Icon(Icons.image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Show more options
                      },
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.grey.shade500,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  item.unit,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    // Quantity Controls
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          _qtyButton(
                            icon: Icons.remove,
                            onTap: () => _updateQuantity(item.id, -1),
                            isMinus: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '${item.quantity}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          _qtyButton(
                            icon: Icons.add,
                            onTap: () => _updateQuantity(item.id, 1),
                            isMinus: false,
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

  Widget _qtyButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isMinus,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isMinus ? Colors.transparent : const Color(0xFF4CAF50),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18,
          color: isMinus ? Colors.black87 : Colors.white,
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          _summaryRow('Item Total', '₹${itemTotal.toStringAsFixed(0)}'),
          const SizedBox(height: 10),
          _summaryRow('Delivery Fee', '₹${deliveryFee.toStringAsFixed(0)}'),
          const SizedBox(height: 10),
          _summaryRow('Platform Fee', '₹${platformFee.toStringAsFixed(0)}'),
          const SizedBox(height: 10),
          _summaryRow(
            'Discount',
            '-₹${discount.toStringAsFixed(0)}',
            valueColor: const Color(0xFF4CAF50),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Payable',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Text(
                '₹${totalPayable.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor ?? Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: () {
            // Handle checkout
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Checkout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_outward, size: 18),
            ],
          ),
        ),
      ),
    );
  }


}

