import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/min_dia_danh_object.dart';
import 'package:app_du_lich/provider/bai_viet_provider.dart';
import 'package:flutter/material.dart'; // Man create 07/01/2022 | màn hình này chọn địa danh

class ChonDiaDanh extends StatefulWidget {
  const ChonDiaDanh({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChonDiaDanhState();
  }

}

class _ChonDiaDanhState extends State<ChonDiaDanh> {
  List<dynamic> _lstBaiViet = [];
  bool _loading = true; // Nếu có data rồi = false và không load nữa 
  List<dynamic> _lstResult = [];
  TextEditingController txtSearch = TextEditingController();
  bool _isSearch = false; // Biến cờ để check xem người ta có tìm không
  Min_Dia_Danh? temp ;
  

  // Man| Lấy danh sách tên địa danh cho ta chọn 
  Future<void> truyXuatTenDiaDanh() async{
    ApiResponse response = await getNameDiaDanh();

    if(response.error==null){
      setState(() {
        _lstBaiViet = response.data as List<dynamic>;
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
    truyXuatTenDiaDanh();
    super.initState();
  }

  // ignore: non_constant_identifier_names
  void SearchDiaDanh() {
    _lstResult = []; // Mỗi lần tìm thì làm mới ds kết quả đi
    for(int i=0; i<_lstBaiViet.length; i++){
      if(_lstBaiViet[i].ten_dia_danh.toString().contains(txtSearch.text) ) { // like %x%
        _lstResult.add(_lstBaiViet[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Check In'),
      ),
      body: Column(
        children: [
          TextField(
            controller: txtSearch,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            hintText: 'Đà Lạt - Lâm Đồng',
            suffixIcon: IconButton(
              onPressed: (){
                setState(() {
                  _isSearch = true; // Khi ta chọn tìm thì set lại biến cờ
                });
                SearchDiaDanh();
              },
              icon:const Icon(
                Icons.search,
              ),
            )
            ),
          ),
          _loading?const CircularProgressIndicator(): ListView.builder(
             scrollDirection: Axis.vertical,
    shrinkWrap: true,
            itemCount: _isSearch ? _lstResult.length :_lstBaiViet.length,
            itemBuilder: (context, index) => ListTile(
              title: Text( _isSearch  ?  _lstResult[index].ten_dia_danh : // Nếu đang không tìm thì không sài ds của người ta
              _lstBaiViet[index].ten_dia_danh),
             onTap: (){
               Navigator.pop(context,_isSearch ?temp = _lstResult[index]:temp = _lstBaiViet[index]); 
             },
            )
          )
        ],
      ),
    );
  }



}