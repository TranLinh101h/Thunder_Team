import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikePerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/e1.png'),
                ),
                title: Row(
                  children: [
                    Icon(Icons.thumb_up, color: Colors.blue),
                    SizedBox(
                      width: 5,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Anna',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ))
                  ],
                ),
              )),
    );
  }
}
