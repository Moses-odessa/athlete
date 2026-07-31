import 'package:flutter/widgets.dart';

import '../../domain/entities/localized_text.dart';

/// Резолвит [LocalizedText] по текущей локали приложения.
extension LocalizedTextContext on BuildContext {
  String tr(LocalizedText text) =>
      text.forLanguage(Localizations.localeOf(this).languageCode);
}
