class EmployeeEntity {
  final int id;
  final String phone;
  final String address;
  final String email;
  final String name;
  final String role;
  final String username;

  EmployeeEntity({
    required this.id,
    required this.phone,
    required this.address,
    required this.email,
    required this.name,
    required this.role,
    required this.username,
  });

  factory EmployeeEntity.fromJson(Map<String, dynamic> json) {
    return EmployeeEntity(
      id: json['id'],
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      username: json['username'] ?? '',
    );
  }
}
