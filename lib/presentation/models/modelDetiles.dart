class ProductModel {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;
  final int amount;
  final String store;
  final bool isFavorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.amount,
    required this.store,
    required this.isFavorite,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      amount: json['amount'],
      store: json['store'],
      isFavorite: json['isFavorite'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'amount': amount,
      'store': store,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }
}
class ProductResponse {
  final bool successful;
  final String message;
  final int statusCode;
  final ProductModel product;

  ProductResponse({
    required this.successful,
    required this.message,
    required this.statusCode,
    required this.product,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      successful: json['successful'],
      message: json['message'],
      statusCode: json['status_code'],
      product: ProductModel.fromJson(json['data']['product']),
    );
  }
}
