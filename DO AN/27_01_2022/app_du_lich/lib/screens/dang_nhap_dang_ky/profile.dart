import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.lightBlue.shade100,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.lightBlue.shade100,
                  Colors.lightBlue.shade900
                ])),
            child: Container(
              width: double.infinity,
              height: 300,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('Images/fox.jpg'),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Trần Linh",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 22.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Bài viết: 15",
                                    style: TextStyle(
                                      color: Colors.blue.shade900,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 22.0),
                            child: Row(
                              children: [
                                Icon(Icons.text_fields),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Họ tên: ",
                                  style: TextStyle(
                                      color: Colors.blue.shade900,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 25.0),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Trần Linh',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ],
                            ))),
                    Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 22.0),
                            child: Row(
                              children: [
                                Icon(Icons.date_range),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Ngày sinh: ",
                                  style: TextStyle(
                                      color: Colors.blue.shade900,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 25.0),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  '31/12/2001',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ],
                            ))),
                    Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 22.0),
                            child: Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Số điện thoại: ",
                                  style: TextStyle(
                                      color: Colors.blue.shade900,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 25.0),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  '0123456789',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ],
                            ))),
                    Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 22.0),
                            child: Row(
                              children: [
                                Icon(Icons.mail),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Email: ",
                                  style: TextStyle(
                                      color: Colors.blue.shade900,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 25.0),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'caothang@gmail.com',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ],
                            ))),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
