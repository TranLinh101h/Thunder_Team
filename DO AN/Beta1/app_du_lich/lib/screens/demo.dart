// // Đây là trang đề xuất
// import 'package:app_du_lich/objects/api_response.dart';
// import 'package:app_du_lich/provider/loai_dia_danh_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart'; // Thư viện hỗ trọ up ảnh vô yam copy ra
// import 'dart:io'; 

// class DeXuatDiaDanh extends StatefulWidget{
//   const DeXuatDiaDanh({Key? key}) : super(key: key);
  
//   @override
//   State<StatefulWidget> createState() {
//     return DeXuatDiaDanhState();
//   }

// } 

// class DeXuatDiaDanhState extends State<DeXuatDiaDanh> {
//   File? _imageFile;
//   final _picker = ImagePicker();
//   bool _loading = true;
//   List<dynamic> _lstItems =[] ;


//   static List<String> menuItems = <String>[ 
//       'Phượt',
//     // 'Leo Núi',
//     // 'Tâm Linh',
//     // 'Đốt Trại',
//     // 'Khám Phá',
//   ];

//   final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
//   .map(
//     (String value) => DropdownMenuItem<String> (
//       value: value,
//       child: Text(value),
//     )
//   ).toList();

//   Future<void> truyXuatLoaiDiaDanh() async{
//     ApiResponse response = await  getLoaiDiaDanh();

//     if(response.error==null){
//         setState(() {
//         // if(_lstItems.isEmpty) {
//           _lstItems = response.data as List<dynamic>;
//               for(int i=0;i<_lstItems.length;i++)
//            { 
//               String temp = _lstItems[i].ten_Loai;
//               print(temp);
//               menuItems.add(temp);
//            }
//         //}
//           menuItems;
//          _dropDownMenuItems;
//         _loading = _loading ? !_loading : _loading; // Nếu loading = true thi gán lại bằng flase khoong thì nó bằng chính nó
//       });
//     }
//     else
//     {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text('${response.error}')
//      ));
//       setState(() {
//       _loading = !_loading; // Thông báo lỗi rồi nên tắt load đi
//     });
//     }
//   }


//     @override
//   void initState() {
  
    
//     super.initState();
//       truyXuatLoaiDiaDanh();
//   }

//   //  final List<DropdownMenuItem<String>> _dropDownMenuItems = lstData
//   //     .map(
//   //       (String value) => DropdownMenuItem<String>(
//   //         value: value,
//   //         child: Text(value),
//   //       ),
//   //     )
//   //     .toList();// Danh sách nọi dung nhu cầu



//  String _btnSelectedVal = 'Phượt';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//           const Text(
//               'Đề xuất địa danh',
//               style: TextStyle(
//                 color: Colors.white
//               ),
//               ),
//             IconButton(
//               onPressed: (){}, 
//               icon:const Icon(Icons.send) )
//           ],
//         ),
//       ),
//       body: ListView(
//         children: [
//           Column(
//         children: [
//          Padding(
//            padding:const EdgeInsets.all(12.0),
//            child: TextField(
//              decoration: InputDecoration(
//                border: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(5)),
//                  hintText: "Nhập tên địa danh",
//                  labelText: "Tên địa danh" 
//              ),
//            ),
//           ),
//         Padding(
//            padding:const EdgeInsets.all(12.0),
//            child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.grey,
//                   width: 2,
//                 ),
//                 borderRadius: const BorderRadius.all( Radius.circular(8)), //RESIZE RADIUS 
//               ),
//               child: ListTile(
//           title: const Text('Chọn chủ đề:'),
//           trailing: _loading ? const CircularProgressIndicator()  : DropdownButton<String>(
//             // Must be one of items.value.
//             value: _btnSelectedVal,
//             onChanged: (String? newValue) {
//               if (newValue != null) {
//                 setState(() => _btnSelectedVal = newValue);
               
//                 print(menuItems.indexOf(_btnSelectedVal) );
//               }
//             },
//             items: _dropDownMenuItems,
//           ),
//         ),
//           )),
//        //=3= 
//         Padding(
//            padding:const EdgeInsets.all(12.0),
//            child: TextField(
//              decoration: InputDecoration(
//                border: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(5)),
//                  hintText: "Nhập mô tả",
//                  labelText: "Mô Tả" 
//              ),
//            ),
//           ),
//        //=4=
//         Padding(
//            padding:const EdgeInsets.all(12.0),
//            child: TextButton(
//                    onPressed: (){},
//                    child: Row(
//                      children: const [
//                        Icon(Icons.pin_drop_outlined),
//                        Text(' Location')
//          ]))),
//        // =5=
//        Padding(
//            padding:const EdgeInsets.all(12.0),
//            child:  ButtonBar(
//           children: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.photo_camera),
//               onPressed: () async => _pickImageFromCamera(),
//               tooltip: 'Shoot picture',
//             ),
//             IconButton(
//               icon: const Icon(Icons.photo),
//               onPressed: () async => _pickImageFromGallery(),
//               tooltip: 'Pick from gallery',
//             ),
//           ],
//        )),
//         if (this._imageFile == null)
//           const Placeholder()
//         else
//           Image.file(this._imageFile!),
          
//        ],
//       ),
//         ],
//       )
//     );
//   }

// Future<void> _pickImageFromGallery() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() => this._imageFile = File(pickedFile.path));
//     }
//   }

//   Future<void> _pickImageFromCamera() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       setState(() => this._imageFile = File(pickedFile.path));
//     }
//   }

// }