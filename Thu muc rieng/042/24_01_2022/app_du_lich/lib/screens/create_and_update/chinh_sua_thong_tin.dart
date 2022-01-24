import 'dart:io';

import 'package:app_du_lich/constant.dart';
import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/user_object.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:app_du_lich/screens/dang_nhap_dang_ky/login.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChinhSuaThongTin extends StatefulWidget {
  const ChinhSuaThongTin({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChinhSuaThongTinState();
  }
}

class ChinhSuaThongTinState extends State<ChinhSuaThongTin> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSdt = TextEditingController();
  User? user;
  bool _loading = true;
  File? _imageFile;
  final _picker = ImagePicker();
  bool _switchEmail = true;
  bool _switchSdt = true;

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }


  void getInfo() async {
    ApiResponse response = await getUser();
    if (response.error == null) {
      setState(() {
        user = response.data as User;
        _loading = !_loading;
        txtName.text = user!.name ?? '';
        txtEmail.text = user!.email ?? '';
        txtSdt.text = user!.sdt ?? '';
        _switchEmail = user!.status_email == 1 ? true :false; 
        _switchSdt = user!.status_sdt== 1 ? true :false; 
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

    super.initState();
  }

  void _updateProfile() async {
    String? image = _imageFile == null
        ? null
        : getStringImage(_imageFile); // Nếu có ảnh sẽ encode sang mã base 64
    ApiResponse response =
        await updateUser(txtName.text, txtEmail.text, txtSdt.text, image);

    setState(() {
      _loading = !_loading;
    });
    if (response.error == null) {
      setState(() {
        _loading = !_loading;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.data}'),
      ));
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

  Widget _buildProfile() {
    return GestureDetector(
        child: Container(
          margin:const EdgeInsets.only(left: 101, right: 101),
          width: 50,
          height: 110,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              image: _imageFile == null
                  ? user!.img != null
                      ? DecorationImage(
                          image: NetworkImage('${user!.img}'),
                          fit: BoxFit.cover)
                      : null
                  : DecorationImage(
                      image: FileImage(_imageFile ?? File('')),
                      fit: BoxFit.cover),
              color: Colors.amber),
        ),
        onTap: () {
          _pickImageFromGallery();
        });
  }

  Widget buildSwitchEmail(String stEmail, bool _value) {
    return Switch(
             onChanged: (bool value) {
               setState(() {
                 if(_value == false )
                 {
                   stEmail = '1';
                 }
                 _value =!_value;
                  _hidenEmail(stEmail);
               });
             },
              value: _value ,
             );
  }

  Widget buildSwitchSdt( String stSdt, bool _value) {
    return Switch(
             onChanged: (bool value) {
               setState(() {
                   if(_value == false )
                 {
                   stSdt = '1';
                 }
                 _value =!_value;
                  hidenSDT(stSdt);
               });
             },
              value: _value ,
             );
  }

  // ignore: non_constant_identifier_names
  Widget _BuildTextField(
      String txtLabel, String txtName, TextEditingController controll, Widget _switch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              txtLabel,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
            ),
            _switch
          ],
        ),
        TextField(
          controller: controll,
          decoration: InputDecoration(
              hintText: txtName, hintStyle: const TextStyle(fontSize: 18)),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  void _hidenEmail(String stEmail) async {
    ApiResponse response = await hidenEmail(stEmail);

    setState(() {
      _loading = !_loading;
    });

    if (response.error == null) {
      setState(() {
        _loading = !_loading;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.data}'),
      ));
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

  } // Man create 15/01/2022 : 20:22:13

  void _hidenSdt(String stSDT) async {
    ApiResponse response = await hidenSDT(stSDT);

    setState(() {
      _loading = !_loading;
    });

    if (response.error == null) {
      setState(() {
        _loading = !_loading;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.data}'),
      ));
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

  } // Man create 15/01/2022 : 20:22:13

  // ignore: non_constant_identifier_names
  Widget ChangeInformation() {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(width: 5, color: Colors.grey.shade100))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(
                Icons.person,
                size: 28,
                color: Colors.blue,
              ),
              Text(
                ' Thông tin cá nhân',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18),
              ),
            ],
          ),
          TextButton(
              onPressed: () {
                _updateProfile();
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.update,
                  ),
                  Text('  Cập nhật')
                ],
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text('Chỉnh sửa thông tin'),
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _buildProfile(),
                ),
                ChangeInformation(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      _BuildTextField("Tên hiển thị", "", txtName,const SizedBox() ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                            const  Text(
                                'Email',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
                              ),
                              buildSwitchEmail('0', _switchEmail)
                            ],
                          ),
                          TextField(
                            controller: txtEmail,
                            decoration: InputDecoration(
                                hintText: txtEmail.text, hintStyle: const TextStyle(fontSize: 18)),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                            const  Text(
                                'SDT',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
                              ),
                              buildSwitchSdt('0', _switchSdt)
                            ],
                          ),
                          TextField(
                            controller: txtEmail,
                            decoration: InputDecoration(
                                hintText: txtSdt.text, hintStyle: const TextStyle(fontSize: 18)),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                      // _BuildTextField("Email", "thunderteam@gmail.com", _txtEmail, buildSwitchEmail('0', _switchEmail ) ),
                      // _BuildTextField("Số điện thoại", "0706050423", _txtSdt, buildSwitchSdt('0', _switchSdt )),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
