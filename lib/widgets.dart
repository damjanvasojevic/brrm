import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget tileWidget(QueryDocumentSnapshot vehicle) {
  return Card(
    elevation: 8.0,
    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    child: ListTile(
      tileColor: const Color.fromRGBO(64, 75, 96, .9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: const EdgeInsets.only(right: 12.0),
        decoration: const BoxDecoration(border: Border(right: BorderSide(width: 2.0, color: Colors.white60))),
        child: const Icon(Icons.car_crash, color: Colors.white),
      ),
      title: Text(
        'Owner: ${vehicle.get('owner')}',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Text(
        'Brand: ${vehicle.get('brand')}',
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget addVehicleDialog(BuildContext context, CollectionReference referenceVehicleList) {
  final TextEditingController _ownerField = TextEditingController();
  final TextEditingController _brandField = TextEditingController();
  final User _user = FirebaseAuth.instance.currentUser!;

  return AlertDialog(
    content: Stack(
      children: <Widget>[
        Positioned(
          right: -40.0,
          top: -40.0,
          child: InkResponse(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.close),
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _ownerField,
                decoration: const InputDecoration(labelText: "Owner"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _brandField,
                decoration: const InputDecoration(labelText: "Brand"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
                  ),
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                  onPressed: () {
                    referenceVehicleList
                        .add({'brand': _brandField.text.trim(), 'owner': _ownerField.text.trim(), 'uid': _user.uid})
                        .then((value) => print("User Added"))
                        .catchError((error) => print("Failed to add user: $error"));
                    Navigator.of(context).pop();
                  }),
            )
          ],
        ),
      ],
    ),
  );
}
