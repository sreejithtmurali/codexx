import 'package:flutter/material.dart';
import '../models/store_models.dart';
import '../widgets/app_widgets.dart';
import 'shop_detail_screen.dart';

class ShopsScreen extends StatefulWidget {
  const ShopsScreen({super.key});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  int selectedChip = 0;

  final chips = const ['All Stores', 'Appliance Store', 'Grocery', 'Bakery'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Discover Nearby Stores',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 3),
            const Text(
              'Browse local stores and find what you need.',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            const SizedBox(height: 14),
            const AppSearchBar(hint: 'Search Shops'),
            const SizedBox(height: 8),
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: chips.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final selected = i == selectedChip;
                  return ChoiceChip(
                    selected: selected,
                    label: Text(chips[i]),
                    avatar: Icon(
                      i == 0 ? Icons.apps : Icons.storefront_outlined,
                      size: 15,
                      color: selected ? Colors.white : Colors.black54,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 10,
                      color: selected ? Colors.white : Colors.black87,
                    ),
                    selectedColor: kGreen,
                    backgroundColor: Colors.white,
                    side: BorderSide.none,
                    onSelected: (_) => setState(() => selectedChip = i),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: demoStores.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 205
                ),
                itemBuilder: (context, index) {
                  final store = demoStores[index];
                  return StoreCard(
                    store: store,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ShopDetailScreen(store: store),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
