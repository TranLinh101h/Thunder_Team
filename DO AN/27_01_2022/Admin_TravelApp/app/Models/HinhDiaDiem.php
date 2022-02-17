<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HinhDiaDiem extends Model
{
    use HasFactory;

     protected $fillable = [
        'dia_danh_id',
        'diem_luu_tru_id',
        'img'
    ];
}
