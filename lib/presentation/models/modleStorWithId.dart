class CategoryDetailsResponse {
  final bool successful;
  final String message;
  final CategoryDetailsData data;
  final int statusCode;

  CategoryDetailsResponse({
    required this.successful,
    required this.message,
    required this.data,
    required this.statusCode,
  });

  factory CategoryDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CategoryDetailsResponse(
      successful: json['successful'],
      message: json['message'],
      data: CategoryDetailsData.fromJson(json['data']),
      statusCode: json['status_code'],
    );
  }
}

class CategoryDetailsData {
  final Category category;

  CategoryDetailsData({
    required this.category,
  });

  factory CategoryDetailsData.fromJson(Map<String, dynamic> json) {
    return CategoryDetailsData(
      category: Category.fromJson(json['category']),
    );
  }
}

class Category {
  final int id;
  final String name;
  final String image;
  final StoresData stores;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.stores,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      stores: StoresData.fromJson(json['stores']),
    );
  }
}

class StoresData {
  final List<StoresId> data;
  final StorePagination pagination;

  StoresData({
    required this.data,
    required this.pagination,
  });

  factory StoresData.fromJson(Map<String, dynamic> json) {
    return StoresData(
      data: List<StoresId>.from(json['data'].map((x) => StoresId.fromJson(x))),
      pagination: StorePagination.fromJson(json['pagination']),
    );
  }
}

class StoresId {
  final int id;
  final String name;
  final String? image;
  final String address;

  StoresId({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
  });

  factory StoresId.fromJson(Map<String, dynamic> json) {
    return StoresId(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      address: json['address'],
    );
  }
}

class StorePagination {
  final int totalPages;
  final int currentPage;
  final bool hasMorePages;

  StorePagination({
    required this.totalPages,
    required this.currentPage,
    required this.hasMorePages,
  });

  factory StorePagination.fromJson(Map<String, dynamic> json) {
    return StorePagination(
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      hasMorePages: json['hasMorePages'],
    );
  }
}
