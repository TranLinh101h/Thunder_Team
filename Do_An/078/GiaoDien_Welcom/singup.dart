

import 'package:flutter/material.dart';
import 'package:login_logup/login.dart';
import 'package:login_logup/main.dart';
class SingupPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Đăng Ký Tài Khoản Mới",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,)),
                Column(
                
                children: [
                 Container(
        height: MediaQuery.of(context).size.height / 100,
          
              ),
      Padding(padding: EdgeInsets.symmetric(horizontal: 40),
      child: Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Họ và tên',
                    ),
                  ),
                ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 40),
      child: Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ngày sinh',
                    ),
                  ),
                ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 40),
      child: Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Số điện thoại',
                    ),
                  ),
                ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 40),
      child: Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tên đăng nhập',
                    ),
                  ),
                ),
                ),
                
                
                Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: EdgeInsets.all(10),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mật khẩu',
                      ),
                      ),
                      ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nhập lại mật khẩu',
                      ),
                      ),
                      ),
                      ),
                      ],
                      ),
            Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border(
                bottom: BorderSide(color: Colors.black),
                top: BorderSide(color: Colors.black),
                left: BorderSide(color: Colors.black),
                right: BorderSide(color: Colors.black),
              )
            ),
            child: MaterialButton(minWidth: double.infinity,
            height: 60,onPressed: () {},
            color: Color(0xff0095f0),
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(50)
        ),
        child: Text("Đăng Ký", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        

        ),

          ),
          

        ),
            ),
            
              ],
              
            ),
            
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Đã có tài khoản?"),  
                FlatButton(onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                }, child: Text("Đăng Nhập Ngay!", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600))
                ,)
              ],
            ),
          ],
        ), 
        ),
        );
    
      
  }

}



