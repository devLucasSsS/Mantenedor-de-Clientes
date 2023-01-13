import 'package:flutter/material.dart';
import 'package:mantenedor_lossan/services/api_service.dart';

class AgregarCliente extends StatefulWidget {
  // const AgregarCliente({super.key});
  String id;
  int db;
  AgregarCliente(this.id,this.db);
  @override
  State<AgregarCliente> createState() => _AgregarClienteState();
}

class _AgregarClienteState extends State<AgregarCliente> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController deudaCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Cliente'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
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
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: Text('Agregar'),
                  onPressed: () => create(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void create(context) async{

      int deuda= int.tryParse(deudaCtrl.text.trim()) ?? 0;
      var nombre = nameCtrl.text.trim();
      if(nombre == ''){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error, el nombre no puede estar vacio'))
        );
      }else{
        FireStoreService().agregar(
          widget.id,
          nombre,
          deuda,
          widget.db
        );
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cliente Agregado'))
        );
      }
    }
}