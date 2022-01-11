// Đây là trang đề xuất
import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/de_xuat_object.dart';
import 'package:app_du_lich/provider/de_xuat_provider.dart';
import 'package:app_du_lich/provider/loai_dia_danh_provider.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:app_du_lich/screens/dang_nhap_dang_ky/login.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Thư viện hỗ trọ up ảnh vô yam copy ra
import 'dart:io'; 
import 'package:geolocator/geolocator.dart';

import '../../constant.dart'; // Location hien tai


class DeXuatDiaDanh extends StatefulWidget{
  const DeXuatDiaDanh({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    return DeXuatDiaDanhState();
  }

} 

class DeXuatDiaDanhState extends State<DeXuatDiaDanh> {
  File? _imageFile;
  final _picker = ImagePicker();
  bool _loading = true;
  List<dynamic> _lstItems =[] ; // Chứa danh sách item lấy về
  String? value; // Gía trị drop button
  String viDoData = "";
  String kinhDoData = "";
  String idLoai = '1';
  final TextEditingController _txtTenDiaDanh = TextEditingController();
  final TextEditingController _txtTenGoiKhac = TextEditingController();
  final TextEditingController _txtNoiDung = TextEditingController();

  void _taoDeXuat(String idLoai, String tenDiem, String tenGoiKhac, String moTa, String kinhDo, String viDo) async {
    // Do không thể lưu ảnh bình thường nên phải convert nó sang mã base64 
    String? image = _imageFile == null ? null: getStringImage(_imageFile); // Nếu có ảnh sẽ encode sang mã base 64
    ApiResponse response = await taoDeXuat(idLoai,tenDiem,tenGoiKhac,moTa,kinhDo,viDo,image!);

     if(response.error == null) {
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

  getCurrentPosition() async {
    Position position = await Geolocator 
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high); // Gọi api từ gg lấy về vị trí
  
    setState(() {
      viDoData = '${position.latitude}'; 
      kinhDoData = '${position.longitude}';
    });

 }

    List<String> menuItems = <String>[  // Item của drop button
      'Loai',
  ];

  DropdownMenuItem<String> _buildItem(String item) => DropdownMenuItem( //
    value: item,
    child: Text(
      item,
    ),
  );

  Future<void> truyXuatLoaiDiaDanh() async{ // Truy xuất các địa dnah đổ vào drop button
    ApiResponse response = await  getLoaiDiaDanh();

    if(response.error==null){
        setState(() {
          _lstItems = response.data as List<dynamic>;
              for(int i=0;i<_lstItems.length;i++)
           { 
              String temp = _lstItems[i].ten_Loai;
             // print(temp);
              menuItems.add(temp);
           }
          menuItems;    
        _loading = _loading ? !_loading : _loading; // Nếu loading = true thi gán lại bằng flase khoong thì nó bằng chính nó
      });
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${response.error}')
     ));
      setState(() {
      _loading = !_loading; // Thông báo lỗi rồi nên tắt load đi
    });
    }
  }


    @override
  void initState() {
    super.initState();
      truyXuatLoaiDiaDanh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          const Text(
              'Đề xuất địa danh',
              style: TextStyle(
                color: Colors.white
              ),
              ),
            IconButton(
              onPressed: (){
                // idLoai,tenDem,tenGoiKhac,moTa,kinhDo,viDo,image!
                print(_txtTenDiaDanh.text);
                print(kinhDoData);
                print(idLoai);
                _taoDeXuat(idLoai, _txtTenDiaDanh.text, _txtTenGoiKhac.text,_txtNoiDung.text,kinhDoData, viDoData);
              }, 
              icon:const Icon(Icons.send) )
          ],
        ),
      ),
      body: ListView(
        children: [
          Column(
        children: [
         Padding(
           padding:const EdgeInsets.all(12.0),
           child: TextField(
             controller: _txtTenDiaDanh,
             decoration: InputDecoration(
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(5)),
                 hintText: "Nhập tên địa danh",
                 labelText: "Tên địa danh" 
             ),
           ),
          ),
          Padding(
           padding:const EdgeInsets.all(12.0),
           child: TextField(
             controller: _txtTenGoiKhac,
             decoration: InputDecoration(
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(5)),
                 hintText: "Nhập tên gọi khác (không bắt buộc)",
                 labelText: "Tên gọi khác" 
             ),
           ),
          ),
        Padding(
           padding:const EdgeInsets.all(12.0),
           child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all( Radius.circular(8)), //RESIZE RADIUS 
              ),
              child: ListTile(
          title: const Text('Chọn chủ đề:'),
          trailing: _loading ? const CircularProgressIndicator()  : DropdownButton<String>(
            value: value,
            items: menuItems.map(_buildItem).toList() ,
            onChanged: (value) => setState(() {
              this.value = value;
              // print(menuItems.indexOf(value!)); 
              idLoai = menuItems.indexOf(value!).toString();
            }) 
            
          ),
        ),
          )),
       //=3= 
        Padding(
           padding:const EdgeInsets.all(12.0),
           child: TextField(
             controller: _txtNoiDung,
             decoration: InputDecoration(
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(5)),
                 hintText: "Nhập mô tả",
                 labelText: "Mô Tả" 
             ),
           ),
          ),
       //=4=
        Padding(
           padding:const EdgeInsets.all(12.0),
           child: TextButton(
                   onPressed: (){
                     getCurrentPosition();
                    //  print(kinhDoData);
                    //  print(viDoData);
                   },
                   child: Row(
                     children: const [
                       Icon(Icons.pin_drop_outlined),
                       Text(' Location')
         ]))),
         
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: 
               Align(
                 alignment: Alignment.centerLeft,
                 child:  Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( '▶Kinh độ  ' + kinhDoData  ),
                      Text( '▶Vĩ độ  ' + viDoData ),
                    ],
                 ) ,
               ),
           ),
      
       // =5=
       Padding(
           padding:const EdgeInsets.all(12.0),
           child:  ButtonBar(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.photo_camera),
              onPressed: () async => _pickImageFromCamera(),
              tooltip: 'Shoot picture',
            ),
            IconButton(
              icon: const Icon(Icons.photo),
              onPressed: () async => _pickImageFromGallery(),
              tooltip: 'Pick from gallery',
            ),
          ],
       )),
        if (_imageFile == null)
          const Placeholder()
        else
          Image.file(_imageFile!),
          
       ],
      ),
        ],
      )
    );
  }

Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

}