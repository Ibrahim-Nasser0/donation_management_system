/// Application Configuration
class AppConfig {
  AppConfig._();

  static const String appName = 'Donation Management System';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';

  // Developer Info
  static const String developerName = 'Ibrahim Nasser and Abdalluh Mohamed';
  static const String developerGithub = 'https://github.com/Ibrahim-Nasser0';
  static const String developerProfile = '';
  static const String developerLinkedIn =
      'https://www.linkedin.com/in/ibrahim-nasser-mobile';
  static const String developerEmail = 'ibrahimnasser.mobile@gmail.com';

  // Environment
  static const bool isProduction = false;
  static const bool enableLogging = true;

  // API Configuration
  static String get baseUrl {
    return isProduction
        ? 'https://api.production.com'
        : 'https://api.development.com';
  }
}
