import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper{
  
  CollectionReference _collectionRef;
  FirestoreHelper(String collection){
     _collectionRef = Firestore.instance.collection(collection);
  }

  void addData(Map<String,dynamic> data) async{
    await _collectionRef.add(data);
  }
  void addUniqueData(Map<String,dynamic> data,String key) async{
    _collectionRef.where(key,isEqualTo:data[key]).snapshots().listen((e)async{
      print(e.documents);
      if(e.documents.length == 0){
        await _collectionRef.add(data);
      }
    });
    
  }
  Stream<QuerySnapshot> readAll() {
    return _collectionRef.snapshots();
  }
  void deleteData(DocumentSnapshot doc) async{
    await _collectionRef.document(doc.documentID).delete();
  }
  void updateData(Map<String,dynamic> data, DocumentSnapshot doc) async{
    await _collectionRef.document(doc.documentID).updateData(data);
  }
  
}