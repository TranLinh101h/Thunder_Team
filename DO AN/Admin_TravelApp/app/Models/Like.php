<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
use App\Models\BaiViet;

class Like extends Model
{
    use HasFactory;

     protected $fillable = [
        'user_id',
        'bai_viet_id',
    ];

    public function user(){
        return $this->belongsTo(User::class);
    }

    public function baiviet(){
        return $this->belongsTo(BaiViet::class);
    }
}
