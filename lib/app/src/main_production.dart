import 'package:reada/app/flavour/flavor_config.dart';
import 'package:reada/main_common.dart';

Future<void> main() async {
  final prodConfig = AppFlavorConfig(
    name: 'Prod',
    apiBaseUrl: const String.fromEnvironment('BASE_URL_PROD'),
    webUrl: const String.fromEnvironment('WEB_URL_PROD'),
  );
  await maincommon(prodConfig);
}
