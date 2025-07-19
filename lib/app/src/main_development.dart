import 'package:reada/app/flavour/flavor_config.dart';
import 'package:reada/main_common.dart';

Future<void> main() async {
  final devConfig = AppFlavorConfig(
    name: 'Dev',
    apiBaseUrl: const String.fromEnvironment('BASE_URL_DEV'),
    webUrl: const String.fromEnvironment('WEB_URL_DEV'),
  );
  await maincommon(devConfig);
}
