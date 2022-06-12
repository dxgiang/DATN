import 'dart:async';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:social_media/commons/http_authorization.dart';
import 'package:social_media/commons/utils/pretty_json.dart';

class TokenAuthentication {
  String? _token;
  String? _refreshToken;
  AuthorizationType? _tokenType;

  TokenAuthentication({
    String? token,
    String? refreshToken,
    AuthorizationType? type,
  })  : _token = token,
        _refreshToken = refreshToken,
        _tokenType = type;

  bool get tokenValid => _token != null && !JwtDecoder.isExpired(_token!);

  bool get refreshTokenValid =>
      _refreshToken != null && !JwtDecoder.isExpired(_refreshToken!);

  String? get token => _token;

  AuthorizationType? get type => _tokenType;

  String? get refreshToken => _refreshToken;

  FutureOr<bool> setToken({
    required String token,
    required String refreshToken,
    AuthorizationType? tokenType = AuthorizationType.bearer,
    bool saveToPrefs = true,
  }) async {
    _token = token;
    _refreshToken = refreshToken;
    _tokenType = tokenType;
    return true;
  }

  void clearToken() {
    _token = null;
    _refreshToken = null;
    _tokenType = null;
  }

  Map<String, dynamic> toMap() => {
        "token": _token,
        "refreshToken": _refreshToken,
        "type": _tokenType?.toShortString(),
      };

  factory TokenAuthentication.fromMap(Map<String, dynamic> map) =>
      TokenAuthentication(
        token: map['token'],
        refreshToken: map['refreshToken'],
        type: map['type'] != null
            ? AuthorizationTypeExt.fromString(map['type'])
            : null,
      );

  TokenAuthentication copyWith(
      {String? token, String? refreshToken, AuthorizationType? type}) {
    return TokenAuthentication(
      token: token,
      refreshToken: refreshToken,
      type: type,
    );
  }

  @override
  String toString() {
    return prettyJson(toMap());
  }
}
