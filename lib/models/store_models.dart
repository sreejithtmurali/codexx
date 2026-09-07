class Product {
  final String id;
  final String title;
  final String store;
  final String image;
  final double price;
  final double oldPrice;
  final String unit;
  final double rating;
  final bool inStock;

  const Product({
    required this.id,
    required this.title,
    required this.store,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.unit,
    required this.rating,
    this.inStock = true,
  });
}

class Store {
  final String id;
  final String name;
  final String image;
  final String type;
  final String distance;
  final double rating;
  final bool isOpen;

  const Store({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    required this.distance,
    required this.rating,
    this.isOpen = true,
  });
}

class CategoryItem {
  final String title;
  final String image;

  const CategoryItem(this.title, this.image);
}

const demoProducts = <Product>[
  Product(
    id: 'p1',
    title: 'Green Crocer',
    store: 'Green Crocer',
    image: 'https://images.unsplash.com/photo-1447175008436-054170c2e979?auto=format&fit=crop&w=600&q=80',
    price: 45.50,
    oldPrice: 55,
    unit: 'Per 1 KG (Pcs)',
    rating: 4.5,
  ),
  Product(
    id: 'p2',
    title: 'Fresh Carrot',
    store: 'Green Crocer',
    image: 'https://images.unsplash.com/photo-1445282768818-728615cc910a?auto=format&fit=crop&w=600&q=80',
    price: 45.50,
    oldPrice: 55,
    unit: 'Per 1 KG (Pcs)',
    rating: 4.5,
  ),
  Product(
    id: 'p3',
    title: 'Coconut Oil',
    store: 'Origin',
    image: 'https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?auto=format&fit=crop&w=600&q=80',
    price: 760,
    oldPrice: 850,
    unit: '500 ml',
    rating: 4.5,
  ),
  Product(
    id: 'p2',
    title: 'Fresh Carrot',
    store: 'Green Crocer',
    image: 'https://images.unsplash.com/photo-1445282768818-728615cc910a?auto=format&fit=crop&w=600&q=80',
    price: 45.50,
    oldPrice: 55,
    unit: 'Per 1 KG (Pcs)',
    rating: 4.5,
  ),
  Product(
    id: 'p3',
    title: 'Coconut Oil',
    store: 'Origin',
    image: 'https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?auto=format&fit=crop&w=600&q=80',
    price: 760,
    oldPrice: 850,
    unit: '500 ml',
    rating: 4.5,
  ),
];

const demoStores = <Store>[
  Store(
    id: 's1',
    name: 'Green Mart',
    image: 'https://images.unsplash.com/photo-1604719312566-8912e9227c6a?auto=format&fit=crop&w=800&q=80',
    type: 'Supermarket',
    distance: '0.5 km',
    rating: 4.8,
  ),
  Store(
    id: 's2',
    name: 'George Store',
    image: 'https://images.unsplash.com/photo-1583258292688-d0213dc5a3a8?auto=format&fit=crop&w=800&q=80',
    type: 'Supermarket',
    distance: '0.5 km',
    rating: 4.7,
  ),
  Store(
    id: 's3',
    name: 'Daily Needs',
    image: 'https://images.unsplash.com/photo-1534723452862-4c874018d66d?auto=format&fit=crop&w=800&q=80',
    type: 'Grocery',
    distance: '0.9 km',
    rating: 4.6,
  ),
  Store(
    id: 's4',
    name: 'Fresh Basket',
    image: 'https://images.unsplash.com/photo-1578916171728-46686eac8d58?auto=format&fit=crop&w=800&q=80',
    type: 'Supermarket',
    distance: '1.2 km',
    rating: 4.5,
  ),
];
