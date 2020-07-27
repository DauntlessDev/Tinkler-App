import 'dart:convert';

class Record {
  final String email;
  Record({
    this.email,
  });

  Record copyWith({
    String email,
  }) {
    return Record(
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }

  static Record fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Record(
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  static Record fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Follow(email: $email)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Record && o.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}
