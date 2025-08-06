import 'package:get_it/get_it.dart';
import 'package:indrive_flutter_client/injection.config.dart';
import 'package:injectable/injectable.dart';

// dart run build_runner build
final locator = GetIt.instance;
@InjectableInit()
Future<void> configureDependencies() async {
  locator.init();
}
