import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PraktikumModel extends Equatable {
  String? pid, mid, pdesc, ptitle, pimage, ptoday, nilai;
  DateTime? createdAt;

  PraktikumModel({
    this.pid,
    this.mid,
    this.pdesc,
    this.ptitle,
    this.pimage,
    this.ptoday,
    this.nilai,
    this.createdAt,
  });

  @override
  List<Object?> get props => [pid, mid, pdesc, ptitle, pimage, ptoday];

  PraktikumModel.fromJson(Map<String, dynamic> json) {
    pid = json['pid'] ?? '';
    mid = json['mid'] ?? '';
    pdesc = json['pdesc'] ?? '';
    ptitle = json['ptitle'] ?? '';
    pimage = json['pimage'] ?? '';
    ptoday = json['ptoday'] ?? '';
    nilai = json['nilai'] ?? '';
    createdAt = json['created_at'] != null
        ? (json['date'] as Timestamp).toDate()
        : DateTime.fromMillisecondsSinceEpoch(0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pid'] = pid;
    data['mid'] = mid;
    data['pdesc'] = pdesc;
    data['ptitle'] = ptitle;
    data['pimage'] = pimage;
    data['ptoday'] = ptoday;
    data['nilai'] = nilai;
    data['created_at'] = createdAt;
    return data;
  }
}
