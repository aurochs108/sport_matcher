// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailRegistrationRequest _$EmailRegistrationRequestFromJson(
  Map<String, dynamic> json,
) => EmailRegistrationRequest(
  email: json['email'] as String,
  password: json['password'] as String,
  deviceId: json['deviceId'] as String,
);

Map<String, dynamic> _$EmailRegistrationRequestToJson(
  EmailRegistrationRequest instance,
) => <String, dynamic>{'email': instance.email, 'password': instance.password, 'deviceId': instance.deviceId};
