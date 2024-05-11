import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/utils/mixins/registerable.dart';

abstract class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const controlTableName = 'controle';

  FirebaseFirestore get firestore => _firestore;

  void firebaseErrorLogger(FirebaseException e) {
    log('Código do erro: ${e.code}');
    log('Mensagem: ${e.message}');
    log('StackTrace: ${e.stackTrace}');
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> getAllCollectionDocs(String collectionName) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    log('Buscando todos os documentos da coleçao $collectionName');
    try {
      var allDocs = await firestore.collection(collectionName).get();
      log('Foram encontrados ${allDocs.docs.length} documentos da tabela $collectionName');
      return allDocs.docs;
    } on FirebaseException catch (e) {
      log('Erro ao procurar documentos');
      log(e.message.toString());
      return null;
    }
  }

  Future<CollectionReference<Map<String, dynamic>>?> accessControlTable() async {
    log('Entrando na tabela de controle');
    try {
      return firestore.collection('controle');
    } on FirebaseException catch (e) {
      log('Erro ao acessar a tabela de controle');
      firebaseErrorLogger(e);
      return null;
    }
  }

  Future<int?> getNextCode(String item) async {
    try {
      var controlTable = await accessControlTable();
      log('Capturando o próximo código de produto');
      var itemTable = await controlTable!.doc(item).get();
      return itemTable['total'];
    } on FirebaseException catch (e) {
      log('Erro ao capturar próximo código');
      firebaseErrorLogger(e);
      return null;
    }
  }

  Future<String?> stepInCode(String item) async {
    try {
      var controlTable = await accessControlTable();
      log('Tentando passar para próximo código de $item na tabela de controle');
      var itemTable = await controlTable!.doc(item).get();
      int newCode = itemTable['total'] + 1;
      await controlTable.doc(item).update({'total': newCode});
      return null;
    } on FirebaseException catch (e) {
      log('Erro ao passar para próximo código da tabela de $item');
      firebaseErrorLogger(e);
      return e.message;
    }
  }

  Future<String?> registerObject(Registerable object, String collection) async {
    try {
      await firestore.collection(collection).doc('${object.id}').set(object.json);
      await stepInCode(collection);
      log('Cadastrado Objeto do tipo ${object.runtimeType}: ${object.log}');
      return null;
    } on FirebaseException catch (e) {
      log('Erro ao tentar cadastrar item na tabela $collection');
      firebaseErrorLogger(e);
      return 'Erro: não foi possível cadastrar item';
    } catch (e) {
      log(e.toString());
      return 'Erro: Ocorreu um problema ao cadastrar item';
    }
  }

  Future<String?> editObject(
    String collection,
    Map<String, dynamic> objectChanges,
    int objectId,
  ) async {
    try {
      await firestore.collection(collection).doc('$objectId').update(objectChanges);
      log('Item de id $objectId da tabela $collection editado com sucesso');
      log('Campos que foram editados:');
      for (String key in objectChanges.keys) {
        log('$key: ${objectChanges[key]}');
      }
      return null;
    } on FirebaseException catch (e) {
      log('Erro ao tentar atualizar item de id $objectId da tabela $collection');
      firebaseErrorLogger(e);
      return e.message;
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }
}
