// ignore_for_file: file_names

class Urls {
  static String ip = "192.168.1.3";
  static String baseUrl = "http://$ip:8000/api";
  static String codecheck = '$baseUrl/users/emailVerify';
  static String register = '$baseUrl/users/register';
  static String resendOTP = '$baseUrl/users/resendOTP';
  static String login = '$baseUrl/users/login';
  static String forgetPassword = '$baseUrl/users/forgetPassword';
  static String veryfiyForReset = '$baseUrl/users/resetPassword';
  static String allStore = '$baseUrl/stores';
  static String allCategory = '$baseUrl/categories';
  static String allProduct = '$baseUrl/products';
  static String getFavorite = '$baseUrl/products/favorites/index';
  static String addToCart = '$baseUrl/cart_items';
  static String fatchCart = '$baseUrl/carts';
  static String Profile = '$baseUrl/users/profile';
  static String UpdateProfile = '$baseUrl/users/update';
  static String placeOrder = '$baseUrl/carts/placeOrder';
  static String archive = '$baseUrl/cart_items/archive';
  static String logout = '$baseUrl/users/logout';
  static String searchProducts() {
  return "$baseUrl/products/search/name";
}


  static fatchSstores(int id) {
    return '$baseUrl/categories/$id';
  }

  static fatchProducts(int id) {
    return '$baseUrl/stores/$id';
  }

  static fatchProductsDetils(int id) {
    return '$baseUrl/products/$id';
  }

  static postFavorite(int id) {
    return '$baseUrl/products/favorites/store/$id';
  }

  static deletFavorite(int id) {
    return '$baseUrl/products/favorites/destroy/$id';
  }

  static updateCart(int id) {
    return '$baseUrl/cart_items/$id';
  }

  static deletCart(int id) {
    return '$baseUrl/cart_items/$id';
  }
}
