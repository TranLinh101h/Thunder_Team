// Đây là màn hình tạo bài viết 
import 'package:app_du_lich/constant.dart';
import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/min_dia_danh_object.dart';
import 'package:app_du_lich/objects/user_object.dart';
import 'package:app_du_lich/provider/bai_viet_provider.dart';
import 'package:app_du_lich/provider/user_provider.dart'; // Import vào để dùng phương thức getStringImage để encode img
import 'package:app_du_lich/screens/create_and_update/chon_dia_danh.dart';
import 'package:app_du_lich/screens/dang_nhap_dang_ky/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Cho phép thao tác đọc ghi với android
import 'package:image_picker/image_picker.dart'; // Thư viện hỗ trọ up ảnh vô yam copy ra
import 'dart:io'; // Cho phép sử dụng các phương thức hỗ trợ liên quan đến tệp



class TaoBaiViet extends StatefulWidget{
  final Min_Dia_Danh selectDiaDanh;
  const TaoBaiViet({Key? key, required this.selectDiaDanh }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return TaoBaiVietState(selectDiaDanh: selectDiaDanh );
  }

}

class TaoBaiVietState extends State<TaoBaiViet>{
  final  _picker = ImagePicker(); //khai báo để dùng các thuộc tính liên quan đến ảnh
  File? _imageFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Khởi tạo KHÓA CHUNG để bắt được thay đổi trong Form
  final TextEditingController _txtContent = TextEditingController();
  bool _loading = true;
  // int _idDiaDanh = 0;// Biến chứa giá trị khi ta chọn địa danh bên screen khác
  Min_Dia_Danh selectDiaDanh; // Man create 14/01/2022 | Biến chứa giá trị ta gửi qua
  User? user;    // Man create 14/01/2022 
  TaoBaiVietState({Key? key, required this.selectDiaDanh });
  

void _taoBaiViet() async{
  // Do không thể lưu ảnh bình thường nên phải convert nó sang mã base64 
  String? image = _imageFile == null? null: getStringImage(_imageFile); // Nếu có ảnh sẽ encode sang mã base 64
  ApiResponse response =  await taoBaiViet(_txtContent.text, selectDiaDanh.id.toString() );   // Giong nhu tra ve response.body

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

void getInfo() async {
    ApiResponse response = await getUser();
    if (response.error == null) {
      setState(() {
        user = response.data as User;
        _loading = !_loading;
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
                      selectDiaDanh = result; // hứng cái bên kia trả về nếu có
                      print(selectDiaDanh.id);
                      print(selectDiaDanh.ten_dia_danh);
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
      body: _loading ? const Center(child: CircularProgressIndicator(),) : 
      ListView( 
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
          children: [
               Padding(
              padding:const EdgeInsets.all(8.0),
              child: ListTile(
                leading: _loading == false ?  CircleAvatar(
                  backgroundImage: NetworkImage(user!.img.toString() ) ,
                )  : const CircleAvatar(),
                title: Text(
                  _loading ? "" : user!.name.toString() ,
                  style:const TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Row(
                  children: [
                  const  Icon(Icons.place_outlined, size: 15, color: Colors.blueAccent ),
                    Text(
                 selectDiaDanh.ten_dia_danh != 'home' ? selectDiaDanh.ten_dia_danh : "",
                 style: const TextStyle(
                   fontSize: 12,
                   color: Colors.blue
                 ),
              ),
                  ],
                )
                ),
              ),
               // =0= Phần avatar
             Form(
               key: _formKey,
               child: Padding(
                       padding:const EdgeInsets.all(8.0),
                       child: Container(
                         decoration: BoxDecoration(
                           border: Border.all(
                             width: 0.5,
                             color: Colors.grey.shade300
                           )
                         ),
                         child: TextFormField(
                controller: _txtContent,
                keyboardType: TextInputType.multiline,
                maxLines: 9,
                validator: (val)=> val!.isEmpty? 'vui Lòng không bỏ trống':null,
                decoration:const InputDecoration(
                border: InputBorder.none,
                hintText: 'Chia sẻ cảm xúc của bạn'
                ),
               ),
                       ),
                       ),
             ),
             // =1= Phần textField
          selectDiaDanh.ten_dia_danh == 'home' ? _createButton(Icons.location_on, 'Check in') : const SizedBox(height: 8,),
            // =2= 
          Padding(
           padding:const EdgeInsets.all(12.0),
           child:  ButtonBar(
            alignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.photo_camera, color: Colors.blue,),
                onPressed: () async => _pickImageFromCamera(),
                tooltip: 'Shoot picture',
              ),
              IconButton(
                icon: const Icon(Icons.photo, color: Colors.blue,),
                onPressed: () async => _pickImageFromGallery(),
               // onPressed: (){print(selectDiaDanh.ten_dia_danh ); print(selectDiaDanh.id);},
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

 Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }
 

}