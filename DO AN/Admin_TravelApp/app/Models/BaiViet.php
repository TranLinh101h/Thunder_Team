<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
use App\Models\DiaDanh;
use App\Models\Like;
use App\Models\Dislike;
use App\Models\View;
use App\Models\HinhBaiViet;

class BaiViet extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'dia_danh_id','noi_Dung',
        'checked',
    ];

    public function user(){
        return $this->belongsTo(User::class);
    }

    public function diadanhs(){
        return $this->belongsTo(DiaDanh::class);
    }

    public function likes(){
        return $this->hasMany(Like::class);
    }

    public function dislikes(){
        return $this->hasMany(Dislike::class);
    }

     public function views(){
        return $this->hasMany(View::class);
    }

     public function hinhbaiviet(){
        return $this->hasMany(HinhBaiViet::class);
    }
}
