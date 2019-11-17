class AuthResponse {
  final String scope;
  final String tokenType;
  final int expiresIn;
  final String refreshToken;
  final String accessToken;

  AuthResponse(this.scope, this.tokenType, this.expiresIn, this.refreshToken,
      this.accessToken);

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      json['scope'],
      json['token_type'],
      json['expires_in'],
      json['refresh_token'],
      json['access_token'],
    );
  }
}
