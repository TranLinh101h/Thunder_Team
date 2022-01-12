<?php

namespace App\Http\Controllers;

use App\Models\DiaDanh;
use App\Http\Requests\StoreDiaDanhRequest;
use App\Http\Requests\UpdateDiaDanhRequest;
use App\Models\LoaiDiaDanh;
use App\Models\Mien; 
use App\Models\PhanVung;
use App\Models\HinhDiaDiem;


class DiaDanhController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return response([
            'diadanhs'=>DiaDanh::where('status','=', '1')->orderby('created_at', 'desc')->withCount('baiviets')
            ->get(),
            'hinhdiadanh' =>HinhDiaDiem::get()],200);
    }
    public function hinh()
    {
        return response([
            'hinhdiadanh' =>HinhDiaDiem::get()],200);
    }

        public function getNameDiaDanh() // Man create-07/01/2022 : 20:10:57 | Dùng để lấy ds đổ trong phần Địa của tạo bài viết
    {
        return response([
            'namediadanhs'=>DiaDanh::all('id','ten_dia_danh')
        ],200);
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
     * @param  \App\Http\Requests\StoreDiaDanhRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreDiaDanhRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\DiaDanh  $diaDanh
     * @return \Illuminate\Http\Response
     */
    public function show(DiaDanh $diaDanh)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\DiaDanh  $diaDanh
     * @return \Illuminate\Http\Response
     */
    public function edit(DiaDanh $diaDanh)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateDiaDanhRequest  $request
     * @param  \App\Models\DiaDanh  $diaDanh
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateDiaDanhRequest $request, DiaDanh $diaDanh)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\DiaDanh  $diaDanh
     * @return \Illuminate\Http\Response
     */
    public function destroy(DiaDanh $diaDanh)
    {
        //
    }
}
