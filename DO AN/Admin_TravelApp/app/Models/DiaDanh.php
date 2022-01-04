<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\LoaiDiaDanh;
use App\Models\Mien;
use App\Models\PhanVung;
use App\Models\BaiViet;

class DiaDanh extends Model
{
    use HasFactory;

    protected $fillable = [
        'ten_dd',
        'loai_dia_danh_id',
        'mien_id',
        'phan_vung_id',
        'ten_Goi_Khac',
        'mo_Ta',
        'kinh_Do',
        'vi_Do',
        'hot',
    ];

    public function loaidiadanh(){
        return $this->belongsTo(DiaDanh::class);
    }

    public function baiviets(){
        return $this->hasMany(BaiViet::class);
    }

    public function miens(){
        return $this->belongsTo(Mien::class);
    }

    public function phanvung(){
        return $this->belongsTo(PhanVung::class);
    }
}
