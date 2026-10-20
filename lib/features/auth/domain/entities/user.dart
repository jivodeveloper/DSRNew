class User {
  const User({required this.id, required this.name, this.type, this.username});

  final int id;
  final String name;
  final String? type;
  final String? username;
}
