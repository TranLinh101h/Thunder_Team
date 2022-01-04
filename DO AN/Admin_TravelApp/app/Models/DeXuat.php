<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DeXuat extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'ten_Diem',
        'mo_Ta',
        'img',
    ];
}
