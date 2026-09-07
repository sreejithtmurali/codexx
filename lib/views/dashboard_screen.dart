import 'package:flutter/material.dart';
import '../models/store_models.dart';
import '../widgets/app_widgets.dart';
import 'product_detail_screen.dart';
import 'shop_detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const categories = [
    CategoryItem('Bakery', 'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=400&q=80'),
    CategoryItem('Chicken Store', 'https://images.unsplash.com/photo-1587593810167-a84920ea0781?auto=format&fit=crop&w=400&q=80'),
    CategoryItem('Electronics', 'https://images.unsplash.com/photo-1498049794561-7780e7231661?auto=format&fit=crop&w=400&q=80'),
    CategoryItem('Vegetables', 'https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=400&q=80'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            sliver: SliverList.list(
              children: [
                SizedBox(height: 24,),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: kDark),
                    children: [
                      TextSpan(text: 'All your Local Stores in one '),
                      TextSpan(text: 'app', style: TextStyle(color: kGreen)),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'From groceries to gadgets, shop everything you need.',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const SizedBox(height: 14),
                const AppSearchBar(hint: 'Search by products or Shops'),
                const SizedBox(height: 12),
                _WeatherBanner(),
                const SizedBox(height: 16),
                _HeroBanner(),
                const SizedBox(height: 16),
                const SectionHeader(title: 'Trending Nearby'),
                const SizedBox(height: 8),
                SizedBox(
                  height: 178,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: demoProducts.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) => ProductCard(
                      product: demoProducts[index],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(product: demoProducts[index]),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const SectionHeader(title: 'Shop By Store Type', action: 'View all'),
                const SizedBox(height: 8),
                SizedBox(
                  height: 134,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (_, i) {
                      final category = categories[i];
                      return Container(
                        width: 134,
                        height: 134,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset('assets/images/img_1.png', height: 51, width: 74, fit: BoxFit.cover),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category.title,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "BakeryCakes, Pastries, Breads, Biscuits ..",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 10,color: Colors.black45, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 14),
                const SectionHeader(title: 'Nearby Stores', action: 'View all'),
                const SizedBox(height: 8),
                SizedBox(
                  height: 210,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: demoStores.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) => StoreCard(
                      store: demoStores[index],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ShopDetailScreen(store: demoStores[index]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeatherBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Color(0x0d000000), blurRadius: 10, offset: Offset(0, 3)),
        ],
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xffeef6ff),
            child: Icon(Icons.cloudy_snowing, color: Colors.blueGrey, size: 18),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Bad weather may cause a slight delay\nin delivery.',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ),
          CircleAvatar(
            radius: 10,
            backgroundColor: Color(0xff1f2937),
            child: Icon(Icons.close, size: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatefulWidget {
  const _HeroBanner({super.key});

  @override
  State<_HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<_HeroBanner> {
  final PageController _pageController = PageController();

  int currentIndex = 0;

  final List<Map<String, dynamic>> banners = [
    {
      'title': 'Now\ndelivering\ngroceries\nand more',
      'image':
      'assets/images/veg.png',
    },
    {
      'title': 'Fresh food\nat your\ndoorstep',
      'image':
      'assets/images/veg.png',
    },
    {
      'title': 'Shop local\nand save\nmore',
      'image':
      'assets/images/veg.png',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(
          height: 172,
          child: PageView.builder(
            controller: _pageController,
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final banner = banners[index];

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: const Color(0xffff7839),
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    // Text
                    Positioned(
                      left: 16,
                      top: 22,
                      child: SizedBox(
                        width: 172,
                        child: Text(

                          banner['title'],

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            height: .95,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),

                    // Image
                    Positioned(
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Image.asset(
                        banner['image'],
                        width: 195,
                        height: 128,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 195,
                            height: 128,
                            color: Colors.grey.shade300,
                            child: const Icon(
                              Icons.image_not_supported,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
                (index) {
              final bool isActive = currentIndex == index;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 5,
                width: isActive ? 18 : 5,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xffff7839)
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
