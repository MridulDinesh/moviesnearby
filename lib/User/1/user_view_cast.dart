import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserViewCast extends StatelessWidget {
  const UserViewCast({super.key, required this.docId});
  final String docId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("films2")
          .doc(docId)
          .collection("cast")
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return Image.asset('assets/images/nodata.jpg');
          }
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                      NetworkImage(snapshot.data!.docs[index]["cast face"]),
                      radius: 35,
                    ),
                    SizedBox(height: 5),
                    Text(snapshot.data!.docs[index]["name"]),
                    Text(snapshot.data!.docs[index]["role"]),
                  ],
                );
              },
            ),
          );
        } else {
          return Text("No data");
        }
      },
    );
  }
}
