class Constants {
  static const String baseUrl = "https://ella-backend.herokuapp.com/api";
}

class Validations {
  static const EMAIL_EMPTY = 'Email cannot be empty';
  static const NOT_EMAIL = 'This is not email';
  static const PASSWORD_EMPTY = 'Password cannot be empty';
  static const PASSWORD_SHORT = 'Password too short';
  static const PASSWORD_LONG = 'Password too long';
  static const FIRSTNAME_EMPTY = 'Firstname cannot be empty';
  static const FIRSTNAME_SHORT = 'Firstname too short';
  static const FIRSTNAME_LONG = 'Firstname too long';
  static const LASTNAME_EMPTY = 'Last name cannot be empty';
  static const LASTNAME_SHORT = 'Lastname too short';
  static const LASTNAME_LONG = 'Lastname too long';
  static const PASSWORD_NOT_MATCH = 'Passwords do not match';
  static const INTERNET_FAILURE = 'No Internet';
  static const SOMETHING_WENT_WRONG = 'Something went wrong!';
}

class AppKeys {
  static const LOCALE = 'locale';
  static const ACCESSTOKEN = 'access_token';
  static const FIRSTNAME = 'firstname';
  static const LASTNAME = 'lastname';
  static const EMAIL = 'email';
  static const PASSWORD = 'password';
}

class Urls {
  static const SIGN_IN_URL = '/v1/users/sign_in/';
  static const SIGN_UP_URL = '/v1/users/sign_up/';
  static const GET_CATEGORY_LIST_URL = '/v1/categories/';
  static const GET_GUID_LIST_URL = '/v1/guides/';
  static const GET_ARTICLE_URL = '/v1/articles/';
}

class DatabaseKeys {
  static const CATEGORY_LIST = 'category_list/';
  static const GUID_LIST = 'guid_list/';
  static const ARTICLE = 'article/';
}
