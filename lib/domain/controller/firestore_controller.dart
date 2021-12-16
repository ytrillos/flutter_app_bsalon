import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_bsalon/data/model/record.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class FirebaseController extends GetxController {
  final _records = <Record>[].obs;
  final CollectionReference comentarios =
      FirebaseFirestore.instance.collection('comentarios');
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('comentarios').snapshots();
  late StreamSubscription<Object?> streamSubscription;

  suscribeUpdates() async {
    logInfo('suscribeLocationUpdates');
    streamSubscription = _usersStream.listen((event) {
      logInfo('Got new item from fireStore');
      _records.clear();
      for (var element in event.docs) {
        _records.add(Record.fromSnapshot(element));
      }
      print('Got ${_records.length}');
    });
  }

  unsuscribeUpdates() {
    streamSubscription.cancel();
  }

  List<Record> get entries => _records;

  addEntry(name) {
    comentarios
        .add({'name': name, 'votes': 0})
        .then((value) => print("comentarios added"))
        .catchError((onError) => print("Failed to add comentarios $onError"));
  }

  updateEntry(Record record) {
    record.reference.update({'votes': record.votes + 1});
  }

  deleteEntry(Record record) {
    record.reference.delete();
  }
}
