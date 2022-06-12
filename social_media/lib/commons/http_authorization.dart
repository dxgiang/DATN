import 'dart:convert';

enum AuthorizationType { basic, bearer }

extension AuthorizationTypeExt on AuthorizationType {
  String toShortString() {
    switch (this) {
      case AuthorizationType.basic:
        return "Basic";
      case AuthorizationType.bearer:
        return "Bearer";
    }
  }

  static AuthorizationType? fromString(String type) {
    switch (type.toLowerCase()) {
      case "basic":
        return AuthorizationType.basic;
      case "bearer":
        return AuthorizationType.bearer;
      default:
        return null;
    }
  }

  bool compare(Object other) {
    return other is AuthorizationType &&
        other.toShortString() == other.toShortString();
  }
}

mixin Authorization {
  AuthorizationType get type;

  String get credential;

  @override
  String toString() {
    return '${type.toShortString()} $credential';
  }
}

class BasicAuthentication with Authorization {
  final String _username;
  final String _password;

  @override
  AuthorizationType get type => AuthorizationType.basic;

  @override
  String get credential {
    final byte = utf8.encode("$_username:$_password");
    return base64Encode(byte);
  }

  BasicAuthentication({required String username, required String password})
      : _username = username,
        _password = password;
}

class BearerAuthentication with Authorization {
  final String _credential;

  @override
  AuthorizationType get type => AuthorizationType.bearer;

  @override
  String get credential => _credential;

  BearerAuthentication({required String credential}) : _credential = credential;
}

class OauthAuthentication extends BearerAuthentication {
  OauthAuthentication({required String credential})
      : super(credential: credential);
}
