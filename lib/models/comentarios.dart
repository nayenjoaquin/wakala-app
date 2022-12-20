class Comentarios {
  int? id;
  String? descripcion;
  String? fechaComentario;
  String? autor;

  Comentarios({this.id, this.descripcion, this.fechaComentario, this.autor});

  Comentarios.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descripcion = json['descripcion'];
    fechaComentario = json['fecha_comentario'];
    autor = json['autor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descripcion'] = this.descripcion;
    data['fecha_comentario'] = this.fechaComentario;
    data['autor'] = this.autor;
    return data;
  }
}
