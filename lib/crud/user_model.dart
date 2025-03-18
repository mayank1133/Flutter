class User {
  int? id;
  String name;
  String email;
  String mobileNumber;
  String hobbies;
  String address;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.hobbies,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'hobbies': hobbies,
      'address': address,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      mobileNumber: map['mobileNumber'],
      hobbies: map['hobbies'],
      address: map['address'],
    );
  }
}