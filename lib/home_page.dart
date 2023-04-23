import 'package:brrm/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _referenceVehicleList = FirebaseFirestore.instance.collection('vehicles');
  late Stream<QuerySnapshot> _streamVehicles;

  @override
  void initState() {
    super.initState();
    _streamVehicles = _referenceVehicleList.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
          title: const Text(
            "Home page",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          leading: IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: const Icon(Icons.logout, size: 32),
          ),
        ),
        body: StreamBuilder(
          stream: _streamVehicles,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.connectionState == ConnectionState.active) {
              QuerySnapshot _querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> _listQueryDocumentSnapshot = _querySnapshot.docs;
              if (_listQueryDocumentSnapshot.isEmpty) {
                return const Center(
                    child: Text(
                  "No vehicles",
                  style: TextStyle(fontSize: 33),
                ));
              }
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _listQueryDocumentSnapshot.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot document = _listQueryDocumentSnapshot[index];
                    return tileWidget(document);
                  });
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return addVehicleDialog(context, _referenceVehicleList);
                });
          },
          backgroundColor: Colors.amber,
          child: const Icon(
            Icons.add,
            size: 42,
          ),
        ),
      ),
    );
  }
}
