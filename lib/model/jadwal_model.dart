import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare_web/model/praktikum_model.dart';

import '../reusable/model.dart';

class JadwalModel extends Model {
  late String? pid,
      mid,
      sid,
      pdesc,
      jumlahModul,
      sesiPraktikum,
      ptitle,
      pimage,
      ptoday,
      pstatus;
  late DateTime? createdAt, openAt, closedAt, praktikumAt;

  JadwalModel({
    this.ptitle,
    this.jumlahModul,
    this.sesiPraktikum,
    this.pid,
    this.mid,
    this.sid,
    this.pdesc,
    this.pimage,
    this.ptoday,
    this.praktikumAt,
    this.createdAt,
    this.openAt,
    this.closedAt,
  });

  // @override
  // List<Object?> get props => [pid, mid, sid, createdAt];

  void fromJson(Map<String, dynamic> data) {
    pid = data['pid'] ?? '';
    mid = data['mid'] ?? '';
    sid = data['sid'] ?? '';
    ptitle = data['ptitle'] ?? '';
    jumlahModul = data['jumlah_modul'] ?? '';
    sesiPraktikum = data['sesi_praktikum'] ?? '';
    pdesc = data['pdesc'] ?? '';
    pimage = data['pimage'] ?? '';
    ptoday = data['ptoday'] ?? '';
    createdAt = data['createdAt'] != null
        ? (data['date'] as Timestamp).toDate()
        : DateTime.fromMillisecondsSinceEpoch(0);
    praktikumAt = data['praktikumAt'] != null
        ? (data['date'] as Timestamp).toDate()
        : DateTime.fromMillisecondsSinceEpoch(0);
    openAt = data['praktikumAt'] != null
        ? (data['date'] as Timestamp).toDate()
        : DateTime.fromMillisecondsSinceEpoch(0);

    closedAt = data['praktikumAt'] != null
        ? (data['date'] as Timestamp).toDate()
        : DateTime.fromMillisecondsSinceEpoch(0);
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pid'] = pid;
    data['mid'] = mid;
    data['sid'] = sid;

    data['date'] = createdAt;
    return data;
  }
}

class JadwalModels extends MultipleItemsModel<JadwalModel> {
  @override
  JadwalModel model() => JadwalModel();
}
