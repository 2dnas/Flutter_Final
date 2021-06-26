import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_flutter/data/database.dart';
import 'package:final_flutter/screens/add_new_expense_screen.dart';
import 'package:final_flutter/screens/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Database.readExpense(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Oh! Something went Wrong");
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      isThreeLine: true,
                      title: Text(
                          "Amount: " + snapshot.data.docs[index].get("amount")),
                      subtitle: Text("Title:" +
                          snapshot.data.docs[index].get("title") +
                          "\nDate:" +
                          DateFormat('yyyy-mm-dd').format(
                              (snapshot.data.docs[index].get("date")
                                      as Timestamp)
                                  .toDate())),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return DetailsScreen(
                                title: snapshot.data.docs[index].get("title"),
                                amount: snapshot.data.docs[index].get("amount"),
                                date: DateFormat('yyyy-mm-dd').format(
                                    (snapshot.data.docs[index].get("date")
                                            as Timestamp)
                                        .toDate()),
                                docId: snapshot.data.docs[index].id,
                              );
                            });
                      },
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 15,
                    ),
                itemCount: snapshot.data.docs.length);
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return AddNewExpense();
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
