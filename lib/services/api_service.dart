import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  Stream<QuerySnapshot> dias() {
    return FirebaseFirestore.instance.collection('dias').snapshots();
  }
  Stream<QuerySnapshot> ClientesDias(String id) {
    return FirebaseFirestore.instance.collection('dias').doc(id).collection('clientes').snapshots();
  }
  Stream<QuerySnapshot> CientesMuebles() {
    return FirebaseFirestore.instance.collection('muebles').snapshots();
  }
    Stream<QuerySnapshot> DetalleCliente(String idD, String nombreCliente, int db) {
    if(db == 1){
      return FirebaseFirestore.instance.collection('dias').doc(idD).collection('clientes').where('nombre',isEqualTo: nombreCliente ).snapshots();
      
    }else{
      return FirebaseFirestore.instance.collection('muebles').where('nombre',isEqualTo: nombreCliente ).snapshots();
    }
  }
  Future borrar(String idD,String idC, int db){
    if(db == 1){
      return FirebaseFirestore.instance.collection('dias').doc(idD).collection('clientes').doc(idC).delete();
    }else{
      return FirebaseFirestore.instance.collection('muebles').doc(idC).delete();
    }
  }
  Future editar(String idD,String idC, String nombre, int deuda, int db) {
    if(db == 1){
    return FirebaseFirestore.instance.collection('dias').doc(idD).collection('clientes').doc(idC).update({
      'nombre':nombre,
      'deuda':deuda,
    });
    }else{
      return FirebaseFirestore.instance.collection('muebles').doc(idC).update({
        'nombre':nombre,
        'deuda':deuda,
      });
    }
  }
    Future agregar(String id,String nombre, int deuda, int db){
    if(db == 1){
      return FirebaseFirestore.instance.collection('dias').doc(id).collection('clientes').doc().set({
        'nombre': nombre,
        'deuda': deuda,
      });
    }else{
      return FirebaseFirestore.instance.collection('muebles').doc().set({
        'nombre': nombre,
        'deuda': deuda,
      });

    }
  }
}