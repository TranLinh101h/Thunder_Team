// Đây là trang đề xuất
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Thư viện hỗ trọ up ảnh vô yam copy ra
import 'dart:io'; 

class DeXuatDD extends StatefulWidget{
  const DeXuatDD({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RDeXuatDDState();
  }

} 

class DeXuatDDState extends State<DeXuatDD> {
   File? _imageFile;
  final _picker = ImagePicker();


  static const menuItems = <String>[
    'Phượt',
    'Leo Núi',
    'Tâm Linh',
    'Đốt Trại',
    'Khám Phá'
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();// Danh sách nọi dung nhu cầu

 String _btnSelectedVal = 'Phượt';
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
              onPressed: (){}, 
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
          trailing: DropdownButton<String>(
            // Must be one of items.value.
            value: _btnSelectedVal,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() => _btnSelectedVal = newValue);
              }
            },
            items: _dropDownMenuItems,
          ),
        ),
          )),
       //=3= 
        Padding(
           padding:const EdgeInsets.all(12.0),
           child: TextField(
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
                   onPressed: (){},
                   child: Row(
                     children: const [
                       Icon(Icons.pin_drop_outlined),
                       Text(' Location')
         ]))),
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
        if (this._imageFile == null)
          const Placeholder()
        else
          Image.file(this._imageFile!),
          
       ],
      ),
        ],
      )
    );
  }

Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => this._imageFile = File(pickedFile.path));
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => this._imageFile = File(pickedFile.path));
    }
  }

}