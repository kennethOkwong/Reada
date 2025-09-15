enum CodeType {
  userVerification(readableName: 'user_verification'),
  passwordReset(readableName: 'password_reset');

  const CodeType({required this.readableName});
  final String readableName;
}
