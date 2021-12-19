import 'package:flutter/material.dart';
class ProfilePage extends StatelessWidget{
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
            Navigator.pop(context);
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
              children: <Widget>[Column(
                children: [
                 Container(
        height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(
              "assets/LogoProfile.png"
            )
            )
          ),
              ),
                ]
                
                )

              ],
            ),
            
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("@HAHA")],
            )
          ],
        ),      
      ),
    );
  }

}