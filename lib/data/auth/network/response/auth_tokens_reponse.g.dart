// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_tokens_reponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthTokensReponse _$AuthTokensReponseFromJson(Map<String, dynamic> json) =>
    AuthTokensReponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      tokenType: json['tokenType'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
    );

Map<String, dynamic> _$AuthTokensReponseToJson(AuthTokensReponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'tokenType': instance.tokenType,
      'expiresIn': instance.expiresIn,
    };
