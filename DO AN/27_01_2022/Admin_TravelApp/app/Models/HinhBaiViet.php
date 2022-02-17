<?php

namespace App\Models;
// Đây là hình bài viết ! lưu ý

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HinhBaiViet extends Model
{
    use HasFactory;

    protected $fillable = [
        'bai_viet_id' ,
        'img'
    ];
}
