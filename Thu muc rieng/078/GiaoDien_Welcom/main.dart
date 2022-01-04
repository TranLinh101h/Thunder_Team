import 'package:flutter/material.dart';
import 'package:login_logup/login.dart';
import 'package:login_logup/singup.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Homepage(),
  ));
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[Column(
          children: <Widget> [Text("Thunder Team",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),
          ),
          SizedBox(height: 30,
          ),
          Text("Mạng Xã Hội Du Lịch Hàng Đầu Thế Giới", textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[500],
          fontSize: 20),)
          ],
        ),
      Container(
        height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(
              "assets/AnhNen.png"
            )
            )
          ),

      ),
      Column(
        children: [MaterialButton(minWidth: double.infinity, 
        height: 60,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
        },
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(50)
        ),
        child: Text("ĐĂNG NHẬP", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        ),
        SizedBox(
          height: 20,
        ),
        MaterialButton(
          minWidth: double.infinity, 
        height: 60,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SingupPage()));
        },
        color: Color(0xff0095ff),
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(50)
        ),
        child: Text("ĐĂNG KÝ", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),

        )
        ],
      )
        ],
      ),
      
      ),

      ),
    );
  }
}

