class StoreResponsess {
  final bool successful;
  final String message;
  final StoreData data;
  final int statusCode;

  StoreResponsess({
    required this.successful,
    required this.message,
    required this.data,
    required this.statusCode,
  });

  factory StoreResponsess.fromJson(Map<String, dynamic> json) {
    return StoreResponsess(
      successful: json['successful'],
      message: json['message'],
      data: StoreData.fromJson(json['data']),
      statusCode: json['status_code'],
    );
  }
}
class StoreData {
  final Storess store;

  StoreData({required this.store});

  factory StoreData.fromJson(Map<String, dynamic> json) {
    return StoreData(
      store: Storess.fromJson(json['Store']),
    );
  }
}
class Storess {
  final int id;
  final String name;
  final String? image;
  final String address;
  final String category;
  final List<Productss> products;

  Storess({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
    required this.category,
    required this.products,
  });

  factory Storess.fromJson(Map<String, dynamic> json) {
    return Storess(
      id: json['id'],
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      address: json['address'] ?? '',
      category: json['category'] ?? '',
      products: List<Productss>.from(
        json['products'].map((x) => Productss.fromJson(x)),
      ),
    );
  }
}
class Productss {
  final int id;
  final String name;
  final String? image;
  final String description;
  final double price;
  final int amount;
  final String store;
  final bool isFavorite;

  Productss({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.amount,
    required this.store,
    required this.isFavorite,
  });

  factory Productss.fromJson(Map<String, dynamic> json) {
    return Productss(
      id: json['id'],
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      amount: json['amount'],
      store: json['store'] ?? '',
      isFavorite: json['isFavorite'] == 1,
    );
  }
}
