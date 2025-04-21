import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PlayerHistory extends StatefulWidget {
  const PlayerHistory({super.key});

  @override
  State<PlayerHistory> createState() => _PlayerHistoryState();
}

class _PlayerHistoryState extends State<PlayerHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("players")
              .doc("3OAcCFLt3WD4WL2v4ORn")
              .collection("player_data")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Lottie.asset("assets/images/football_loading.json");
            }
            else if(snapshot.data == null){
              return Text("لا توجد بيانات سابقة بعد");
            }
            return ListView.builder(itemBuilder: (context, index) {
              return Text(snapshot.data!.docs[index]["analyis_type"]);
            });
          }),
    );
  }
}
