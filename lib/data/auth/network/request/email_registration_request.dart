import 'package:json_annotation/json_annotation.dart';

part 'email_registration_request.g.dart';

@JsonSerializable(createFactory: false)
class EmailRegistrationRequest {
  final String email;
  final String password;
  final String deviceId;

  EmailRegistrationRequest({
    required this.email,
    required this.password,
    required this.deviceId,
  });

  Map<String, dynamic> toJson() => _$EmailRegistrationRequestToJson(this);
}
