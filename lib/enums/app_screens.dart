/// Enumeration of all screens in the Supplier App
/// Used for navigation and menu item definitions
enum AppScreens {
  // Authentication screens
  login('login', 'Login'),
  signup('signup', 'Sign Up'),

  // Main app screens
  home('home', 'Home'),
  products('products', 'Products'),
  orders('orders', 'Orders'),
  cart('cart', 'Cart'),
  profile('profile', 'Profile'),

  // Secondary screens
  createOrder('create-order', 'Create Order'),
  invoices('invoices', 'Invoices'),
  inventory('inventory', 'Inventory'),
  reports('reports', 'Reports'),
  settings('settings', 'Settings'),
  support('support', 'Support'),

  // Product related screens
  productDetails('product-details', 'Product Details'),
  productCategories('product-categories', 'Categories'),

  // Order related screens
  orderDetails('order-details', 'Order Details'),
  orderHistory('order-history', 'Order History'),
  orderTracking('order-tracking', 'Order Tracking'),

  // Profile related screens
  accountSettings('account-settings', 'Account Settings'),
  notifications('notifications', 'Notifications'),
  preferences('preferences', 'Preferences'),
  helpCenter('help-center', 'Help Center'),

  // Business screens
  dashboard('dashboard', 'Dashboard'),
  analytics('analytics', 'Analytics'),
  suppliers('suppliers', 'Suppliers'),
  customers('customers', 'Customers'),

  // System screens
  loading('loading', 'Loading'),
  error('error', 'Error'),
  notFound('not-found', 'Not Found');

  const AppScreens(this.route, this.displayName);

  /// Route name for navigation
  final String route;

  /// Display name for UI
  final String displayName;

  /// Get screen by route name
  static AppScreens? fromRoute(String route) {
    for (AppScreens screen in AppScreens.values) {
      if (screen.route == route) {
        return screen;
      }
    }
    return null;
  }

  /// Get all main navigation screens
  static List<AppScreens> get mainNavigation => [home, orders, cart, profile];

  /// Get all authentication screens
  static List<AppScreens> get authentication => [login, signup];

  /// Get all product related screens
  static List<AppScreens> get productScreens => [
    products,
    productDetails,
    productCategories,
  ];

  /// Get all order related screens
  static List<AppScreens> get orderScreens => [
    orders,
    orderDetails,
    orderHistory,
    orderTracking,
    createOrder,
  ];

  /// Get all business screens
  static List<AppScreens> get businessScreens => [
    dashboard,
    analytics,
    suppliers,
    customers,
    reports,
  ];

  /// Get all settings related screens
  static List<AppScreens> get settingsScreens => [
    settings,
    accountSettings,
    notifications,
    preferences,
    helpCenter,
  ];
}
