class Wakala {
  int? id;
  String? sector;
  String? autor;
  String? fecha;
  String? image1;
  String? image2;

  Wakala(
      {this.id, this.sector, this.autor, this.fecha, this.image1, this.image2});

  Wakala.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sector = json['sector'];
    autor = json['autor'];
    fecha = json['fecha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    this.id != null ? data['id'] = this.id : null;
    data['sector'] = this.sector;
    data['id_autor'] = this.autor;
    this.fecha != null ? data['fecha'] = this.fecha : null;
    data['base64Foto1'] = this.image1;
    data['base64Foto2'] = this.image2;
    return data;
  }
}
