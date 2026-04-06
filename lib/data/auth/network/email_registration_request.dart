import 'package:json_annotation/json_annotation.dart';

part 'email_registration_request.g.dart';

@JsonSerializable()
class EmailRegistrationRequest {
  final String email;
  final String password;

  EmailRegistrationRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$EmailRegistrationRequestToJson(this);
}
