import 'package:base/library.dart';

import 'language_base.dart';
import 'language_en.dart';
import 'language_vi.dart';

class L {
  static get instance {
    var context = Get.context;
    assert(context != null);
    var instance = Localizations.of<Languages>(context!, Languages);
    if (instance != null) return instance;
    throw Exception('No instance of L present');
  }

  static get delegate => AppLocalizationDelegate();
}

class AppLocalizationDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationDelegate();

  Map<Locale, Languages> get _mapLanguages {
    return {
      Locale.fromSubtags(languageCode: 'en'): LanguageEn(),
      Locale.fromSubtags(languageCode: 'vi'): LanguageVi(),
    };
  }

  List<Locale> get supportedLocales => List.from(_mapLanguages.keys);

  bool _isSupported(Locale locale) => _mapLanguages.containsKey(locale);

  Future<Languages> _load(Locale locale) async {
    var result = _mapLanguages[locale];
    return result ?? LanguageEn();
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Languages> load(Locale locale) => _load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}
