

class URLRoutes {
// Meta
  static const String getMeta = '/api/user/meta';

// OTP
  static const String sendOTP = '/api/user/sendotp';
  static const String verifyOTP = '/api/user/verifyotp';

// Profile
  static const String getProfile = '/api/user/profile';

// Orders
  static const String getShops = '/api/shop/stores';

  // Containers
  static const String getContainers = '/api/user/container';

  static const String getShopContainers = '/api/shop/containers';
  static const String getCategories = '/api/shop/categories';

// Stores

// Items
  static const String getShopItems = '/api/shop/items';
  static const String getListedItem = '/api/shop/listed-item';
  static const String searchItem = '/api/shop/search';
  //Search Store
  static const String searchStore = '/api/shop/store/search';

  //Customer
  static const String getCustomerProfile = '/api/user/profile';
}
