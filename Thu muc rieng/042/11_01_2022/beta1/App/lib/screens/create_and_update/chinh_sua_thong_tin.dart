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
  TextEditingController _txtName = TextEditingController();
  final TextEditingController _txtGioiTinh = TextEditingController();
  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtSdt = TextEditingController();
  User? user;
  bool _loading = true;
  File? _imageFile;
  final _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

  late String _status = "hoạt động";

  static const menuStatus = <String>['hoạt động', 'ẩn'];

  // ignore: unused_field
  final List<PopupMenuItem<String>> _popUpMenuItems = menuStatus
      .map((String value) => PopupMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  void getInfo() async {
    ApiResponse response = await getUser();
    if(response.error == null )
    {
      setState(() {
        user = response.data as User;
        _loading = !_loading;
        _txtName.text = user!.name ?? '';
        _txtEmail.text = user!.email ?? '';
        _txtSdt.text = user!.sdt ?? '';
        _txtGioiTinh.text = user!.gioi_Tinh?? '';
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

  void _updateProfile() async {
    String? image = _imageFile == null? null: getStringImage(_imageFile); // Nếu có ảnh sẽ encode sang mã base 64
    ApiResponse response = await updateUser(_txtName.text, _txtGioiTinh.text, _txtEmail.text, _txtSdt.text, image! );

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

  // ignore: unused_element, non_constant_identifier_names
  Widget _ShowPersonalInformation(String txtName) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage:
            AssetImage("images/fox.jpg"), // Khi có db từ web sẽ thay lại!
      ),
      title: Text(txtName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          )),
      subtitle: Row(
        children: [
          Icon(
            Icons.trip_origin_outlined,
            size: 15.0,
            color: _status == "hoạt động" ? Colors.green : Colors.red,
          ),
          Text(
            _status == "hoạt động" ? '  đang hoạt động' : '  Ẩn',
            style: TextStyle(
              color: _status == "hoạt động" ? Colors.green : Colors.red,
            ),
          )
        ],
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (String newValue) {
          _status = newValue;
          setState(() {});
        },
        itemBuilder: (BuildContext context) => _popUpMenuItems,
      ),
    );
  }

  Widget _buildProfile() {
    return GestureDetector(
      child: Container(
        margin : EdgeInsets.only(left:  95, right:95 ),
        width: 50,
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          image: _imageFile == null ? user!.img != null ? DecorationImage(
            image: NetworkImage('${user!.img}'),
            fit: BoxFit.cover ) :
          null : DecorationImage(
            image: FileImage( _imageFile ?? File('')),
            fit: BoxFit.cover
            ),
          color: Colors.amber
        ) ,
      ),
        onTap: () {
          _pickImageFromGallery();
      }
    );
  }

  // ignore: non_constant_identifier_names
  Widget _BuildTextField(String txtLabel, String txtName, TextEditingController controll) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    Text(
      txtLabel,
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
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

  Widget _ChangeInformation() {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(width: 5, color: Colors.grey.shade100))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
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
    return _loading ?const Center(child: CircularProgressIndicator()) : Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa thông tin'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: _buildProfile(),
          ),
          _ChangeInformation(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                _BuildTextField("Tên hiển thị", "Trần Linh", _txtName),
                _BuildTextField("Giới tính", "Nam", _txtGioiTinh),
                _BuildTextField("Email", "thunderteam@gmail.com", _txtEmail),
                _BuildTextField("Số điện thoại", "0706050423", _txtSdt),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
