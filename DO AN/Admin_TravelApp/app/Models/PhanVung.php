<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PhanVung extends Model
{
    use HasFactory;

    protected $fillable = [
        'ten_Vung'];

    public function diadanhs(){
        return $this->hasMany(DiaDanh::class);
    }
}
