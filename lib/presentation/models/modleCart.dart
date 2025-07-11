class CartResponse {
  final bool successful;
  final String message;
  final CartData data;
  final int statusCode;

  CartResponse({
    required this.successful,
    required this.message,
    required this.data,
    required this.statusCode,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      successful: json['successful'],
      message: json['message'],
      data: CartData.fromJson(json['data']),
      statusCode: json['status_code'],
    );
  }
}

class CartData {
  final Cart cart;

  CartData({
    required this.cart,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      cart: Cart.fromJson(json['Cart']),
    );
  }
}

class Cart {
  final int id;
  final double totalPrice;
  final List<CartItem> items;

  Cart({
    required this.id,
    required this.totalPrice,
    required this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    List<CartItem> items =
        itemsList.map((item) => CartItem.fromJson(item)).toList();

    return Cart(
      id: json['id'],
      totalPrice: (json['total_price'] as num).toDouble(),
      items: items,
    );
  }
}

class CartItem {
  final Product product;
  final int totalQuantity;
  final List<CartItemDetail> cartItems;
  final int availableQuantity;

  CartItem({
    required this.product,
    required this.totalQuantity,
    required this.cartItems,
    required this.availableQuantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    var cartItemsList = json['cart_items'] as List;
    List<CartItemDetail> cartItems =
        cartItemsList.map((item) => CartItemDetail.fromJson(item)).toList();

    return CartItem(
      product: Product.fromJson(json['product']),
      totalQuantity: json['total_quantity'],
      cartItems: cartItems,
      availableQuantity: json['product']['quantity'] ?? 0, // ✅ من داخل المنتج
    );
  }
}

class Product {
  final int id;
  final String name;
  final String image;
  final double price;
  final bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.isFavorite,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: (json['price'] as num).toDouble(),
      isFavorite: json['isFavorite'] == 1,
    );
  }
}

class CartItemDetail {
  final int id;
  final int quantity;

  CartItemDetail({
    required this.id,
    required this.quantity,
  });

  factory CartItemDetail.fromJson(Map<String, dynamic> json) {
    return CartItemDetail(
      id: json['id'],
      quantity: json['quantity'],
    );
  }
}
