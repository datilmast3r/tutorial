class Usuario {
  Usuario({
    required this.descripcion,
    required this.nombre,
    required this.edad,
    required role,
    required imageUrl,
  });
  late String descripcion;
  late String nombre;
  late int edad;
  late String role;
  late String imageUrl;

  Usuario.fromJson(Map<String, dynamic> json) {
    descripcion = json['descripcion'] ?? '';
    nombre = json['nombre'] ?? '';
    edad = json['edad'] ?? '';
    imageUrl = json['imageUrl'] ?? '';
    role = json['role'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['descripcion'] = descripcion;
    data['nombre'] = nombre;
    data['edad'] = edad;
    data['role'] = role;
    data['imageUrl'] = imageUrl;

    return data;
  }

  static Usuario fromMap(Map<String, dynamic> userData) {
    return Usuario(
      descripcion: userData['description'] ?? '',
      nombre: userData['name'] ?? '',
      edad: userData['age'] ?? '',
      imageUrl: userData['imageUrl'] ?? '',
      role: userData['role'] ?? '',
    );
  }
}
