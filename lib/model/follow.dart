import 'dart:convert';

class Follow {
  final String email;
  Follow({
    this.email,
  });

  Follow copyWith({
    String email,
  }) {
    return Follow(
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }

  static Follow fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Follow(
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  static Follow fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Follow(email: $email)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Follow && o.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}
