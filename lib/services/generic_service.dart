import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:los_pollos_hermanos/util/firebase_id.dart';

class GenericService<T> {
  final Map<String, dynamic> Function(T data) toJson;
  final T Function(Map<String, dynamic> json) fromJson;
  final String collectionName;
  late final CollectionReference<T> _collection;
  CollectionReference<T> get collection => _collection;

  GenericService(this.toJson, this.fromJson, this.collectionName) {
    _collection =
        FirebaseFirestore.instance.collection(collectionName).withConverter(
              fromFirestore: (snapshot, _) =>
                  fromJson(withId(snapshot.data()!, snapshot.id)),
              toFirestore: (value, _) => withoutId(toJson(value)),
            );
  }

  Stream<List<T>> get listStream =>
      _collection.snapshots().map((querySnapshot) =>
          querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());

  Future<T?> getItem(String id) async {
    final snapshot = await _collection.doc(id).get();
    if (snapshot.exists) {
      return snapshot.data() as T;
    }
    print("Error getting doc $id from $collectionName");
    return null;
  }

  Future<void> update(String? id, T t) async {
    return await _collection.doc(id).update(withoutId(toJson(t)));
  }

  Future<DocumentReference<T>> create(T t) async {
    return await _collection.add(t);
  }

  DocumentReference createReference() {
    return _collection.doc();
  }

  Future<void> delete(String? id) async {
    return await _collection.doc(id).delete();
  }

  Future<void> add(T t, String? id) async {
    return await _collection.doc(id).set(t);
  }
}
