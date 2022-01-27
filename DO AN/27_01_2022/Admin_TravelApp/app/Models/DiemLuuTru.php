<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DiemLuuTru extends Model
{
    use HasFactory;

    protected $fillable = [
        'loai_dia_danh_id',
        'dia_danh_id',
        'ten_Diem',
        'sdt',
        'mo_Ta',
        'kinh_Do',
        'vi_Do',
    ];
}
