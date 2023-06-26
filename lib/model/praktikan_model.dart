import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare_web/model/praktikum_model.dart';

import '../reusable/model.dart';

class PraktikanModel extends Model {
  late String? uid, pid, mid, sid, asistenID, namaUser, nrpUser;

  late DateTime? createdAt, praktikumAt;

  PraktikanModel({
    this.uid,
    this.pid,
    this.mid,
    this.sid,
    this.asistenID,
    this.namaUser,
    this.nrpUser,
    this.praktikumAt,
    this.createdAt,
  });

  // @override
  // List<Object?> get props => [pid, mid, sid, createdAt];

  void fromJson(Map<String, dynamic> data) {
    pid = data['pid'] ?? '';
    mid = data['mid'] ?? '';
    sid = data['sid'] ?? '';
    createdAt = data['createdAt'] != null
        ? (data['date'] as Timestamp).toDate()
        : DateTime.fromMillisecondsSinceEpoch(0);
    praktikumAt = data['praktikumAt'] != null
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

class PraktikanModels extends MultipleItemsModel<PraktikanModel> {
  @override
  PraktikanModel model() => PraktikanModel();
}
