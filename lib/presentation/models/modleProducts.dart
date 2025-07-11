class ProductsResponse {
  final bool successful;
  final String message;
  final ProductData data;
  final int statusCode;

  ProductsResponse({
    required this.successful,
    required this.message,
    required this.data,
    required this.statusCode,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      successful: json['successful'],
      message: json['message'],
      data: ProductData.fromJson(json['data']),
      statusCode: json['status_code'],
    );
  }
}

class ProductData {
  final List<Product> products;
  final int totalPages;
  final int currentPage;
  final bool hasMorePages;

  ProductData({
    required this.products,
    required this.totalPages,
    required this.currentPage,
    required this.hasMorePages,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      products:
          (json['Products'] as List).map((e) => Product.fromJson(e)).toList(),
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      hasMorePages: json['hasMorePages'],
    );
  }
}

class Product {
  final int id;
  final String name;
  final String image;
  final double price;
  final String store;
  final bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.store,
    required this.isFavorite,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: (json['price'] as num).toDouble(),
      store: json['store'],
      isFavorite: json['isFavorite'] == 1,
    );
  }
}
