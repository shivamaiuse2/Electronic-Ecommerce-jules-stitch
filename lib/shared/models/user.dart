class User {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? profileImage;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profileImage,
  });
}
