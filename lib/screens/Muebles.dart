import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mantenedor_lossan/screens/AgregarClientes.dart';
import 'package:mantenedor_lossan/screens/AlertDialog.dart';
import 'package:mantenedor_lossan/screens/AlertDialoginfo.dart';
import 'package:mantenedor_lossan/screens/DetalleCliente.dart';
import 'package:mantenedor_lossan/services/api_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share/share.dart';

class Muebles extends StatefulWidget {
  String id = '';
  @override
  State<Muebles> createState() => _MueblesState();
}

class _MueblesState extends State<Muebles> {
  String nombre = '';
  bool tappedYes = false;
  int total = 0;
  final currencyFormatter = NumberFormat.simpleCurrency(decimalDigits: 0);
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),hintText: 'Buscar...',
              suffixIcon: IconButton( 
                icon: Icon(Icons.clear),
                onPressed: () {
                _controller.clear();
                  setState(() {
                    nombre = "";
                  });
                }
              )
            ),
            onChanged: (nom){
              setState(() {
                nombre = nom;
              });
            },
          ),
        ),
        actions: [
        PopupMenuButton(itemBuilder: (context) =>[
          PopupMenuItem(
            value: 'total',
            child: Text('Total de Dinero en la calle'),
          )
        ],
        onSelected: (opcion) async{
          if(opcion == 'total'){
          final action = await AlertDialogsinfo.yesCancelDialog(context, 'Información', 'Dinero en la calle de los muebles es: '+currencyFormatter.format(int.parse((getTotal().toString()))));
          if(action == DialogsActionInfo.cancel){
            setState(() {
              tappedYes = false;
              total = 0;
            });
          }
          }
        },
        )
      ],
    ),
    body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('muebles').snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting) ?
          Center(
            child: CircularProgressIndicator(),
          ):
          ListView.builder(
            padding: EdgeInsets.only(bottom: 70),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              var cl = snapshot.data!.docs[index];
              var cliente = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              String deuda1 = '${cliente['deuda']}';
              int deudaC = cliente['deuda'];
              setTotal(deudaC);
              if(nombre.isEmpty){
                return ListTile(
                title: Text(cliente['nombre'],style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text('Saldo Pendiente: '+ currencyFormatter.format(int.parse(deuda1))),
                trailing: PopupMenuButton(itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'editar',
                    child: Text('Editar'),
                  ),
                  PopupMenuItem(
                    value: 'eliminar',
                    child: Text('Eliminar'),
                  ),
                  PopupMenuItem(
                    value: 'compartir',
                    child: Text('Compartir Datos'),
                  )
                ],
                onSelected: (opcion) async{
                  if(opcion == 'editar'){
                  var nombre = cliente['nombre'];
                  MaterialPageRoute route = MaterialPageRoute(builder: ((context) => DetalleCliente(widget.id,nombre, cl.id,2)));
                  Navigator.push(context, route);
                  }else if(opcion == 'eliminar'){
                    final action = await AlertDialogs.yesCancelDialog(context, 'Eliminar', 'Desea eliminar a '+ cliente['nombre']);
                    if(action == DialogsAction.yes){
                      setState(() {
                        tappedYes = true;
                      FireStoreService().borrar(widget.id,cl.id,2);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cliente Eliminado'))
                    );
                      });
                    }else{
                      setState(() {
                        tappedYes = false;
                      });
                    }
                  }else if(opcion == 'compartir'){
                    var datos = cliente['nombre'] +'\nSaldo Pendiente Muebles: ' +currencyFormatter.format(int.parse(deuda1));
                    await Share.share(datos);
                  }
                },
                ),
              );
              }
              if(cliente['nombre'].toString().toLowerCase().contains(nombre.toLowerCase())){
                return ListTile(
                title: Text(cliente['nombre'],style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text('Saldo Pendiente: '+ currencyFormatter.format(int.parse(deuda1))),
                trailing: PopupMenuButton(itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'editar',
                    child: Text('Editar'),
                  ),
                  PopupMenuItem(
                    value: 'eliminar',
                    child: Text('Eliminar'),
                  ),
                  PopupMenuItem(
                    value: 'compartir',
                    child: Text('Compartir Datos'),
                  )
                ],
                onSelected: (opcion)async{
                  if(opcion == 'editar'){
                  var nombre = cliente['nombre'];
                  MaterialPageRoute route = MaterialPageRoute(builder: ((context) => DetalleCliente(widget.id,nombre, cl.id,2)));
                  Navigator.push(context, route);
                  }else if(opcion == 'eliminar'){
                    final action = await AlertDialogs.yesCancelDialog(context, 'Eliminar', 'Desea eliminar a '+ cliente['nombre']);
                    if(action == DialogsAction.yes){
                      setState(() {
                        tappedYes = true;
                      FireStoreService().borrar(widget.id,cl.id,2);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cliente Eliminado'))
                    );
                      });
                    }else{
                      setState(() {
                        tappedYes = false;
                      });
                    }
                  }else if(opcion == 'compartir'){
                    var datos = cliente['nombre'] +'\nSaldo Pendiente Muebles: ' +currencyFormatter.format(int.parse(deuda1));
                    await Share.share(datos);
                  }
                },
                ),
              );
              }
              return Container();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 48, 46, 46),
        child: Icon(MdiIcons.plusThick),
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(builder: ((context) => AgregarCliente(widget.id,2)));
          Navigator.push(context, route);
        },
      ),
    );
  }
  setTotal(int clp){
    total = total + clp;
  }
  getTotal(){
    return total;
  }
}