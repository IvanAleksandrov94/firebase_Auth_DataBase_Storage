import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore/models/items.dart';

class DataBaseService {
  // add collection to database
  final CollectionReference _firstcollection =
      Firestore.instance.collection("title");
  final CollectionReference _secondcollection =
      Firestore.instance.collection("onView");

  Future addOrUpdateDB(Item item) async {
    DocumentReference docRef = _firstcollection.document();
    String docId = docRef.documentID; // get document id
    //add firsr and second documents with the same data
    await _firstcollection.document(docId).setData(item.toMap()).then((_) {
      return _secondcollection.document(docId).setData(item.toMap());
    });
  }

  Stream<List<Item>> getItems() {
    return _firstcollection.snapshots().map((QuerySnapshot data) => data
        .documents
        .map((DocumentSnapshot snap) => Item.fromsnapshot(snap.data))
        .toList());
  }
}
