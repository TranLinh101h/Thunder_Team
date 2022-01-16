import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/user_object.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:app_du_lich/screens/dang_nhap_dang_ky/login.dart';
import 'package:flutter/material.dart';

import '../../constant.dart'; // Đây là trang đổi mật khẩu

class DoiMatKhau extends StatefulWidget{
  const DoiMatKhau({Key ? key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DoiMatKhauState();
  }
}

class DoiMatKhauState extends State<DoiMatKhau>{
  final TextEditingController txtpassword = TextEditingController(); // pass hien tai
  final TextEditingController txtconfirmpassword = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>(); // Khởi tạo KHÓA CHUNG để bắt được thay đổi trong Form

  final String _condition = "if(_password.text != _confirmpassword.text){ return 'Mật khẩu không trùng khớp'; }";
  User? user;
  bool _loading = true;
  String checkPass = '';
  bool showPassword = true; // pass moi
  bool showconfirmPassword = true; // pass xac nhan

  void getInfo() async {
    ApiResponse response = await getUser();
    if(response.error == null )
    {
      setState(() {
        user = response.data as User;
        _loading = !_loading;
        // checkPass = user!.password ?? '';
      });
    } 
    else if(response.error == unauthorized) {
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage() ) , (route) => false)
      } );
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${response.error}')
    ));
    setState(() {
      _loading = !_loading;
    });
    }
  }

   @override
  void initState() {
    getInfo();
    super.initState();
  }

  void _updatePass() async {
    ApiResponse response = await updatePassUser(txtpassword.text);

    setState(() {
      _loading = !_loading;
    });
    if(response.error == null ){
      setState(() {
      _loading = !_loading;
    });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.data}'),
      ));
       Navigator.of(context).pop();
    }
    else if (response.error == unauthorized ){
    logout().then((value)=>{
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false)
    }); 
  }
  else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${response.error}')
    ));
    setState(() {
      _loading = !_loading;
    });
  }
  }

  // ignore: unused_element
  Widget _buildPasswordTextFormField(String hintxt, String labeltxt, TextEditingController ctrPass, String con, bool showPass) {
    return TextFormField(
      controller: ctrPass,
      obscureText: showPass, // Khi thuộc tính là true thì pass sẽ show
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        hintText: hintxt,         // hintStyle: TextSTyle()
        labelText: labeltxt,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.security),
        suffixIcon: IconButton(
          onPressed: (){
            setState(() {
              showPass = !showPass;
             
            }); // Cập nhật lại trạng thái đăng nhập
          }, 
          icon: Icon( showPass ?
            Icons.visibility_off : Icons.remove_red_eye,
            color: showPass ? Colors.blue : Colors.grey, // Khi _showPassword là true màu là xanh và ngược lại
          ), )
       ),
      validator: (value){ // Check dữ liệu người dùng nhập vào
        if(value!.isEmpty){ 
          return "Nhập đầy đủ thông tin bạn êy";
        }
        if(value.length <=6){
          return "Mật khẩu tối thiếu 6 ký tự";
        }
        con;
        return null;
      },

    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
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
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                          fontSize: 25
                       ),
                     ),
                    ),
                 const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Mật khẩu tối thiểu 8 ký tự'),
                    ),
                 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: txtpassword,
                      obscureText: showPassword, // Khi thuộc tính là true thì pass sẽ show
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        hintText: 'Nhập mật khẩu mới',         // hintStyle: TextSTyle()
                        labelText: 'Mật khẩu mới',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.security),
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              showPassword = !showPassword;
                            }); // Cập nhật lại trạng thái đăng nhập
                          }, 
                          icon: Icon( showPassword ?
                           Icons.visibility_off : Icons.remove_red_eye ,
                            color: showPassword ? Colors.blue : Colors.grey, // Khi _showPassword là true màu là xanh và ngược lại
                          ), )
                      ),
                      validator: (value){ // Check dữ liệu người dùng nhập vào
                        if(value!.isEmpty){ 
                          return "Nhập đầy đủ thông tin bạn êy";
                        }
                        if(value.length <=6){
                          return "Mật khẩu tối thiếu 6 ký tự";
                        }
                        return null;
                       },
                      )
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: txtconfirmpassword,
                      obscureText: showconfirmPassword, // Khi thuộc tính là true thì pass sẽ show
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        hintText: 'Nhập xác nhận mật khẩu mới',         // hintStyle: TextSTyle()
                        labelText: 'Xác nhận khẩu mới',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.security),
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              showconfirmPassword = !showconfirmPassword;
                            }); // Cập nhật lại trạng thái đăng nhập
                          }, 
                          icon: Icon( showconfirmPassword ?
                           Icons.visibility_off : Icons.remove_red_eye ,
                            color: showconfirmPassword ? Colors.blue : Colors.grey, // Khi _showPassword là true màu là xanh và ngược lại
                          ), )
                      ),
                      validator: (value){ // Check dữ liệu người dùng nhập vào
                        if(value!.isEmpty){ 
                          return "Nhập đầy đủ thông tin";
                        }
                        if(value.length <=6){
                          return "Mật khẩu tối thiếu 6 ký tự";
                        }
                        if(txtpassword.text != txtconfirmpassword.text){ return 'Mật khẩu không trùng khớp'; }
                        return null;
                       },
                      )
                    ),
                 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          primary: Colors.white,
                          shape:const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0))
                          )
                        ),
                        onPressed: (){
                          if (_formkey.currentState!.validate()) {
                                  _updatePass();
                                print("Validated");
                          }else{
                                // ignore: avoid_print
                                print("Not Validated");
                           }
                        },
                        child:const Text(
                          'Hoàn thành',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                          ),
                          ),
                      ),
                     )
                    ),
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor:const Color(0xF2F1F4F9),
    );
  }
  
}
