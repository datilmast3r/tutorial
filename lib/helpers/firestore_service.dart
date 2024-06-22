import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getVolunteerProjects() async {
    var snapshot = await _db.collection('Proyectos').get();
    print(snapshot);
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
