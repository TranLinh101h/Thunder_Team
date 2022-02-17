<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AdminController extends Controller
{
    public function thongke(){
        return view('thong_ke');
    }

     public function dsdiadanh(){
        return view('dia_danh');
    }

    public function taodiadanh(){
        return view('tao_dia_danh');
    }

     public function nhucau(){
        return view('nhu_cau');
    }

     public function dexuat(){
        return view('de_xuat');
    }

     public function taikhoan(){
        return view('tai_khoan');
    }

     public function errors(){
        return view('error_page');
    }
}
