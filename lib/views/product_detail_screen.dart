import 'package:flutter/material.dart';
import '../models/store_models.dart';
import '../widgets/app_widgets.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final discount = product.oldPrice <= 0
        ? 0
        : (((product.oldPrice - product.price) / product.oldPrice) * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(12, 6, 12, 10),
        child: Row(
          children: [
            _QtyButton(
              icon: Icons.remove,
              onTap: qty > 1 ? () => setState(() => qty--) : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('$qty', style: const TextStyle(fontWeight: FontWeight.w800)),
            ),
            _QtyButton(
              icon: Icons.add,
              filled: true,
              onTap: () => setState(() => qty++),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text('Add To Cart'),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              product.image,
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            product.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 5),
          const Text(
            '⚡ Available on fast delivery',
            style: TextStyle(
              color: Color(0xff29923b),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                '₹${product.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              const SizedBox(width: 10),
              Text(
                '₹${product.oldPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),
              if (discount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$discount%',
                    style: const TextStyle(color: Colors.white, fontSize: 9),
                  ),
                ),
              const Spacer(),
              const Icon(Icons.star, size: 18, color: Colors.amber),
              Text(
                '${product.rating.toStringAsFixed(1)} Rating',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xffe9f7e9),
              borderRadius: BorderRadius.circular(4),
              border: const Border(left: BorderSide(color: kGreen, width: 3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: kGreen, size: 16),
                SizedBox(width: 7),
                Text(
                  'In Stock (10 available)',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Description', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text(
            'Premium quality product sourced from trusted nearby stores. '
            'Fresh, carefully selected and delivered quickly to your doorstep.',
            style: TextStyle(fontSize: 11, height: 1.5, color: Colors.grey),
          ),
          const SizedBox(height: 18),
          const SectionHeader(title: 'Related products', action: 'View all'),
          const SizedBox(height: 8),
          SizedBox(
            height: 178,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: demoProducts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, i) => ProductCard(product: demoProducts[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool filled;

  const _QtyButton({
    required this.icon,
    this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: filled ? Colors.black : Colors.white,
        child: Icon(
          icon,
          size: 18,
          color: filled ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
