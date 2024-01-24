class ConfidenceUser {
  String email;
  String name;
  String? urlPhoto;

  ConfidenceUser({
    required this.email,
    required this.name,
    this.urlPhoto = "",
  });

  factory ConfidenceUser.fromJson(Map<String, dynamic> json) {
    return ConfidenceUser(
      email: json["email"],
      name: json["name"],
      urlPhoto: json["urlPhoto"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "urlPhoto": urlPhoto,
    };
  }
}
