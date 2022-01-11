<?php

namespace App\Http\Controllers;

use App\Models\LoaiDiaDanh;
use Illuminate\Http\Request; // Man update 07/01/2022 :12:20:46 | su dung de nhan request tu client 
use Illuminate\Support\Facades\Auth; // Man update 07/01/2022 :12:20:46 | | su dung nhung chuc nang lien quan acount
use App\Http\Requests\StoreLoaiDiaDanhRequest;
use App\Http\Requests\UpdateLoaiDiaDanhRequest;

class LoaiDiaDanhController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \App\Http\Requests\StoreLoaiDiaDanhRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreLoaiDiaDanhRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\LoaiDiaDanh  $loaiDiaDanh
     * @return \Illuminate\Http\Response
     */
    public function show(LoaiDiaDanh $loaiDiaDanh)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\LoaiDiaDanh  $loaiDiaDanh
     * @return \Illuminate\Http\Response
     */
    public function edit(LoaiDiaDanh $loaiDiaDanh)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateLoaiDiaDanhRequest  $request
     * @param  \App\Models\LoaiDiaDanh  $loaiDiaDanh
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateLoaiDiaDanhRequest $request, LoaiDiaDanh $loaiDiaDanh)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\LoaiDiaDanh  $loaiDiaDanh
     * @return \Illuminate\Http\Response
     */
    public function destroy(LoaiDiaDanh $loaiDiaDanh)
    {
        //
    }

    public function getloaidiadanh() // Man create-07/01/2022 : 20:10:57 | Dùng để lấy ds đổ trong phần Địa của tạo bài viết
    {
        return response([
            'loaidiadanhs'=>LoaiDiaDanh::all('id','ten_Loai')
        ],200);
    }
}
