import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/user_object.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:app_du_lich/screens/home_taps.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'login.dart';

class SingupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SingupState();
  }
}

class SingupState extends State<SingupPage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController sdt = TextEditingController();
  bool loading = false;

  void register() async {
    ApiResponse response =
        await registerUser(name.text, email.text, pass.text, sdt.text);
    if (response.error == null) {
      saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }

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
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ManHinhChinh()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
                child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Đăng Ký Tài Khoản Mới",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 100,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: name,
                            validator: (val) =>
                                val!.isEmpty ? 'Chưa nhập họ tên' : null,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Họ và tên',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: email,
                            validator: (val) =>
                                val!.isEmpty ? 'Chưa nhập email' : null,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Chưa nhập sô điện thoại' : null,
                            controller: sdt,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Số điện thoại',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: pass,
                            validator: (val) => val!.length < 6
                                ? 'Mật khẩu tối thiểu 6 ký tự'
                                : null,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Mật khẩu',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            validator: (val) => val != pass.text
                                ? 'Mật khẩu xác nhận không đúng'
                                : null,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nhập lại mật khẩu',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border(
                                  bottom: BorderSide(color: Colors.black),
                                  top: BorderSide(color: Colors.black),
                                  left: BorderSide(color: Colors.black),
                                  right: BorderSide(color: Colors.black),
                                )),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 50,
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  register();
                                }
                              },
                              color: Color(0xff0095f0),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "Đăng Ký",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Đã có tài khoản?"),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
                  },
                  child: Text("Đăng Nhập Ngay!",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
