import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    this.Dieta,
    this.NombreDieta,
    this.Info,
    this.Menu,
    this.Nota,
  });
  String? Dieta;
  String? NombreDieta;
  String? Info;
  String? Menu;
  String? Nota;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        Dieta: json["dieta"],
        NombreDieta: json["nombreDieta"],
        Info: json["info"],
        Menu: json["menu"],
        Nota: json["nota"],
      );
  Map<String, dynamic> toJson() => {
        "dieta": Dieta,
        "nombreDieta": NombreDieta,
        "info": Info,
        "menu": Menu,
        "nota": Nota,
      };
}
