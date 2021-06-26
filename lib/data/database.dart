import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_flutter/data/model/expenses_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collectionReference = _firestore.collection("expenses");

class Database {
  static String userId;

  static Future<void> addExpense(Expenses expense)  async {
    DocumentReference documentReference = _collectionReference.doc(userId).collection("expense").doc();

    var data = <String , dynamic> {
      "title" : expense.title,
      "amount" : expense.amount,
      "date" : expense.date
    };

    await documentReference.set(data);

  }

  static Stream<QuerySnapshot> readExpense()  {
    CollectionReference expenses = _collectionReference.doc(userId).collection("expense");
    return expenses.snapshots();
  }

  static Future<void> updateExpense(Expenses expense , String docId) async {
    DocumentReference documentReference = _collectionReference.doc(userId).collection("expense").doc(docId);

    var data = <String,dynamic> {
       "title" : expense.title,
      "amount" : expense.amount,
      "date" : expense.date
    };

    await documentReference.set(data);

  }

  static Future<void> deleteExpense(String docId) async {
    DocumentReference documentReference = _collectionReference.doc(userId).collection("expense").doc(docId);

    await documentReference.delete();
  }



}