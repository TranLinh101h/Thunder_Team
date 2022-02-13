import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/user_object.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:app_du_lich/screens/dang_nhap_dang_ky/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant.dart'; // Đây là trang đổi mật khẩu

class DoiMatKhau extends StatefulWidget {
  const DoiMatKhau({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DoiMatKhauState();
  }
}

class DoiMatKhauState extends State<DoiMatKhau> {
  // Man update 24/01/2022 | you linh nho copy full 0.
  final TextEditingController txtpassword =
      TextEditingController(); // pass hien tai
  final TextEditingController txtconfirmpassword = TextEditingController();
  final TextEditingController txtOldPassword =
      TextEditingController(); //pass cũ

  final GlobalKey<FormState> _formkey = GlobalKey<
      FormState>(); // Khởi tạo KHÓA CHUNG để bắt được thay đổi trong Form

  User? user;
  bool _loading = true;
  String checkPass = '';
  bool showPassword = true; // pass moi
  bool showconfirmPassword = true; // pass xac nhan
  bool showOldPassword = true; // pass cu

  void getPassword() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      checkPass = pref.getString('password') ?? '';
    });
  }

  void setPassword() async {
    // Khi nguoi ta doi xong thi minh se luu cai gia tri moi cho than pass neu doi nua van ok
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('password',
        txtpassword.text.isEmpty ? '' : txtpassword.text.toString());
  }

  void getInfo() async {
    ApiResponse response = await getUser();
    if (response.error == null) {
      setState(() {
        user = response.data as User;
        _loading = !_loading;
        // checkPass = user!.password ?? '';
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        _loading = !_loading;
      });
    }
  }

  @override
  void initState() {
    getInfo();
    getPassword();
    super.initState();
  }

  void _updatePass() async {
    // Man update 25/01/2022
    ApiResponse response = await updatePassUser(txtpassword.text);

    setState(() {
      _loading = !_loading;
    });
    if (response.error == null) {
      setState(() {
        _loading = !_loading;
      });
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('${response.data}'),
      // ));
      Navigator.of(context).pop(response.data.toString());
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        _loading = !_loading;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Đổi mật khẩu',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Mật khẩu tối thiểu 6 ký tự'),
                  ),
                  Padding(
                      // Man update 24/01/2022
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: txtOldPassword,
                        obscureText:
                            showOldPassword, // Khi thuộc tính là true thì pass sẽ show
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            hintText:
                                'Nhập mật khẩu cũ', // hintStyle: TextSTyle()
                            labelText: 'Mật khẩu cũ',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.security),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showOldPassword = !showOldPassword;
                                }); // Cập nhật lại trạng thái đăng nhập
                              },
                              icon: Icon(
                                showOldPassword
                                    ? Icons.visibility_off
                                    : Icons.remove_red_eye,
                                color: showOldPassword
                                    ? Colors.blue
                                    : Colors
                                        .grey, // Khi _showPassword là true màu là xanh và ngược lại
                              ),
                            )),
                        validator: (value) {
                          // Check dữ liệu người dùng nhập vào
                          if (value!.isEmpty) {
                            return "Nhập đầy đủ thông tin bạn";
                          }
                          if (value.length < 6) {
                            return "Mật khẩu tối thiếu 6 ký tự";
                          }
                          // ignore: unrelated_type_equality_checks
                          if (checkPass != value) {
                            print(checkPass);
                            return "Mật khẩu cũ không trùng khớp";
                          }
                          return null;
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: txtpassword,
                        obscureText:
                            showPassword, // Khi thuộc tính là true thì pass sẽ show
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            hintText:
                                'Nhập mật khẩu mới', // hintStyle: TextSTyle()
                            labelText: 'Mật khẩu mới',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.security),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                }); // Cập nhật lại trạng thái đăng nhập
                              },
                              icon: Icon(
                                showPassword
                                    ? Icons.visibility_off
                                    : Icons.remove_red_eye,
                                color: showPassword
                                    ? Colors.blue
                                    : Colors
                                        .grey, // Khi _showPassword là true màu là xanh và ngược lại
                              ),
                            )),
                        validator: (value) {
                          // Check dữ liệu người dùng nhập vào
                          if (value!.isEmpty) {
                            return "Nhập đầy đủ thông tin ";
                          }
                          if (value.length < 6) {
                            return "Mật khẩu tối thiếu 6 ký tự";
                          }
                          return null;
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: txtconfirmpassword,
                        obscureText:
                            showconfirmPassword, // Khi thuộc tính là true thì pass sẽ show
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            hintText:
                                'Nhập xác nhận mật khẩu mới', // hintStyle: TextSTyle()
                            labelText: 'Xác nhận khẩu mới',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.security),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showconfirmPassword = !showconfirmPassword;
                                }); // Cập nhật lại trạng thái đăng nhập
                              },
                              icon: Icon(
                                showconfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.remove_red_eye,
                                color: showconfirmPassword
                                    ? Colors.blue
                                    : Colors
                                        .grey, // Khi _showPassword là true màu là xanh và ngược lại
                              ),
                            )),
                        validator: (value) {
                          // Check dữ liệu người dùng nhập vào
                          if (value!.isEmpty) {
                            return "Nhập đầy đủ thông tin";
                          }
                          if (value.length < 6) {
                            return "Mật khẩu tối thiếu 6 ký tự";
                          }
                          if (txtpassword.text != txtconfirmpassword.text) {
                            return 'Mật khẩu không trùng khớp';
                          }
                          return null;
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              primary: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)))),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              setPassword();
                              _updatePass();
                              print("Validated");
                            } else {
                              // ignore: avoid_print
                              print("Not Validated");
                            }
                          },
                          child: const Text(
                            'Hoàn thành',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xF2F1F4F9),
    );
  }
}
