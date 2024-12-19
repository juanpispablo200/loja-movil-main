class EventFavDetailDTO {
  final String direccion;
  final String? informacion;
  final String nombreEvento;
  final String horaInicio;
  final String horaFin;
  final String ponente;
  final String procedencia;
  final String tipo;
  final String icono;
  final String imagen;
  final String entrada;
  final DateTime? fechaInicio;
  final DateTime? fechaFin;
  final String duracion;
  final String? dia;

  EventFavDetailDTO({
    required this.nombreEvento,
    required this.horaInicio,
    required this.horaFin,
    required this.ponente,
    required this.procedencia,
    required this.tipo,
    required this.icono,
    required this.imagen,
    required this.entrada,
    this.fechaInicio,
    this.fechaFin,
    this.dia,
    required this.duracion,
    required this.direccion,
    this.informacion,
  });
}
