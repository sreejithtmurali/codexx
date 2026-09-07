class CartItem {
  final String id;
  final String name;
  final String unit;
  final double price;
  final int quantity;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.name,
    required this.unit,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  CartItem copyWith({
    String? id,
    String? name,
    String? unit,
    double? price,
    int? quantity,
    String? imageUrl,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}