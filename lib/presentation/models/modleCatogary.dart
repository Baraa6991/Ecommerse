class CategoryResponse {
  final bool successful;
  final String message;
  final CategoryData data;
  final int statusCode;

  CategoryResponse({
    required this.successful,
    required this.message,
    required this.data,
    required this.statusCode,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      successful: json['successful'],
      message: json['message'],
      data: CategoryData.fromJson(json['data']),
      statusCode: json['status_code'],
    );
  }
}

class CategoryData {
  final List<Category> categories;
  final int totalPages;
  final int currentPage;
  final bool hasMorePages;

  CategoryData({
    required this.categories,
    required this.totalPages,
    required this.currentPage,
    required this.hasMorePages,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      categories: List<Category>.from(
          json['Categories'].map((x) => Category.fromJson(x))),
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      hasMorePages: json['hasMorePages'],
    );
  }
}

class Category {
  final int id;
  final String name;
  final String? image; 

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
