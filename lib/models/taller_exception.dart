/// Error de negocio con un mensaje listo para mostrar al técnico.
class TallerException implements Exception {
  final String mensaje;
  const TallerException(this.mensaje);

  @override
  String toString() => mensaje;
}
