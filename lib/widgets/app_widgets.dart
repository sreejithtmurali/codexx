import 'package:flutter/material.dart';
import '../models/store_models.dart';

const kGreen = Color(0xff27b53f);
const kDark = Color(0xff161616);

class AppSearchBar extends StatelessWidget {
  final String hint;
  final VoidCallback? onFilter;

  const AppSearchBar({
    super.key,
    required this.hint,
    this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xffeeeeee)),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 20, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    hint,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: onFilter,
          icon: const Icon(Icons.tune_rounded),
        ),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.action,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: kDark,
            ),
          ),
        ),
        if (action != null)
          TextButton(
            onPressed: onTap,
            child: Text(
              action!,
              style: const TextStyle(
                color: kGreen,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 126,

      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0d000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.image,
                      height: 102,
                      width: 126,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 82,
                        color: const Color(0xffeeeeee),
                        child: Container(
                          width: 126,height: 102,
                            child: const Icon(Icons.image_outlined)),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                        color: kGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 18),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: const Icon(Icons.bookmark, color: Colors.black, size: 18),
                  ),
                  Positioned(
                   left: 8,
                   bottom: 2,
                   right: 0,
                   child:  Text(
                      product.unit,
                      style: const TextStyle(fontSize: 9, color: Colors.white),
                    ),
                  )
                ],
              ),


              const SizedBox(height: 4),
              Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11,color: Colors.green, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              Text(
                '₹${product.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 2),
              const Text(
                '1.2 km away',
                style: TextStyle(fontSize: 9, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StoreCard extends StatelessWidget {
  final Store store;
  final VoidCallback? onTap;

  const StoreCard({
    super.key,
    required this.store,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0d000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    store.image,
                    width: double.infinity,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 110,
                      color: const Color(0xffeeeeee),
                      child: Container(
                          width: double.infinity,
                          height: 110,
                          child: const Icon(Icons.storefront_outlined)),
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      store.distance,
                      style: const TextStyle(color: Colors.white, fontSize: 9),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    store.name,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                  ),
                ),
                const Icon(Icons.star, color: Colors.amber, size: 12),
                Text(
                  store.rating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 9),
                ),
                Text(
                  "(10)",
                  style: const TextStyle(fontSize: 9),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              '▼ ${store.type}',
              style: const TextStyle(
                color: Color(0xff00a6c8),
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 32,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.zero,
                ),
                onPressed: onTap,
                icon: const Icon(Icons.storefront, size: 14),
                label: const Text(
                  'View Store',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
