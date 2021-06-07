import 'package:base/library.dart';
import 'package:base/modules/home/home_screen.dart';

import 'modules/initial/initial_screen.dart';

class AppRoute {
  static const init = '/';
  static const home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.init:
        return GetPageRoute(page: () => InitScreen());
      case AppRoute.home:
        return GetPageRoute(page: () => HomeScreen());
      default:
        return GetPageRoute(page: () => Center(child: Text('undefined')));
    }
  }
}
