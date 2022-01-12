<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DeXuat extends Model
{
    use HasFactory;

   protected $fillable = [
        'loai_dia_danh_id',
        'user_id',
        'ten_Diem',
        'ten_Goi_Khac',
        'mo_Ta',
        'kinh_Do',
        'vi_Do',
        'img',
    ];
}
