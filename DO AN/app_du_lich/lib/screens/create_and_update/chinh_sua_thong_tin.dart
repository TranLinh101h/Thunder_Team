import 'package:flutter/material.dart';

class ChinhSuaThongTin extends StatefulWidget {
  const ChinhSuaThongTin({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChinhSuaThongTinState();
  }
}

class ChinhSuaThongTinState extends State<ChinhSuaThongTin> {
  late String _status = "hoạt động";

  static const menuStatus = <String>['hoạt động', 'ẩn'];

  // ignore: unused_field
  final List<PopupMenuItem<String>> _popUpMenuItems = menuStatus
      .map((String value) => PopupMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  // ignore: unused_element
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

  Widget _BuildTextField(String txtLabel, String txtName) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          txtLabel,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
        ),
        TextField(
          decoration: InputDecoration(
              hintText: txtName, hintStyle: const TextStyle(fontSize: 18)),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    ));
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
              onPressed: () {},
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa thông tin'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: _ShowPersonalInformation('Trần Linh'),
          ),
          _ChangeInformation(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                _BuildTextField("Tên hiển thị", "Trần Linh"),
                _BuildTextField("Giới tính", "Nam"),
                _BuildTextField("Ngày sinh", "12/12/1999"),
                _BuildTextField("Email", "thunderteam@gmail.com"),
                _BuildTextField("Quê quán", "tphcm"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
