<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class LoaiDiaDanhSeeder extends Seeder 

{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        

        DB::table('loai_dia_danhs')->insert([
                
            'ten_Loai' => 'Bãi Biển',
            'status'[1],
            'created_at' => date("Y-m-d H:i:s"),
            'updated_at' => date("Y-m-d H:i:s"),
        ]);
        DB::table('loai_dia_danhs')->insert([
                
            'ten_Loai' => 'Di Tích',
            'status'[1],
            'created_at' => date("Y-m-d H:i:s"),
            'updated_at' => date("Y-m-d H:i:s"),
        ]);
        DB::table('loai_dia_danhs')->insert([
                
            'ten_Loai' => 'Khu du lịch',
            'status'[1],
            'created_at' => date("Y-m-d H:i:s"),
            'updated_at' => date("Y-m-d H:i:s"),
        ]);
        
        
    }
}
