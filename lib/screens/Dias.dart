import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mantenedor_lossan/screens/ClientesDias.dart';
import 'package:mantenedor_lossan/services/api_service.dart';

class Dias extends StatelessWidget {
  const Dias({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Días de la semana"),
    ),
    body: StreamBuilder(
        stream: FireStoreService().dias(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              var dias = snapshot.data!.docs[index];
              return ListTile(
                title: Text(dias.id),
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(builder: ((context) => ClientesDias(dias.id)));
                  Navigator.push(context, route);
                },
                
              );
            },
          );
        },
      ),
    );
  }
}