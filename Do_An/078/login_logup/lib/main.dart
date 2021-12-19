import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_logup/main.dart';
import 'package:login_logup/profile.dart';
import 'package:login_logup/singup.dart';
class LoginPage extends StatelessWidget {@
	override
	Widget build(BuildContext context) {
		return Scaffold(resizeToAvoidBottomInset: false, backgroundColor:
			Colors.white, appBar: AppBar(elevation:
				0, brightness: Brightness.light, backgroundColor: Colors.white,
				leading: IconButton(onPressed: () {
					Navigator.push(context, MaterialPageRoute(builder: (context) =>
						Homepage()));
				}, icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black, ), ),
			), body: Container(height:
				MediaQuery.of(context).size.height, width: double.infinity,
				child: Column(children: < Widget > [
				Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
						children: < Widget > [Column(
								children: [
							Container(height: MediaQuery.of(context).size.height / 3,
										decoration: BoxDecoration(image:
											DecorationImage(image: AssetImage(
												"assets/DangNhap.png"))), ),
							Padding(padding: EdgeInsets.symmetric(horizontal: 40), child:
										Container(padding: EdgeInsets.all(
											10), child: TextField(decoration: InputDecoration(
											border: OutlineInputBorder(), labelText:
											'Tên đăng nhập', ), ), ), ),
							Padding(padding: EdgeInsets.symmetric(horizontal: 40), child:
										Container(padding: EdgeInsets.fromLTRB(
											10, 10, 10, 0), child: TextField(obscureText: true,
											decoration: InputDecoration(border:
												OutlineInputBorder(), labelText: 'Mật khẩu', ), ), ),
									),
						], ),
					Padding(padding: EdgeInsets.symmetric(horizontal: 40), child:
								Container(decoration: BoxDecoration(
									borderRadius: BorderRadius.circular(50), border: Border(
										bottom: BorderSide(color: Colors.black),
										top: BorderSide(color: Colors.black), left: BorderSide(
											color: Colors.black), right: BorderSide(
											color: Colors.black), )), child: MaterialButton(
									minWidth: double.infinity, height: 60,
									onPressed: () {
										Navigator.push(context, MaterialPageRoute(builder: (
											context) => ProfilePage()));
									}, color: Color(0xff0095ff), shape:
									RoundedRectangleBorder(side: BorderSide(color: Colors.black),
										borderRadius: BorderRadius.circular(50)), child: Text(
										"Đăng Nhập", style: TextStyle(color:
											Colors.white, fontSize: 18, fontWeight: FontWeight.w600
										), ), ), ), ),
					Row(mainAxisAlignment: MainAxisAlignment.center, children: <
								Widget > [
						Text("Chưa có tài khoản?"),
						FlatButton(onPressed: () {
										Navigator.push(context, MaterialPageRoute(builder: (
											context) => SingupPage()));
									}, child: Text("Đăng Ký Ngay!", style: TextStyle(
										fontSize: 18, fontWeight: FontWeight.w600)), )
					], ),
					Row(mainAxisAlignment: MainAxisAlignment.end, children: < Widget > [
						FlatButton(onPressed: () {}, child: Text("Quên mật khẩu", style:
									TextStyle(fontSize: 15, color:
										Colors.grey), ), )
					], )
				], ), )
			], ), ), );
	}
}
