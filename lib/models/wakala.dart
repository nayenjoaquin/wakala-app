class Wakala {
  int? id;
  String? sector;
  String? autor;
  String? fecha;

  Wakala({this.id, this.sector, this.autor, this.fecha});

  Wakala.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sector = json['sector'];
    autor = json['autor'];
    fecha = json['fecha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sector'] = this.sector;
    data['autor'] = this.autor;
    data['fecha'] = this.fecha;
    return data;
  }
}
