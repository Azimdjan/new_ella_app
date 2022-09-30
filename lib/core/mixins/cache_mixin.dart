import 'package:ella/core/local_source/local_source.dart';

import '../../injector_container.dart';

mixin CacheMixin {
  final localSource = sl<LocalSource>();

  void setUserInfo({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String token,
  }) {
    localSource.setFirstName(firstName);
    localSource.setLastName(lastName);
    localSource.setEmail(email);
    localSource.setPassword(password);
    localSource.setAccessToken(token);
  }
}
