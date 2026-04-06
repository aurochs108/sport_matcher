class EmailRegistrationRequest {
  final String email;
  final String password;

  EmailRegistrationRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
