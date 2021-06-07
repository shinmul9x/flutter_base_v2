import 'package:base/languages/languages.dart';
import 'package:base/library.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onGenerateRoute: AppRoute.onGenerateRoute,
      localizationsDelegates: [
        L.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L.delegate.supportedLocales,
    );
  }
}
