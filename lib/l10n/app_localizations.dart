import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Supplier App'**
  String get appTitle;

  /// Logo text placeholder
  ///
  /// In en, this message translates to:
  /// **'logo'**
  String get logo;

  /// Home navigation label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Orders navigation label
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// Cart navigation label
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// Profile navigation label
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Products navigation label
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// Featured products section title
  ///
  /// In en, this message translates to:
  /// **'Featured Products'**
  String get featuredProducts;

  /// Create order button label
  ///
  /// In en, this message translates to:
  /// **'Create Order'**
  String get createOrder;

  /// Invoices button label
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoices;

  /// Inventory menu label
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// Reports menu label
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// Settings menu label
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Notifications menu label
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Support menu label
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// Dashboard menu label
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// Login screen welcome title
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// Login button label
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Login success message
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get loginSuccessful;

  /// Email field hint text
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// Password field hint text
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Forgot password link text
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// Forgot password coming soon message
  ///
  /// In en, this message translates to:
  /// **'Forgot password functionality coming soon!'**
  String get forgotPasswordComingSoon;

  /// Don't have account text
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// Sign up link text
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// Create account title and button
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Sign up subtitle
  ///
  /// In en, this message translates to:
  /// **'Join our supplier network today'**
  String get joinSupplierNetwork;

  /// Full name field hint
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// Company name field hint
  ///
  /// In en, this message translates to:
  /// **'Company name'**
  String get companyName;

  /// Phone number field hint
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// Confirm password field hint
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// Terms agreement prefix
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get iAgreeToThe;

  /// Terms and conditions link text
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// And conjunction
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get and;

  /// Privacy policy link text
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Account created success message
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get accountCreatedSuccessfully;

  /// Already have account text
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// Sign in link text
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// Email required validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get pleaseEnterEmail;

  /// Email format validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get pleaseEnterValidEmail;

  /// Password required validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// Password minimum length validation
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// Full name required validation
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name'**
  String get pleaseEnterFullName;

  /// First and last name validation
  ///
  /// In en, this message translates to:
  /// **'Please enter your first and last name'**
  String get pleaseEnterFirstLastName;

  /// Company name required validation
  ///
  /// In en, this message translates to:
  /// **'Please enter your company name'**
  String get pleaseEnterCompanyName;

  /// Phone number required validation
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterPhoneNumber;

  /// Phone number format validation
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get pleaseEnterValidPhoneNumber;

  /// Password required validation for signup
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get pleaseEnterAPassword;

  /// Password 8 char minimum validation
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMinLengthEight;

  /// Password complexity validation
  ///
  /// In en, this message translates to:
  /// **'Password must contain uppercase, lowercase, and number'**
  String get passwordRequirements;

  /// Confirm password required validation
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmPassword;

  /// Passwords mismatch validation
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Terms agreement required message
  ///
  /// In en, this message translates to:
  /// **'Please agree to the terms and conditions'**
  String get pleaseAgreeToTerms;

  /// Search coming soon message
  ///
  /// In en, this message translates to:
  /// **'Search functionality coming soon!'**
  String get searchComingSoon;

  /// Notifications coming soon message
  ///
  /// In en, this message translates to:
  /// **'Notifications coming soon!'**
  String get notificationsComingSoon;

  /// Product added to order message
  ///
  /// In en, this message translates to:
  /// **'{productName} added to order!'**
  String addedToOrder(String productName);

  /// Create order navigation message
  ///
  /// In en, this message translates to:
  /// **'Navigate to Create Order screen'**
  String get navigateToCreateOrder;

  /// Invoices navigation message
  ///
  /// In en, this message translates to:
  /// **'Navigate to Invoices screen'**
  String get navigateToInvoices;

  /// Orders navigation message
  ///
  /// In en, this message translates to:
  /// **'Navigate to Orders screen'**
  String get navigateToOrders;

  /// Cart navigation message
  ///
  /// In en, this message translates to:
  /// **'Navigate to Cart screen'**
  String get navigateToCart;

  /// Profile navigation message
  ///
  /// In en, this message translates to:
  /// **'Navigate to Profile screen'**
  String get navigateToProfile;

  /// Home menu item description
  ///
  /// In en, this message translates to:
  /// **'Dashboard and overview'**
  String get descriptionDashboard;

  /// Products menu item description
  ///
  /// In en, this message translates to:
  /// **'Browse and manage products'**
  String get descriptionProducts;

  /// Orders menu item description
  ///
  /// In en, this message translates to:
  /// **'View and manage orders'**
  String get descriptionOrders;

  /// Cart menu item description
  ///
  /// In en, this message translates to:
  /// **'Shopping cart items'**
  String get descriptionCart;

  /// Profile menu item description
  ///
  /// In en, this message translates to:
  /// **'Account and settings'**
  String get descriptionProfile;

  /// Create order menu item description
  ///
  /// In en, this message translates to:
  /// **'Start a new order'**
  String get descriptionCreateOrder;

  /// Invoices menu item description
  ///
  /// In en, this message translates to:
  /// **'View billing and invoices'**
  String get descriptionInvoices;

  /// Inventory menu item description
  ///
  /// In en, this message translates to:
  /// **'Manage stock levels'**
  String get descriptionInventory;

  /// Reports menu item description
  ///
  /// In en, this message translates to:
  /// **'Analytics and insights'**
  String get descriptionReports;

  /// Settings menu item description
  ///
  /// In en, this message translates to:
  /// **'App preferences'**
  String get descriptionSettings;

  /// Notifications menu item description
  ///
  /// In en, this message translates to:
  /// **'View notifications'**
  String get descriptionNotifications;

  /// Support menu item description
  ///
  /// In en, this message translates to:
  /// **'Help and contact'**
  String get descriptionSupport;

  /// All filter option
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Pending status
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// Processing status
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// Completed status
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// Cancelled status
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// Search orders placeholder
  ///
  /// In en, this message translates to:
  /// **'Search orders...'**
  String get searchOrders;

  /// Empty orders message
  ///
  /// In en, this message translates to:
  /// **'No orders found'**
  String get noOrdersFound;

  /// Empty orders description
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any orders yet. Create your first order to get started.'**
  String get noOrdersDescription;

  /// Items label
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get items;

  /// Order details title
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// Customer info section title
  ///
  /// In en, this message translates to:
  /// **'Customer Information'**
  String get customerInfo;

  /// Customer name label
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get customerName;

  /// Phone label
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Email label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Delivery info section title
  ///
  /// In en, this message translates to:
  /// **'Delivery Information'**
  String get deliveryInfo;

  /// Delivery address label
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get deliveryAddress;

  /// Delivery date label
  ///
  /// In en, this message translates to:
  /// **'Delivery Date'**
  String get deliveryDate;

  /// Order summary section title
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// Subtotal label
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// Shipping label
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get shipping;

  /// Tax label
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// Total label
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Contact customer button
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contactCustomer;

  /// Start processing order button
  ///
  /// In en, this message translates to:
  /// **'Start Processing'**
  String get startProcessing;

  /// Mark order completed button
  ///
  /// In en, this message translates to:
  /// **'Mark Completed'**
  String get markCompleted;

  /// View invoice button
  ///
  /// In en, this message translates to:
  /// **'View Invoice'**
  String get viewInvoice;

  /// Reorder button
  ///
  /// In en, this message translates to:
  /// **'Reorder'**
  String get reorder;

  /// View details button
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// Filter coming soon message
  ///
  /// In en, this message translates to:
  /// **'Filter functionality coming soon!'**
  String get filterComingSoon;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
