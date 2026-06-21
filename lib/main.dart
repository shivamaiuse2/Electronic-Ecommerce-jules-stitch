import 'package:electronic_ecommerce_jules_stitch/shared/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'core/services/local_storage_service.dart';
import 'features/authentication/splash_screen.dart';
import 'features/authentication/onboarding_screen.dart';
import 'features/authentication/login_signup_gateway_screen.dart';
import 'features/authentication/login_screen.dart';
import 'features/authentication/signup_screen.dart';
import 'features/authentication/mobile_number_entry_screen.dart';
import 'features/authentication/otp_verification_screen.dart';
import 'features/authentication/auth_bloc.dart';
import 'features/home/home_dashboard_screen.dart';
import 'features/home/main_navigation_shell.dart';
import 'features/cart/shopping_cart_screen.dart';
import 'features/cart/cart_bloc.dart';
import 'features/wishlist/wishlist_screen.dart';
import 'features/wishlist/wishlist_bloc.dart';
import 'features/products/filter_bloc.dart';
import 'features/checkout/address_bloc.dart';
import 'features/products/category_hub_screen.dart';
import 'features/products/brand_directory_screen.dart';
import 'features/products/search_results_screen.dart';
import 'features/products/product_comparison_screen.dart';
import 'features/products/product_reviews_screen.dart';
import 'features/products/razer_brand_store_screen.dart';
import 'features/products/laptop_collection_screen.dart';
import 'features/products/product_details_screen.dart';
import 'features/checkout/select_delivery_address_screen.dart';
import 'features/checkout/add_new_address_screen.dart';
import 'features/checkout/choose_payment_method_screen.dart';
import 'features/orders/order_confirmed_screen.dart';
import 'features/orders/my_orders_screen.dart';
import 'features/orders/track_order_screen.dart';
import 'features/profile/profile_dashboard_screen.dart';
import 'features/profile/account_settings_screen.dart';
import 'features/profile/notifications_center_screen.dart';
import 'features/profile/help_support_screen.dart';
import 'features/profile/live_chat_support_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(AuthCheckRequested())),
        BlocProvider(create: (context) => CartBloc()..add(LoadCart())),
        BlocProvider(create: (context) => WishlistBloc()..add(LoadWishlist())),
        BlocProvider(create: (context) => FilterBloc()),
        BlocProvider(create: (context) => AddressBloc()..add(LoadAddresses())),
      ],
      child: MaterialApp.router(
        title: 'ElectroStream',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding1',
      builder: (context, state) => const OnboardingScreen(
        title: 'Premium Gadgets Selection',
        description: 'Explore our handpicked collection of high-end electronics from world-class brands.',
        image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCHv7Kxy_AE2JWPWgzImlSF2H2mff5uAz5guGPuR5mjWoWwsK3awEQ3J6zz9rvi8AP0ncSSobi1_b1STUURBq6Cx-dZZZirvCreVZDOqeKdm57WdXrgQ-lPrtF-1k-jd_JcFLD9yd3s8MnJca8r1F7Hpxl89KwXVG8jA2gALX2UzM9sLZNqXhn5YfHEFmgYLVokDhhprB3kpX1m9fV7vR7m86p576p4rtHZfDpoe6eDveekGUmfT-WZgIDl6zwCjUW4VGenZeZxJII',
        step: 1,
        nextRoute: '/onboarding2',
      ),
    ),
    GoRoute(
      path: '/onboarding2',
      builder: (context, state) => const OnboardingScreen(
        title: 'Seamless Tech Integration',
        description: 'Experience the perfect blend of performance and design in every device we offer.',
        image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC2b2iRelipNbABODEwcOUmm74niEzOY0ZuUgFXMLmfA6kidTEPbb0yE4bDHvbIUW_pXs5TrP4Tfiy26t4FlGlwkJ-G_lZkqMZLnAFaaeiylDrkOD9lpMlzTr5ozo0gkZTqcTONkomzb2s4Rv9_K_BMdJE0fkhKfnxYDcLErgiDvEodm8Loz7LLof1PMKJpqI8ak5Lhx9fljpHIYjZz0JPZRf2mwpLdXUtn4c4vFvEUfAN4H3VDBghNef-bA9-9uKFNA6YcNAXm9GY',
        step: 2,
        nextRoute: '/onboarding3',
      ),
    ),
    GoRoute(
      path: '/onboarding3',
      builder: (context, state) => const OnboardingScreen(
        title: 'Fast & Secure Delivery',
        description: 'Get your favorite gadgets delivered to your doorstep with our lightning-fast shipping.',
        image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAFADU2k9s9yi9OiJkrklAPB1BHzW2rjXuwOcoqnMSBgJ3wQZNZLX4gHrdfpapXKyxWZbAStYDdiAlwdl6v8YheC-klwGoTD9868M3mgpMOUmReXgVWMlS-uZyPzI0qLDhW-BRiIfKm7jFOY1bbEnW_SoP7xuX_D9d50W5z0GCTZGInY41hfUImHZbAnJbNvXswXR6iB8MFf22QpFD6YKbLyaQ4wo9nefxW2-JnUr6k2yD4H4n25dVZMYUwI5G0nxjkWLbkxM5nV6w',
        step: 3,
        nextRoute: '/gateway',
      ),
    ),
    GoRoute(
      path: '/gateway',
      builder: (context, state) => const LoginSignupGatewayScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/mobile-entry',
      builder: (context, state) => const MobileNumberEntryScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => const OtpVerificationScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainNavigationShell(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeDashboardScreen(),
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => const ShoppingCartScreen(),
        ),
        GoRoute(
          path: '/wishlist',
          builder: (context, state) => const WishlistScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileDashboardScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoryHubScreen(),
    ),
    GoRoute(
      path: '/brands',
      builder: (context, state) => const BrandDirectoryScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) {
        final query = state.uri.queryParameters['q'];
        final category = state.uri.queryParameters['category'];
        return SearchResultsScreen(query: query, category: category);
      },
    ),
    GoRoute(
      path: '/compare',
      builder: (context, state) => const ProductComparisonScreen(),
    ),
    GoRoute(
      path: '/reviews',
      builder: (context, state) => const ProductReviewsScreen(),
    ),
    GoRoute(
      path: '/razer-store',
      builder: (context, state) => const RazerBrandStoreScreen(),
    ),
    GoRoute(
      path: '/laptops',
      builder: (context, state) => const LaptopCollectionScreen(),
    ),
    GoRoute(
      path: '/product-details',
      builder: (context, state) {
        final product = state.extra as Product;
        return ProductDetailsScreen(product: product);
      },
    ),
    GoRoute(
      path: '/address-selection',
      builder: (context, state) => const SelectDeliveryAddressScreen(),
    ),
    GoRoute(
      path: '/add-address',
      builder: (context, state) => const AddNewAddressScreen(),
    ),
    GoRoute(
      path: '/payment-method',
      builder: (context, state) => const ChoosePaymentMethodScreen(),
    ),
    GoRoute(
      path: '/order-confirmed',
      builder: (context, state) => const OrderConfirmedScreen(),
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const MyOrdersScreen(),
    ),
    GoRoute(
      path: '/track-order',
      builder: (context, state) => const TrackOrderScreen(),
    ),
    GoRoute(
      path: '/account-settings',
      builder: (context, state) => const AccountSettingsScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsCenterScreen(),
    ),
    GoRoute(
      path: '/help-support',
      builder: (context, state) => const HelpSupportScreen(),
    ),
    GoRoute(
      path: '/live-chat',
      builder: (context, state) => const LiveChatSupportScreen(),
    ),
  ],
);
