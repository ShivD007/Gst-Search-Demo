// To parse this JSON data, do
//
//     final gstList = gstListFromJson(jsonString);

import 'dart:convert';

List<GstList> gstListFromJson(String str) =>
    List<GstList>.from(json.decode(str).map((x) => GstList.fromJson(x)));

String gstListToJson(List<GstList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GstList {
  GstList({
    this.gst,
    this.status,
    this.name,
    this.ppofBusiness,
    this.apofBusiness,
    this.statejur,
    this.centraljur,
    this.taxpayType,
    this.conofBusiness,
    this.dor,
    this.doc,
  });

  String gst;
  String status;
  String name;
  String ppofBusiness;
  String apofBusiness;
  String statejur;
  String centraljur;
  String taxpayType;
  String conofBusiness;
  String dor;
  String doc;

  factory GstList.fromJson(Map<String, dynamic> json) => GstList(
        gst: json["gst"],
        status: json["status"],
        name: json["name"],
        ppofBusiness: json["ppofBusiness"],
        apofBusiness: json["apofBusiness"],
        statejur: json["statejur"],
        centraljur: json["centraljur"],
        taxpayType: json["taxpayType"],
        conofBusiness: json["ConofBusiness"],
        dor: json["dor"],
        doc: json["doc"],
      );

  Map<String, dynamic> toJson() => {
        "gst": gst,
        "status": status,
        "name": name,
        "ppofBusiness": ppofBusiness,
        "apofBusiness": apofBusiness,
        "statejur": statejur,
        "centraljur": centraljur,
        "taxpayType": taxpayType,
        "ConofBusiness": conofBusiness,
        "dor": dor,
        "doc": doc,
      };
}
