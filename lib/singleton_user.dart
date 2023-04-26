class UserSession {
  static final UserSession _instance = UserSession._internal();

  factory UserSession() {
    return _instance;
  }

  UserSession._internal();

  late int _userId;
  late String _type;

  int get userId => _userId;
  String get type => _type;

  set userId(int value) {
    _userId = value;
  }

  set type(String value) {
    _type = value;
  }
}