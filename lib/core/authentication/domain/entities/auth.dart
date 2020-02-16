import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String scope;
  final String tokenType;
  final int expiresIn;
  final String refreshToken;
  final String accessToken;

  Auth({
    this.scope,
    this.tokenType,
    this.expiresIn,
    this.refreshToken,
    this.accessToken,
  });

  @override
  List<Object> get props => [
        this.scope,
        this.tokenType,
        this.expiresIn,
        this.refreshToken,
        this.accessToken,
      ];
}
