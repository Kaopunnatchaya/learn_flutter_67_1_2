//step 5 Make a firestore services
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference persons = FirebaseFirestore.instance.collection('persons');

  //create
  Future <void> addPerson(String personsName, String personsEmail, int personsAge) {
    return persons.add({
      'personsName' : personsName,
      'personsEmail' : personsEmail,
      'personsAge' : personsAge,
      'timestemp' : Timestamp.now(),
    });
  }

// Read
  Stream<QuerySnapshot> getPersons() {
    return persons.orderBy('timestamp', descending: true).snapshots();
  }

  // Get by Id
  Future<Map<String, dynamic>?> getPersonById(String personId) async {
    final doc = await persons.doc(personId).get();
    return doc.data() as Map<String, dynamic>? ?? {};
  }

  // Update
  Future<void> updatePerson(String personId, String personsName, String personsEmail, int personsAge) {
    return persons.doc(personId).update({
      'personsName' : personsName,
      'personsEmail' : personsEmail,
      'personsAge' : personsAge,
      'timestemp' : Timestamp.now(),
    });
  }
  // Delete
  Future<void> deletePerson(String personId) {
    return persons.doc(personId).delete();
  }
}