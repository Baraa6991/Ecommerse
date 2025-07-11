class StoreResponse {
  final bool successful;
  final String message;
  final int statusCode;
  final StoreData data;

  StoreResponse({
    required this.successful,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory StoreResponse.fromJson(Map<String, dynamic> json) {
    return StoreResponse(
      successful: json['successful'] ?? false,
      message: json['message'] ?? '',
      statusCode: json['status_code'] ?? 0,
      data: StoreData.fromJson(json['data']),
    );
  }
}

class StoreData {
  final List<Store> stores;
  final int totalPages;
  final int currentPage;
  final bool hasMorePages;

  StoreData({
    required this.stores,
    required this.totalPages,
    required this.currentPage,
    required this.hasMorePages,
  });

  factory StoreData.fromJson(Map<String, dynamic> json) {
    return StoreData(
      stores: (json['Stores'] as List)
          .map((storeJson) => Store.fromJson(storeJson))
          .toList(),
      totalPages: json['total_pages'] ?? 0,
      currentPage: json['current_page'] ?? 1,
      hasMorePages: json['hasMorePages'] ?? false,
    );
  }
}

class Store {
  final int id;
  final String name;
  final String image;
  final String address;
  final String category;

  Store({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
    required this.category,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      address: json['address'] ?? '',
      category: json['category'] ?? '',
    );
  }
}
