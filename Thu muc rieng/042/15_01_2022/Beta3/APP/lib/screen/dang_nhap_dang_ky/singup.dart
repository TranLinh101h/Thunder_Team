import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/user_object.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:app_du_lich/screens/home_taps.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'login.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({Key? key}) : super(key: key);

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
  bool showPassword = true; // Man create 15/10/2022 | pass moi 
  bool showconfirmPassword = true; //Man create 15/10/2022 | pass xac nhan

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
                child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
               const   Text("????ng K?? T??i Kho???n M???i",
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
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding:const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: name,
                            validator: (val) =>
                                val!.isEmpty ? 'Ch??a nh???p h??? t??n' : null,
                            decoration:const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'H??? v?? t??n',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding:const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: email,
                            validator: (val) =>
                                val!.isEmpty ? 'Ch??a nh???p email' : null,
                            keyboardType: TextInputType.emailAddress,
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
                          padding:const EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Ch??a nh???p s?? ??i???n tho???i' : null,
                            controller: sdt,
                            keyboardType: TextInputType.phone,
                            decoration:const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'S??? ??i???n tho???i',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding:const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: pass,
                            obscureText: showPassword,
                            validator: (val) => val!.length < 6
                                ? 'M???t kh???u t???i thi???u 6 k?? t???'
                                : null,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'M???t kh???u',
                              suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                     showPassword = !showPassword;
                                  });
                                }, 
                                icon: Icon( showPassword ?
                                  Icons.visibility_off : Icons.remove_red_eye ,
                            color: showPassword ? Colors.blue : Colors.grey, 
                                ))
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding:const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: showconfirmPassword,
                            validator: (val) => val != pass.text
                                ? 'M???t kh???u x??c nh???n kh??ng ????ng'
                                : null,
                            decoration: InputDecoration(
                              border:const OutlineInputBorder(),
                              labelText: 'Nh???p l???i m???t kh???u',
                              suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                     showconfirmPassword = !showconfirmPassword;
                                  });
                                }, 
                                icon: Icon( showconfirmPassword ?
                                  Icons.visibility_off : Icons.remove_red_eye ,
                            color: showconfirmPassword ? Colors.blue : Colors.grey, 
                                ))
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  loading
                      ?const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding:const EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border:const Border(
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
                              color:const Color(0xff0095f0),
                              shape: RoundedRectangleBorder(
                                  side:const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(50)),
                              child:const Text(
                                "????ng K??",
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
              const   Text("???? c?? t??i kho???n?"),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
                  },
                  child:const Text("????ng Nh???p Ngay!",
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
