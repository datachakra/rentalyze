class AppConfig {
  // App Information
  static const String appName = 'Rentalyze';
  static const String appDescription =
      'Comprehensive Real Estate Portfolio Management';
  static const String appVersion = '1.0.0';

  // Virtual Domain Configuration (Smart Hack using datachakra.net)
  static const String virtualDomain = 'rentalyze.io'; // What users see
  static const String realDomain = 'rentalyze.datachakra.net'; // Actual hosting
  static const String webUrl = 'https://rentalyze.datachakra.net';
  static const String apiUrl = 'https://rentalyze.datachakra.net/api';

  // Environment Configuration
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'production',
  );

  // Firebase Configuration
  static const String firebaseProjectId = 'rentalyze-app';

  // API Configuration
  static const String apiVersion = 'v1';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Feature Flags
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enablePerformanceMonitoring = true;

  // App Store Configuration
  static const String iosAppId = ''; // To be updated when published
  static const String androidPackageName = 'com.rentalyze.rentalyze';

  // Social Media & Marketing
  static const String twitterHandle = '@rentalyze';
  static const String supportEmail = 'support@rentalyze.app';
  static const String helpEmail = 'help@rentalyze.app';

  // Deep Linking
  static const String deepLinkScheme = 'https';
  static const String deepLinkHost = 'rentalyze.app';

  // Development Settings
  static bool get isProduction => environment == 'production';
  static bool get isDevelopment => environment == 'development';
  static bool get isStaging => environment == 'staging';

  // App Urls
  static String get fullAppUrl => '$webUrl/app';
  static String get dashboardUrl => '$webUrl/dashboard';
  static String get propertiesUrl => '$webUrl/properties';
  static String get analyticsUrl => '$webUrl/analytics';
}
