class LoginResponseDTO {
  final String accesstoken;
  final String refreshToken;
  final String message;
  final bool success;
  final String role;
  LoginResponseDTO({
    required this.accesstoken,
    required this.refreshToken,
    required this.message,
    required this.success,
    required this.role,
  });
}
