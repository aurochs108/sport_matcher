import 'package:json_annotation/json_annotation.dart';

part 'auth_tokens_entity.g.dart';

@JsonSerializable(createFactory: false)
class AuthTokensEntity {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;

  AuthTokensEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });

  Map<String, dynamic> toJson() => _$AuthTokensEntityToJson(this);
}
