class ArchivedCartItemModel {
  final String groupOrderedAt;
  final List<ArchivedItem> items;

  ArchivedCartItemModel({
    required this.groupOrderedAt,
    required this.items,
  });

  factory ArchivedCartItemModel.fromJson(Map<String, dynamic> json) {
    return ArchivedCartItemModel(
      groupOrderedAt: json['group_ordered_at'],
      items: List<ArchivedItem>.from(
        json['items'].map((e) => ArchivedItem.fromJson(e)),
      ),
    );
  }
}

class ArchivedItem {
  final int id;
  final int quantity;
  final Product product;

  ArchivedItem({
    required this.id,
    required this.quantity,
    required this.product,
  });

  factory ArchivedItem.fromJson(Map<String, dynamic> json) {
    return ArchivedItem(
      id: json['id'],
      quantity: json['quantity'],
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String image;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
