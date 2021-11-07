import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//0306191040_Trần Quang Linh
//0306191042_Bùi Minh Mẫn
//0306191078_Trương Ngọc Thiêng
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

//Lop checkbox
class CheckBoxModel {
  String title;
  bool value;
  int soLuong;
  CheckBoxModel({required this.title, this.value = false, this.soLuong = 0});
}

// Login page
class LoginPage extends StatelessWidget {
  final userName = TextEditingController();
  final passWord = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                color: Color(0xFF00B8D4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'hero',
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 48.0,
                        child: Image.asset('images/mail1.jpg'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: const Text(
                        'Signln',
                        style: TextStyle(color: Colors.white, fontSize: 50),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: const Text(
                        'Speak, friend anh enter',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                        controller: userName,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: "Email",
                            suffixIcon: Icon(Icons.crop_square)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                        controller: passWord,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: "Password",
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: RaisedButton(
                          child: const Text(
                              '                                               SIGN IN                                               '),
                          textColor: Colors.white,
                          elevation: 10.0,
                          color: Colors.black,
                          onPressed: () {
                            if (userName.text.isEmpty ||
                                passWord.text.isEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Thông Báo'),
                                      content: Text(
                                          'Vui lòng điền đầy đủ thông tin!!!'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Ok'))
                                      ],
                                    );
                                  });
                            } else if (userName.text == passWord.text) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Loading()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => failed()));
                            }
                          },
                        )),
                  ],
                ))));
  }
}

//Loading Page
class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _Loading createState() => _Loading();
}

class _Loading extends State<Loading> {
  int _counter = 3;
  Timer? _timer;

  void _startTimer() {
    _counter = 3;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MailBoxesPage()));
          _timer!.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'loading',
      home: Scaffold(
        backgroundColor: Colors.cyanAccent[700],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(12),
                child: Image.asset('images/mail1.jpg'),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Signln',
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Text('Speak, friend, and enter'),
              SpinKitFadingCircle(
                color: Colors.white,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// FailedLogIn
class failed extends StatelessWidget {
  final bool loading = false;
  const failed({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/failLogIn.jpg'),
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 10),
                  child: Text(
                    "UPS... couldn't Sign In",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 150),
                  child: Text(
                    "Your username and password don't match place, \ntry agian ",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(30),
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      color: Colors.black,
                      child: Text('TRY AGAIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

//MailBox Page
class MailBoxesPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MailBoxesPage> {
  Widget itemEmail(CheckBoxModel cb, IconData icon) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Checkbox(
              value: cb.value,
              onChanged: (value) {
                onCheckbox(cb);
              }),
        ),
        Expanded(
            child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black))),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.blue,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(cb.title),
              ),
            ],
          ),
        )),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(
                cb.soLuong.toString(),
                style: TextStyle(color: Colors.red),
              ),
            ))
      ],
    );
  }

  // thay doi trang thai checkbox
  onCheckbox(CheckBoxModel checkbox) {
    setState(() {
      checkbox.value = !checkbox.value;
    });
  }

  final listCheckBox = [
    CheckBoxModel(title: 'All inboxes', soLuong: 2),
    CheckBoxModel(title: 'IClound', soLuong: 5),
    CheckBoxModel(title: 'Gmail'),
    CheckBoxModel(title: 'Hotmail', soLuong: 2),
    CheckBoxModel(title: 'VIP', soLuong: 3),
    CheckBoxModel(title: 'Secure', soLuong: 6),
    CheckBoxModel(title: 'Notification', soLuong: 1),
  ];

  bool vl = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Hha"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 6,
                  child: Container(
                    padding: EdgeInsets.only(top: 20, left: 10, bottom: 5),
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    child: Text(
                      "Mailboxes",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.only(top: 20, left: 10, bottom: 5),
                      color: Colors.grey[100],
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Done",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                          ),
                        ),
                      ))),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(top: 28, left: 10, bottom: 5),
                color: Colors.grey[200],
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Mailboxes",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              )),
            ],
          ),
          itemEmail(listCheckBox[0], Icons.inbox),
          itemEmail(listCheckBox[1], Icons.cloud_upload),
          itemEmail(listCheckBox[2], Icons.email),
          itemEmail(listCheckBox[3], Icons.mail_outline),
          itemEmail(listCheckBox[4], Icons.star),
          Row(
            children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(top: 28, left: 10, bottom: 5),
                color: Colors.grey[200],
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Special folders",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              )),
            ],
          ),
          itemEmail(listCheckBox[5], Icons.security),
          itemEmail(listCheckBox[6], Icons.notification_add),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.blue.shade400, width: 2)),
              child: FlatButton(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Updated Just Now",
                        style: TextStyle(fontSize: 17.0, color: Colors.black),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                onPressed: () {
                  setState(() {});
                },
              ),
            ),
          )
        ],
      ),
    ));
  }
}
