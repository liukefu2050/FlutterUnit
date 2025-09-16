// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_l10n.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppL10nIt extends AppL10n {
  AppL10nIt([String locale = 'it']) : super(locale);

  @override
  String get deskTabWidgets => 'Raccolta widget';

  @override
  String get deskTabPainter => 'Raccolta disegni';

  @override
  String get deskTabKnowledge => 'Hub conoscitivo';

  @override
  String get deskTabTools => 'Cassetta degli attrezzi';

  @override
  String get deskTabMine => 'Info App';

  @override
  String get messageBoard => 'Bacheca';

  @override
  String get mobileTabWidgets => 'Widget';

  @override
  String get mobileTabPainter => 'Disegno';

  @override
  String get mobileTabKnowledge => 'Conoscenza';

  @override
  String get mobileTabTools => 'Strumenti';

  @override
  String get mobileTabMine => 'Io';

  @override
  String get newBoard => 'Nuovo';

  @override
  String get news => 'Notizie';

  @override
  String get mobileTabMessages => 'MQTT';

  @override
  String get moreNews => 'Altre notizie';
}
