import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/user_object.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_taps.dart';
import 'singup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool loading = false;
  bool showPass = true; // Man update 15/01/2022

  void loginUser() async {
    ApiResponse response = await login(email.text, pass.text);
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

  void saveAndRedirectToHome(User user) async { // Man update 24/01/2022 | line 45
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    await pref.setString('password', pass.text.isEmpty ? '' : pass.text.toString() ); // Do bổ sung sau này nên kiểm tra lõ ta còn lưu phiên đăng nhập của version trước thì pass nó cũng không văng lỗi
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
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
          icon:const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          decoration:const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/DangNhap.png"))),
                        ),
                        Padding(
                          padding:const EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            padding:const EdgeInsets.all(10),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: email,
                              validator: (val) =>
                                  val!.isEmpty ? 'Vui lòng điền email' : null,
                              decoration:const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:const EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            padding:const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              validator: (val) => val!.length < 6
                                  ? 'Mật khẩu tổi thiểu 6 ký tự'
                                  : null,
                              controller: pass,
                              obscureText: showPass,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Mật khẩu',
                                suffixIcon: IconButton(
                                  onPressed: (){}, 
                                  icon: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        showPass = !showPass;
                                      });
                                    }, 
                                    icon: Icon(showPass ?
                                     Icons.visibility_off : Icons.remove_red_eye ,
                            color: showPass ? Colors.blue : Colors.grey, // Khi _showPassword là true màu là xanh và ngược lại
                                    ) )
                                  )
                              ),
                            ),
                          ),
                        ),
                      const  SizedBox(
                          height: 15,
                        ),
                        loading
                            ?const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: const Border(
                                        bottom: BorderSide(color: Colors.black),
                                        top: BorderSide(color: Colors.black),
                                        left: BorderSide(color: Colors.black),
                                        right: BorderSide(color: Colors.black),
                                      )),
                                  child: MaterialButton(
                                    minWidth: double.infinity,
                                    height: 60,
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        loginUser();
                                      }
                                    },
                                    color: const Color(0xff0095ff),
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Text(
                                      "Đăng Nhập",
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    const  Text("Chưa có tài khoản?"),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SingupPage()));
                        },
                        child: const Text("Đăng Ký Ngay!",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {},
                        child: const Text(
                          "Quên mật khẩu",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
