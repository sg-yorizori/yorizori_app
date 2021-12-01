class TokenReceiver {
  String token;

  TokenReceiver({
    required this.token,
  });

  factory TokenReceiver.fromJson(Map<String, dynamic> json) {
    return TokenReceiver(
      token: json['token'],
    );
  }
}
