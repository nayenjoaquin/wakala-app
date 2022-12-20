import 'comentarios.dart';

class WakalaDetail {
  int? id;
  late String sector;
  late String descripcion;
  late String fechaPublicacion;
  late String autor;
  String? urlFoto1;
  String? urlFoto2;
  int? sigueAhi;
  int? yaNoEsta;
  List<Comentarios>? comentarios;

  WakalaDetail(
      {this.id,
      required this.sector,
      required this.descripcion,
      required this.fechaPublicacion,
      required this.autor,
      this.urlFoto1,
      this.urlFoto2,
      this.sigueAhi,
      this.yaNoEsta,
      this.comentarios});

  WakalaDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sector = json['sector'];
    descripcion = json['descripcion'];
    fechaPublicacion = json['fecha_publicacion'];
    autor = json['autor'];
    urlFoto1 = json['url_foto1'];
    urlFoto2 = json['url_foto2'];
    sigueAhi = json['sigue_ahi'];
    yaNoEsta = json['ya_no_esta'];
    if (json['comentarios'] != null) {
      comentarios = <Comentarios>[];
      json['comentarios'].forEach((v) {
        comentarios!.add(new Comentarios.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sector'] = this.sector;
    data['descripcion'] = this.descripcion;
    data['fecha_publicacion'] = this.fechaPublicacion;
    data['autor'] = this.autor;
    data['url_foto1'] = this.urlFoto1;
    data['url_foto2'] = this.urlFoto2;
    data['sigue_ahi'] = this.sigueAhi;
    data['ya_no_esta'] = this.yaNoEsta;
    if (this.comentarios != null) {
      data['comentarios'] = this.comentarios!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
