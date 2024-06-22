class Usuario {
  Usuario({
    required this.descripcion,
    required this.nombre,
    required this.id,
    required this.email,
    required this.edad,
  });
  late String descripcion;
  late String nombre;
  late String id;
  late String email;
  late String edad;

  Usuario.fromJson(Map<String, dynamic> json) {
    descripcion = json['descripcion'] ?? '';
    nombre = json['nombre'] ?? '';
    id = json['id'] ?? '';
    email = json['email'] ?? '';
    edad = json['edad'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['descripcion'] = descripcion;
    data['nombre'] = nombre;
    data['id'] = id;
    data['email'] = email;
    data['edad'] = edad;

    return data;
  }

  static Usuario fromMap(Map<String, dynamic> userData) {
    return Usuario(
      descripcion: userData['descripcion'] ?? '',
      nombre: userData['nombre'] ?? '',
      id: userData['id'] ?? '',
      email: userData['email'] ?? '',
      edad: userData['edad'] ?? '',
    );
  }
}
