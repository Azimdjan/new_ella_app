import 'package:ella/constants/constants.dart';
import 'package:hive/hive.dart';

class LocalSource {
  final Box<dynamic> box;

  LocalSource(this.box);

  void setLocale(String locale) {
    box.put(AppKeys.LOCALE, locale);
  }

  String? getLocale() {
    return box.get(AppKeys.LOCALE);
  }
}
