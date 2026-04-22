class AddEmployeeParams {
  final String name;
  final String username;
  final String password;
  final String role;
  final String phone;
  final String address;
  final String email;

  AddEmployeeParams({
    required this.name,
    required this.username,
    required this.password,
    required this.role,
    required this.phone,
    required this.address,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "username": username,
      "password": password,
      "role": role,
      "phone": phone,
      "address": address,
      "email": email,
    };
  }
}
