import 'package:flutter/material.dart'; // Đây là trang đổi mật khẩu

class DoiMatKhau extends StatefulWidget{
  const DoiMatKhau({Key ? key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DoiMatKhauState();
  }
}

class DoiMatKhauState extends State<DoiMatKhau>{
  bool _showPassword = false; // Biến cờ dùng để kiểm tra có show pass hay không
  
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  final TextEditingController _mypassword = TextEditingController(); // Pass cu

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>(); // Khởi tạo KHÓA CHUNG để bắt được thay đổi trong Form

   final String _condition = "if(_password.text != _confirmpassword.text){ return 'Mật khẩu không trùng khớp'; }";
  // ignore: unused_element
  Widget _buildPasswordTextFormField(String hintxt, String labeltxt, TextEditingController ctrPass, String con) {
    return TextFormField(
      controller: ctrPass,
      obscureText: !_showPassword, // Khi thuộc tính là true thì pass sẽ show
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
            setState(() => _showPassword = !_showPassword ); // Cập nhật lại trạng thái đăng nhập
          }, 
          icon: Icon(
            Icons.remove_red_eye,
            color: _showPassword ? Colors.blue : Colors.grey, // Khi _showPassword là true màu là xanh và ngược lại
          ), )
       ),
      validator: (value){ // Check dữ liệu người dùng nhập vào
        if(value!.isEmpty){ 
          return "Nhập đầy đủ thông tin bạn êy";
        }
        if(value.length <8){
          return "Mật khẩu tối thiếu 8 ký tự";
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
                    child: _buildPasswordTextFormField("Nhập mật khẩu hiện tại","Mật khẩu hiện tại", _mypassword, ""),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildPasswordTextFormField("Nhập mật khẩu mới","Mật khẩu mới", _password, ""),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildPasswordTextFormField("Xác nhận mật khẩu mới","Xác nhận mật khẩu mới", _confirmpassword, _condition ),
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
                                // ignore: avoid_print
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
