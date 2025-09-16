// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_l10n.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppL10nRu extends AppL10n {
  AppL10nRu([String locale = 'ru']) : super(locale);

  @override
  String get deskTabWidgets => 'Коллекция виджетов';

  @override
  String get deskTabPainter => 'Коллекция рисунков';

  @override
  String get deskTabKnowledge => 'База знаний';

  @override
  String get deskTabTools => 'Инструменты';

  @override
  String get deskTabMine => 'Информация';

  @override
  String get messageBoard => 'Доска сообщений';

  @override
  String get mobileTabWidgets => 'Виджеты';

  @override
  String get mobileTabPainter => 'Рисование';

  @override
  String get mobileTabKnowledge => 'Знания';

  @override
  String get mobileTabTools => 'Инструменты';

  @override
  String get mobileTabMine => 'Мои';

  @override
  String get newBoard => 'Создать';

  @override
  String get news => 'Новости';

  @override
  String get mobileTabMessages => 'MQTT';

  @override
  String get moreNews => 'Больше новостей';
}
