<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DiaDanhSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('dia_danhs')->insert([
                
            'loai_dia_danh_id'[2],
            'mien_id'[2],
            'phan_vung_id',
            'ten_dia_danh' => 'Hội An',
            'ten_Goi_Khac' => 'Phố Cổ Hội An',
            'mo_Ta'=>'Hội An là một trong những điểm đến hàng đầu của miền Trung với nhiều thắng cảnh đẹp cùng nền ẩm thực độc đáo. Du lịch Hội An, du khách có dịp chiêm ngưỡng những di sản kiến trúc độc đáo có từ hàng trăm năm trước như các ngôi nhà cổ, bảo tàng, chùa chiền,...',
            'kinh_Do', //15°52'43.4"N
            'vi_Do',// 108°19'41.4"E
            'hot'=>"Cao lầu, Mì Quảng, Hoành Thánh,...",
            'status'[1],
            'created_at' => date("Y-m-d H:i:s"),
            'updated_at' => date("Y-m-d H:i:s"),
            'deleted_at' => date("Y-m-d H:i:s"),
        ]);
        DB::table('dia_danhs')->insert([
                
            'loai_dia_danh_id'[1],
            'mien_id'[3],
            'phan_vung_id',
            'ten_dia_danh' => 'Vũng Tàu',
            'ten_Goi_Khac' => 'Biển Vũng Tàu',
            'mo_Ta'=>'Địa điểm du lịch miền Nam Vũng Tàu có bờ biển trải dài, cảnh quan đẹp, cùng nhiều địa danh chứa đựng giá trị văn hóa, lịch sử to lớn, trở thành điểm đến yêu thích của khách du lịch tứ phương. Đến với thành phố biển này, bạn không chỉ được tắm mát, tham gia nhiều hoạt động thể thao trên biển thú vị, mà còn được chiêm ngưỡng cảnh quan đẹp của bãi Trước, bãi Sau, Côn Đảo,... tham quan Bạch Dinh, Bảo tàng vũ khí cổ, đền Lớn,... ',
            'kinh_Do', //10°19'53.6"N
            'vi_Do',// 107°05'19.4"E
            'hot'=>"Bánh khọt, Lẩu cá đuối, Bánh canh ",
            'status'[1],
            'created_at' => date("Y-m-d H:i:s"),
            'updated_at' => date("Y-m-d H:i:s"),
            'deleted_at' => date("Y-m-d H:i:s"),
        ]);
        DB::table('dia_danhs')->insert([
                
            'loai_dia_danh_id'[2],
            'mien_id'[2],
            'phan_vung_id',
            'ten_dia_danh' => 'Cố Đô Huế',
            'ten_Goi_Khac' => 'Thừa Thiên Huế',
            'mo_Ta'=>'Thừa hưởng vẻ đẹp kiến trúc di sản của triều đại nhà Nguyễn, kế thừa nét đẹp trong văn hóa phong tục Hoàng Cung, Huế đã hội tụ đủ và sâu để du khách khi đặt chân đến đây cũng phải gật gù. Nếu tâm hồn của du khách đủ sâu, tĩnh lặng hoặc đang muốn tìm lại sự yên bình thì Huế chính là địa điểm giúp bạn sống chậm, hiểu sâu và tái tạo năng lượng cho bạn.',
            'kinh_Do', //16°28'14.7"N
            'vi_Do',// 107°34'40.8"E
            'hot'=>"Bún bò Huế, Chè Huế",
            'status'[1],
            'created_at' => date("Y-m-d H:i:s"),
            'updated_at' => date("Y-m-d H:i:s"),
            'deleted_at' => date("Y-m-d H:i:s"),
        ]);
        DB::table('dia_danhs')->insert([
                
            'loai_dia_danh_id'[1],
            'mien_id'[3],
            'phan_vung_id',
            'ten_dia_danh' => 'Nha Trang',
            'ten_Goi_Khac' => 'Bãi Biển Nha Trang',
            'mo_Ta'=>'Thiên đường du lịch Nha Trang là một trong những vịnh biển đẹp nhất thế giới. Đến với Nha Trang, du khách sẽ được khám phá những chân trời mới như khu du lịch Vinpearland, kiến trúc Chăm độc đáo … Hoà mình vào bầu không khí trong lành, cùng những bãi biển đẹp diệu kì, vui chơi tại công viên giải trí, tận hưởng dịch vụ tắm bùn, chơi golf … du khách sẽ có những trải nghiệm cực kì thú vị.',
            'kinh_Do', //12°14'12.1"N
            'vi_Do',// 109°11'52.2"E
            'hot'=>"Bún Cá Nha Trang, Bánh Xèo Nha Trang, Nem Nướng Nha Trang",
            'status'[1],
            'created_at' => date("Y-m-d H:i:s"),
            'updated_at' => date("Y-m-d H:i:s"),
            'deleted_at' => date("Y-m-d H:i:s"),
        ]);
        DB::table('dia_danhs')->insert([
                
            'loai_dia_danh_id'[3],
            'mien_id'[2],
            'phan_vung_id',
            'ten_dia_danh' => 'Đà Lạt',
            'ten_Goi_Khac' => 'Thành Phố Mộng Mơ',
            'mo_Ta'=>'Đà Lạt là một thành phố mộng mơ, huyền ảo trong làn sương mù trắng xoá và luôn ngập tràn muôn sắc hoa. Khí hậu ôn hoà, ấm áp của Đà Lạt cũng là một trong những lí do lôi cuốn khách du lịch tới tham quan, du lịch và nghỉ dưỡng.',
            'kinh_Do', //11°57'02.0"N
            'vi_Do',// 108°26'59.1"E
            'hot'=>"Bánh tráng nướng, Bánh căn, Bánh ướt lòng gà",
            'status'[1],
            'created_at' => date("Y-m-d H:i:s"),
            'updated_at' => date("Y-m-d H:i:s"),
            'deleted_at' => date("Y-m-d H:i:s"),
        ]);
        DB::table('dia_danhs')->insert([
                
            'loai_dia_danh_id'[3],
            'mien_id'[1],
            'phan_vung_id',
            'ten_dia_danh' => 'Sapa',
            'ten_Goi_Khac' => 'Vùng đất sương mù',
            'mo_Ta'=>'Nếu có thể dùng những từ ngắn gọn để miêu tả Sapa thì chỉ có thể là tuyệt đẹp, bí ẩn và trong lành. Giới thiệu một chút về Sapa, Sapa nằm ở phía tây bắc của Tổ quốc, thuộc huyện vùng cao của tỉnh Lào Cai. Là vùng đất được thiên nhiên ưu đãi cho núi rừng hùng vĩ, bí ẩn bởi toàn đồi núi được e nấp trong làn sương trắng mờ. Không khí cực kỳ mát mẻ, trong lành tinh khiết. Nếu đến Sapa trong mùa hoa mơ nở trắng xóa bạn phải ngỡ ngàng như đang lạc vào thiên đường.',
            'kinh_Do', //22°21'26.8"N
            'vi_Do',// 103°49'07.2"E
            'hot'=>"Ruốt Cá Hồi, Thắng Cố Sapa",
            'status'[1],
            'created_at' => date("Y-m-d H:i:s"),
            'updated_at' => date("Y-m-d H:i:s"),
            'deleted_at' => date("Y-m-d H:i:s"),
        ]);
        DB::table('dia_danhs')->insert([
                
            'loai_dia_danh_id'[1],
            'mien_id'[1],
            'phan_vung_id',
            'ten_dia_danh' => 'Phan Thiết',
            'ten_Goi_Khac' => 'Thành Phố Phan Thiết',
            'mo_Ta'=>'Nhắc đến Phan Thiết – Mũi Né, người ta sẽ nghĩ ngay đến hình ảnh một miền nắng gió vàng ươm thơ mộng, những bãi biển dài xanh ngút mắt, cát trắng miên man tựa hồ như một “bài thơ đẹp” của thiên nhiên, dễ dàng chinh phục bất cứ ai đã từng ghé đến. Bạn còn chần chừ gì mà không ghé đến một trong những bãi biển đẹp nhất Việt Nam, ở đây còn có khu nghỉ dưỡng cao cấp, thích hợp cho gia đình bạn đi nghỉ dưỡng',
            'kinh_Do', //10°55'58.1"N
            'vi_Do',// 108°07'54.0"E
            'hot'=>"Bánh canh chả cá, Mỳ quảng Phan Thiết",
            'status'[1],
            'created_at' => date("Y-m-d H:i:s"),
            'updated_at' => date("Y-m-d H:i:s"),
            'deleted_at' => date("Y-m-d H:i:s"),
        ]);
        DB::table('dia_danhs')->insert([
                
            'loai_dia_danh_id'[3],
            'mien_id'[1],
            'phan_vung_id',
            'ten_dia_danh' => 'Vịnh Hạ Long',
            'ten_Goi_Khac' => 'Ha Long Bay',
            'mo_Ta'=>'Vịnh Hạ Long là địa điểm có thể nói là nổi tiếng nhất Việt Nam, bởi nó được công nhận là di sản văn hóa thế giới, bỏi nó là tác phẩm nghệ thuật tạo hình kỳ lạ của tạo hóa, không khỏi khiến du khách thích thú nhưng cũng đầy bối rối. Đến với Hạ Long giúp bạn sẽ cảm nhận được những tác phẩm tạo hình tuyệt mỹ, tài hoa của tạo hoá, của thiên nhiên biến hàng ngàn đảo đá vô tri tĩnh lặng kia trở nên những tác phẩm điêu khắc.',
            'kinh_Do', //20°54'36.4"N
            'vi_Do',// 107°11'02.1"E
            'hot'=>"Chả mực Hạ Long, Bún Xào Ngán, Bánh Gật Gù",
            'status'[1],
            'created_at' => date("Y-m-d H:i:s"),
            'updated_at' => date("Y-m-d H:i:s"),
            'deleted_at' => date("Y-m-d H:i:s"),
        ]);
        DB::table('dia_danhs')->insert([
                
            'loai_dia_danh_id'[3],
            'mien_id'[3],
            'phan_vung_id',
            'ten_dia_danh' => 'Đảo Phú Quốc',
            'ten_Goi_Khac' => 'Phú Quốc',
            'mo_Ta'=>'Đảo Phú Quốc được biết đến là một địa điểm du lịch ở Kiên Giang được nhiều du khách trong và ngoài nước tìm đến nhiều nhất khi họ đến du lịch Kiên Giang. Với lợi thế về thời tiết cũng như dòng nước biển trong xanh, nhiều món ăn phong phú.',
            'kinh_Do', //10°18'14.9"N
            'vi_Do',// 103°58'55.7"E
            'hot'=>"Ghẹ Hàm Ninh, Bánh canh ghẹ Phú Quốc, Bánh khéo, …",
            'status'[1],
            'created_at' => date("Y-m-d H:i:s"),
            'updated_at' => date("Y-m-d H:i:s"),
            'deleted_at' => date("Y-m-d H:i:s"),
        ]);
        DB::table('dia_danhs')->insert([
                
            'loai_dia_danh_id'[3],
            'mien_id'[3],
            'phan_vung_id',
            'ten_dia_danh' => 'Rừng Tràm Trà Sư',
            'ten_Goi_Khac' => 'Rừng Trà Sư',
            'mo_Ta'=>'Rừng tràm Trà Sư là một khu rừng và khu du lịch sinh thái nằm trên địa bàn xã Văn Giáo, huyện Tịnh Biên, tỉnh An Giang. Đây là rừng ngập nước tiêu biểu cho vùng Tây sông Hậu, là nơi sinh sống của nhiều loài động vật và thực vật thuộc hệ thống rừng đặc dụng Việt Nam.',
            'kinh_Do', //10°34'22.4"N
            'vi_Do',// 105°02'44.7"E
            'hot'=>"Bánh bò thốt nốt, Gà đốt lá trúc",
            'status'[1],
            'created_at' => date("Y-m-d H:i:s"),
            'updated_at' => date("Y-m-d H:i:s"),
            'deleted_at' => date("Y-m-d H:i:s"),
        ]);
        DB::table('dia_danhs')->insert([
                
            'loai_dia_danh_id'[3],
            'mien_id'[3],
            'phan_vung_id',
            'ten_dia_danh' => 'Núi Cấm',
            'ten_Goi_Khac' => 'Cấm Sơn',
            'mo_Ta'=>'Núi Cấm nơi du lịch nổi tiếng của tỉnh An Giang, vì núi có dáng vẻ hùng vĩ, khí hậu mát mẻ, phong cảnh đẹp và cây cối luôn xanh tươi. Trên núi có các danh lam và danh thắng như: Chùa Vạn Linh, chùa Phật Lớn, tượng Phật Di Lặc, hồ Thủy Liêm, v.v...',
            'kinh_Do', //10°30'02.7"N
            'vi_Do',// 104°59'29.3"E
            'hot'=>"Bánh phồng Phú Mỹ, Mắm Châu Đốc, Đường thốt nốt, Trái thốt nốt.....",
            'status'[1],
            'created_at' => date("Y-m-d H:i:s"),
            'updated_at' => date("Y-m-d H:i:s"),
            'deleted_at' => date("Y-m-d H:i:s"),
        ]);
        


    }
}
