// Đây là màn hình tạo bài viết 
import 'package:app_du_lich/constant.dart';
import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/provider/bai_viet_provider.dart';
import 'package:app_du_lich/provider/user_provider.dart'; // Import vào để dùng phương thức getStringImage để encode img
import 'package:app_du_lich/screens/create_and_update/chon_dia_danh.dart';
import 'package:app_du_lich/screens/dang_nhap_dang_ky/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Cho phép thao tác đọc ghi với android
import 'package:image_picker/image_picker.dart'; // Thư viện hỗ trọ up ảnh vô yam copy ra
import 'dart:io'; // Cho phép sử dụng các phương thức hỗ trợ liên quan đến tệp


class TaoBaiViet extends StatefulWidget{
  const TaoBaiViet({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TaoBaiVietState();
  }

}

class TaoBaiVietState extends State<TaoBaiViet>{
  final  _picker = ImagePicker(); //khai báo để dùng các thuộc tính liên quan đến ảnh
  File? _imageFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Khởi tạo KHÓA CHUNG để bắt được thay đổi trong Form
  final TextEditingController _txtContent = TextEditingController();
  bool _loading = false;
  int _idDiaDanh = 0;// Biến chứa giá trị khi ta chọn địa danh bên screen khác
  // ignore: non_constant_identifier_names
  
void _taoBaiViet() async{
  // Do không thể lưu ảnh bình thường nên phải convert nó sang mã base64 
  String? image = _imageFile == null? null: getStringImage(_imageFile); // Nếu có ảnh sẽ encode sang mã base 64
  ApiResponse response =  await taoBaiViet(_txtContent.text, _idDiaDanh);   // Giong nhu tra ve response.body

  if(response.error == null) { // Neu tạo bài thành công 
    if(image!=null) // có ảnh
    {
      {
       ApiResponse responseID = await getIdBaiViet(); // lấy id bài viết để thêm ảnh cho bài vừa tạo
       Map<dynamic, dynamic> idBaiViet = responseID.data as Map<dynamic, dynamic>;
       int i = idBaiViet['id'];
      ApiResponse responseIMG = await taoHinhBaiViet(i, image);
      if(responseIMG.error != null)
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
       ));
        setState(() {
       _loading = !_loading;
        });
      }
    }
    }
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
  Widget _createButton(IconData icon, String txt) { // er - Tạo button ở dưới cùng
    return Container(
                 decoration: const BoxDecoration(
                   border: Border(
                     top: BorderSide(
                       width: 0.5,
                       color: Colors.grey
                     ),
                     bottom: BorderSide(
                       width: 0.5,
                       color: Colors.grey
                     )  
                   )
                 ),
                 child: TextButton(
                   onPressed: () async{
                    final result =await Navigator.push(
                     context, 
                      MaterialPageRoute(builder: (context) =>const ChonDiaDanh())
                     );

                  if(result != null) {
                    setState(() {
                      _idDiaDanh = result; // hứng cái bên kia trả về nếu có
                    });
                  }
                   },
                   child: Row(
                     children: [
                       Icon(icon),
                       Text(txt)
                     ],
                   ),
                 )
               );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          const Text(
              'Viết bài',
              style: TextStyle(
                color: Colors.white
              ),
              ),
            IconButton(
              onPressed: (){
                setState(() {
                  if(_formKey.currentState!.validate()) { //1. Kiem tra xem nguoi ta co nhap gi khong
                    _loading = !_loading;
                    _taoBaiViet();
                  }
                });
              }, 
              icon:const Icon(Icons.send) )
          ],
        ),
      ),
      body: _loading ?const Center(child: CircularProgressIndicator(),) : 
      ListView( 
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
          children: [
              const Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
              //    backgroundImage: AssetImage('images/avatar01.jpg'),
                 ),
                title: Text(
                  'Trương Vô Kỵ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                ),
              ),
               // =0= Phần avatar
             Form(
               key: _formKey,
               child: Padding(
                       padding:const EdgeInsets.all(8.0),
                       child: TextFormField(
                controller: _txtContent,
                keyboardType: TextInputType.multiline,
                maxLines: 9,
                validator: (val)=> val!.isEmpty?'Nhap gi di ban ey':null,
                decoration:const InputDecoration(
                border: InputBorder.none,
                hintText: 'Chia sẻ cảm xúc của bạn'
                ),
               ),
                       ),
             ),
             // =1= Phần textField
          _createButton(Icons.location_on, 'Check in'),
            // =2= 
          Padding(
           padding:const EdgeInsets.all(12.0),
           child:  ButtonBar(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.photo_camera),
                onPressed: () async => _pickImageFromGallery(),
                tooltip: 'Shoot picture',
              ),
              IconButton(
                icon: const Icon(Icons.photo),
                onPressed: () async => _pickImageFromGallery(),
                tooltip: 'Pick from gallery',
            ),
          ],
       )),
            // =3= Button img
          ],
        ),
         
       // Check Value
        if (_imageFile == null)
          const Placeholder()
        else
          Image.file(_imageFile!),
          ], ),
        ],
      )
    );
  }
 
// ignore: unused_element

Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

 

}