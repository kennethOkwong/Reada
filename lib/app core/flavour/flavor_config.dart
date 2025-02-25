class AppFlavorConfig {
  AppFlavorConfig({
    required this.name,
    required this.apiBaseUrl,
    required this.webUrl,
    required this.sentryDsn,
    required this.amplitudeToken,
    required this.intercomAppID,
    required this.intercomAndroidKey,
    required this.intercomIosKey,
  });
  final String name;
  final String apiBaseUrl;
  final String webUrl;
  final String sentryDsn;
  final String amplitudeToken;
  final String intercomAppID;
  final String intercomAndroidKey;
  final String intercomIosKey;
}
