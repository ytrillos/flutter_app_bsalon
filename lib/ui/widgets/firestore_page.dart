import 'package:flutter/material.dart';
import 'package:flutter_app_bsalon/data/model/record.dart';
import 'package:flutter_app_bsalon/domain/controller/firestore_controller.dart';
import 'package:get/get.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

class FireStorePage extends StatefulWidget {
  const FireStorePage({Key? key}) : super(key: key);
  @override
  _FireStoreState createState() => _FireStoreState();
}

class _FireStoreState extends State<FireStorePage> {
  final FirebaseController firebaseController = Get.find();

  @override
  void initState() {
    firebaseController.suscribeUpdates();
    super.initState();
  }

  @override
  void dispose() {
    firebaseController.unsuscribeUpdates();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
          () => ListView.builder(
              itemCount: firebaseController.entries.length,
              padding: const EdgeInsets.only(top: 20.0),
              itemBuilder: (BuildContext context, int index) {
                return _buildItem(context, firebaseController.entries[index]);
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            addComentarios(context);
          },
        ));
  }

  Widget _buildItem(BuildContext context, Record record) {
    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.votes.toString()),
          onTap: () {
            record.reference.update({'votes': record.votes + 1});
          },
        ),
      ),
    );
  }

  Future<void> addComentarios(BuildContext context) async {
    getName(context).then((value) {
      firebaseController.addEntry(value);
    });
  }

  Future<String> getName(BuildContext context) async {
    String? result = await prompt(
      context,
      title: const Text('Adding a item'),
      initialValue: '',
      textOK: const Text('Ok'),
      textCancel: const Text('Cancel'),
      hintText: 'Comentatios',
      minLines: 1,
      autoFocus: true,
      obscureText: false,
      textCapitalization: TextCapitalization.words,
    );
    if (result != null) {
      return Future.value(result);
    }
    return Future.error('cancel');
  }
}
