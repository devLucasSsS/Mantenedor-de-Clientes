import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mantenedor_lossan/services/api_service.dart';

class DetalleCliente extends StatefulWidget {
  // const DetalleCliente({super.key});
    String idD;
    String nombreC;
    String idC;
    int db ;
  DetalleCliente(this.idD,this.nombreC,this.idC,this.db);

  @override
  State<DetalleCliente> createState() => _DetalleClienteState();
}

class _DetalleClienteState extends State<DetalleCliente> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController deudaCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Cliente',),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: FireStoreService().DetalleCliente(widget.idD,widget.nombreC,widget.db),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var cliente= snapshot.data!.docs[0];
          nameCtrl.text = cliente['nombre'];
          deudaCtrl.text = cliente['deuda'].toString();
          return Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  label: Text('Nombre'),
                ),
              ),
              TextFormField(
                controller: deudaCtrl,
                decoration: InputDecoration(
                  label: Text('Deuda'),
                ),
                keyboardType: TextInputType.number,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 48, 46, 46)),
                  child: Text('Editar'),
                  onPressed: () {
                    int deuda = int.tryParse(deudaCtrl.text.trim()) ?? 0;
                    FireStoreService().editar(
                      widget.idD,
                      widget.idC,
                      nameCtrl.text.trim(),
                      deuda,
                      widget.db
                    );
                    Navigator.pop(context);
                    FocusManager.instance.primaryFocus?.unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cliente Editado'))
                    );
                  },
                ),
              ),
            ],
          ),
        );
        }
      ) 
      );
  }
}