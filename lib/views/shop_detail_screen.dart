import 'package:flutter/material.dart';
import '../models/store_models.dart';
import '../widgets/app_widgets.dart';
import 'product_detail_screen.dart';

class ShopDetailScreen extends StatelessWidget {
  final Store store;

  const ShopDetailScreen({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    const categoryIcons = [
      (Icons.cookie_outlined, 'Snacks'),
      (Icons.ac_unit, 'Frozen'),
      (Icons.local_grocery_store_outlined, 'Oil&Ghee'),
      (Icons.local_drink_outlined, 'Beverage'),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd7ffd0),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              store.name.toUpperCase(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
            Text(
              '▼ ${store.type}    ● ${store.distance}',
              style: const TextStyle(fontSize: 9, color: Color(0xff008a3e)),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            icon: const CircleAvatar(
              backgroundColor: Color(0xff303030),
              child: Icon(Icons.more_horiz, color: Colors.white),
            ),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'share', child: Text('Share')),
              PopupMenuItem(value: 'report', child: Text('Report')),
            ],
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xffd7ffd0),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
              child: Column(
                children: [
                  const AppSearchBar(hint: 'Search Products'),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              'https://images.unsplash.com/photo-1543168256-418811576931?auto=format&fit=crop&w=900&q=80',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(color: Colors.white.withValues(alpha: .20)),
                          const Positioned(
                            left: 16,
                            top: 22,
                            child: Text(
                              'Because\nFamilies\nDeserve\nBetter!',
                              style: TextStyle(
                                color: Color(0xff2a7734),
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                                height: .9,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: categoryIcons
                        .map(
                          (e) => Column(
                            children: [
                              CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.white,
                                child: Icon(e.$1, color: kGreen),
                              ),
                              const SizedBox(height: 5),
                              Text(e.$2, style: const TextStyle(fontSize: 9)),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xffc8ffc6),
                        foregroundColor: const Color(0xff148826),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.category_outlined, size: 16),
                      label: const Text('View More Categories', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 0, 18),
            sliver: SliverList.list(
              children: [
                const SectionHeader(title: '🔥 Special Offers'),
                const SizedBox(height: 8),
                _ProductRow(products: demoProducts),
                const SizedBox(height: 16),
                const SectionHeader(title: 'Trending Now'),
                const SizedBox(height: 8),
                _ProductRow(products: demoProducts),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductRow extends StatelessWidget {
  final List<Product> products;

  const _ProductRow({required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 178,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) => ProductCard(
          product: products[i],
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: products[i]),
            ),
          ),
        ),
      ),
    );
  }
}
