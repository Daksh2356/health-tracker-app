import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_health_tracker_app/models/user.dart';
import 'package:my_health_tracker_app/models/patient.dart';

class Service{
  final String? uid;
  Service({required this.uid});

  final CollectionReference usercollection = FirebaseFirestore.instance.collection('My Tracker');

  Future updateUserData(String age , String bp) async {
    return await usercollection.doc(uid).set({
      'age' : age,
      'bp' : bp
    });
  }

  List<Patient> _patentlistfromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Patient(
          age: doc.data().toString().contains('age') ? doc.get('age') : '',
          bp: doc.data().toString().contains('bp') ? doc.get('bp') : '',

      );
    }).toList();
  }

// user data from snapshot
  UserData _userdatafromsnapshot (DocumentSnapshot snaps)
  {
    return UserData(uid: uid,
        age: snaps.get('age'),
        bp: snaps.get('bp'));
  }


  // get patients' data stream

  Stream<List<Patient>> get patients {
    return usercollection.snapshots().map(_patentlistfromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData{
    return usercollection.doc(uid).snapshots().map(_userdatafromsnapshot);
  }
}