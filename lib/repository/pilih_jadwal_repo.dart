import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/jadwal_model.dart';
import '../model/praktikum_model.dart';

class JadwalRepository {
  final FirebaseFirestore _firebaseFirestore;

  JadwalRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<PraktikumModel>> get praktikumSubs {
    return _firebaseFirestore
        .collection('modul praktikum')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              var jsonObject = {...doc.data()};
              jsonObject['pid'] = doc.id;

              return PraktikumModel.fromJson(jsonObject);
            }).toList());
  }

  // Stream<List<JadwalModel>> get jadwalSubs {
  //   return _firebaseFirestore
  //       .collection('jadwal praktikum')
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs.map((doc) {
  //             var jsonObject = {...doc.data()};
  //             jsonObject['jid'] = doc.id;

  //             return JadwalModel.fromJson(jsonObject);
  //           }).toList());
  // }

  Future<void> pilihPraktikum(String jid, String mid, String uid) async {
    var ref = _firebaseFirestore.collection('pilih praktikum');
    var refData = await ref
        .where('jid', isEqualTo: jid)
        .where('mid', isEqualTo: mid)
        .where('uid', isEqualTo: uid)
        .where('status', isEqualTo: 'loading')
        .get();

    if (refData.docs.isNotEmpty) {
      return ref.doc(refData.docs[0].id).update({
        'count': FieldValue.increment(1),
      });
    }

    return ref.doc().set(
        {'jid': jid, 'mid': mid, 'uid': uid, 'count': 1, 'status': 'loading'});
  }
}
