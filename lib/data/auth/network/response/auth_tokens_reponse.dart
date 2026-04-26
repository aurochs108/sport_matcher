import 'package:json_annotation/json_annotation.dart';

part 'auth_tokens_reponse.g.dart';

@JsonSerializable(createToJson: false)
class AuthTokensReponse {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;

  AuthTokensReponse({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory AuthTokensReponse.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensReponseFromJson(json);
}
