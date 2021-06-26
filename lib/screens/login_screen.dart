import 'package:final_flutter/data/database.dart';
import 'package:final_flutter/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                width: 300,
                  height: 300,
                  child: Image(image: AssetImage("assets/images/logo.png",))),
              Container(
                width: 200,
                child: TextField(
                  controller: _userIdController,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.black),
                      hintText: "Username",
                      fillColor: Color(0XFFa8e3e8)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0XFFa8e3e8),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Database.userId = _userIdController.text;
                  Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
