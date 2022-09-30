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

  void setAccessToken(String accessToken) {
    box.put(AppKeys.ACCESSTOKEN, accessToken);
  }

  String? getAccessToken() {
    return box.get(AppKeys.ACCESSTOKEN);
  }

  void setFirstName(String firstName) {
    box.put(AppKeys.FIRSTNAME, firstName);
  }

  String? getFirstName() {
    return box.get(AppKeys.FIRSTNAME);
  }

  void setLastName(String lastName) {
    box.put(AppKeys.LASTNAME, lastName);
  }

  String? getLastName() {
    return box.get(AppKeys.LASTNAME);
  }

  void setEmail(String email) {
    box.put(AppKeys.EMAIL, email);
  }

  String? getEmail() {
    return box.get(AppKeys.EMAIL);
  }

  void setPassword(String password) {
    box.put(AppKeys.PASSWORD, password);
  }

  String? getPassword() {
    return box.get(AppKeys.PASSWORD);
  }
}
