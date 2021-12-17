// Đây là màn hình tạo bài viết 
import 'package:flutter/material.dart';

class TaoBaiViet extends StatefulWidget{
  const TaoBaiViet({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TaoBaiVietState();
  }

}

class TaoBaiVietState extends State<TaoBaiViet>{
  
  Container _createButton(IconData icon, String txt) { // er - Tạo button ở dưới cùng
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
                   onPressed: (){},
                   child: Row(
                     children: const [
                       Icon(Icons.pin_drop_outlined),
                       Text(' Check In')
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
              onPressed: (){}, 
              icon:const Icon(Icons.send) )
          ],
        ),
      ),
      body: Column(
        children: [
        const Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('images/avatar01.jpg'),
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
         const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Chia sẻ cảm xúc của bạn'
              ),
             ),
            ),
             // =1= Phần textField
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all( Radius.circular(8)), //RESIZE RADIUS
              ), //THIS IS SHOW BORDER !
              child: ListTile(
              leading: Image.asset('images/places/halong.jpg'),
              title: const Text('Bay lên nào !'),
              subtitle: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                   children: const [
                     CircleAvatar(
                      backgroundImage: AssetImage('images/avatar01.jpg'),
                      ),
                     Text(
                      '  Cô long',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
            ), )
          ), //=2= Phần shared
          const Padding(padding: EdgeInsets.only(bottom: 330.0)),
          Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.end,
             mainAxisSize: MainAxisSize.max,
             children: [
               _createButton(Icons.place_outlined, '  Check In')
             ],
           ),
          ),
       ],
      ),
    );
  }

}