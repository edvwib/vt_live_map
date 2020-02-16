import 'package:json_annotation/json_annotation.dart';
import 'package:vt_live_map/core/authentication/domain/entities/auth.dart';

part 'auth_model.g.dart';

@JsonSerializable(
  createToJson: false,
)
class AuthModel extends Auth {
  @JsonKey(name: 'token_type')
  final String tokenType;

  @JsonKey(name: 'expires_in')
  final int expiresIn;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  @JsonKey(name: 'access_token')
  final String accessToken;

  AuthModel(
    final String scope,
    this.tokenType,
    this.expiresIn,
    this.refreshToken,
    this.accessToken,
  ) : super(
          scope: scope,
          tokenType: tokenType,
          expiresIn: expiresIn,
          refreshToken: refreshToken,
          accessToken: accessToken,
        );

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
}
