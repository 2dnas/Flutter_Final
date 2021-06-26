import 'package:final_flutter/data/database.dart';
import 'package:final_flutter/screens/edit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key key, this.title, this.amount, this.date, this.docId})
      : super(key: key);

  final String title;
  final String amount;
  final String date;
  final String docId;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFcef7ed),
      child: Center(
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF727272),
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Expense Amount : $amount",
              style: TextStyle(
                color: Color(0xFF727272),
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Date : $date",
              style: TextStyle(
                color: Color(0xFF727272),
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                  ),
                  ClipOval(
                    child: Container(
                      height: 60,
                      width: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          return EditScreen(title: title,
                              amount: amount,
                              date: date,
                            docId: docId ,);
                        },
                        child: Icon(Icons.create_rounded),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  ClipOval(
                    child: Container(
                      height: 60,
                      width: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text(
                                        "Do you Really want to delete expense?"),
                                    content: Text(
                                        "If you press Yes expense will delete forever!"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Database.deleteExpense(docId);
                                          Navigator.pop(context);
                                        },
                                        child: Text("YES"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("NO"),
                                      ),
                                    ],
                                  ));
                        },
                        child: Icon(Icons.delete),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
