class FavoriteResponse {
  final bool successful;
  final String message;
  final int statusCode;
  final FavoriteData data;

  FavoriteResponse({
    required this.successful,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteResponse(
      successful: json['successful'],
      message: json['message'],
      statusCode: json['status_code'],
      data: FavoriteData.fromJson(json['data']),
    );
  }
}

class FavoriteData {
  final List<FavoriteProduct> products;
  final int totalPages;
  final int currentPage;
  final bool hasMorePages;

  FavoriteData({
    required this.products,
    required this.totalPages,
    required this.currentPage,
    required this.hasMorePages,
  });

  factory FavoriteData.fromJson(Map<String, dynamic> json) {
    return FavoriteData(
      products: (json['products'] as List)
          .map((e) => FavoriteProduct.fromJson(e))
          .toList(),
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      hasMorePages: json['hasMorePages'],
    );
  }
}

class FavoriteProduct {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;
  final int amount;
  final String store;
  final int isFavorite;

  FavoriteProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.amount,
    required this.store,
    required this.isFavorite,
  });

  factory FavoriteProduct.fromJson(Map<String, dynamic> json) {
    return FavoriteProduct(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      amount: json['amount'],
      store: json['store'],
      isFavorite: json['isFavorite'],
    );
  }
}
