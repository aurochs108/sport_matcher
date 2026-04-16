import 'package:json_annotation/json_annotation.dart';

part 'token_entity.g.dart';

@JsonSerializable()
class TokenEntity {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;

  TokenEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });

  Map<String, dynamic> toJson() => _$TokenEntityToJson(this);
}
