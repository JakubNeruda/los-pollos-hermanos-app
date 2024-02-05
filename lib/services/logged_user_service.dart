import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:los_pollos_hermanos/models/registered_user.dart';
import 'package:los_pollos_hermanos/util/firebase_id.dart';
import 'package:los_pollos_hermanos/util/utils.dart';

import '../models/food_order.dart';

class LoggedUserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StreamController<RegisteredUser?> _currentUserController =
      StreamController<RegisteredUser?>.broadcast();
  RegisteredUser? _currentUser;

  LoggedUserService() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _firestore
            .collection('users')
            .doc(user.uid)
            .snapshots()
            .listen((snapshot) {
          _setCurrentUser(snapshot);
        });
      } else {
        _setCurrentUser(null);
      }
    });
  }

  Stream<RegisteredUser?> get currentUserChanges =>
      _currentUserController.stream;

  RegisteredUser? get currentUser => _currentUser;

  void addOrder(order) {
    if (currentUser == null) return;
    currentUser!.orders.add(order.id);
    _firestore
        .collection('users')
        .doc(currentUser!.id)
        .update({'orders': currentUser!.orders});
  }

  void openOrderChange(FoodOrder? order) {
    if (currentUser == null) return;
    _firestore
        .collection('users')
        .doc(currentUser!.id)
        .update({'openOrder': withoutId(order!.toJson())});
  }

  void _setCurrentUser(DocumentSnapshot? snapshot) async {
    if (snapshot != null && Utils.checkSnapshotAndData(snapshot)) {
      _currentUser = RegisteredUser.fromJson(
          withId(snapshot.data() as Map<String, dynamic>, snapshot.id));
    } /* else if (_auth.currentUser != null) {
      var s = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      print(s != null && Utils.checkSnapshotAndData(s));
      if (s != null && Utils.checkSnapshotAndData(s)) _setCurrentUser(s);
    } */
    else {
      _currentUser = null;
    }
    _currentUserController.add(_currentUser);
  }

  void dispose() {
    _currentUserController.close();
  }
}
