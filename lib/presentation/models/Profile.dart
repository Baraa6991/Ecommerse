class UserProfile {
  final String firstName;
  final String lastName;
  final String location;
  final String email;
  final String? image;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.location,
    required this.email,
    required this.image,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['first_name'],
      lastName: json['last_name'],
      location: json['location'],
      email: json['email'],
      image: json['image'],
    );
  }
}
