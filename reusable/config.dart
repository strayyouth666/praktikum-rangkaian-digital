

abstract class Config {
  // static String protocol = dotenv.env['PROTOCOL']!;
  // static String baseUrl = dotenv.env['BASE_URL']!;

  static String credentialKey = "_user_auth";
  static String materialDetailIframeID = "iframe-material-preview";
  static String dpraDraftKey = "dpra_draft";

  static int minFinancialYears = 3;
  static int maxFinancialYears = 5;
}

