<?php

namespace App\Http\Controllers;

use App\Models\DiaDanh;
use Illuminate\Http\Request; 
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
    //Lấy toàn bộ danh sách địa danh
    public function index()
    {
        return response([
            'diadanhs'=>DiaDanh::where('status','=', '1')->orderby('created_at', 'desc')
            ->withCount('baiviets')->with('hinhdiadiem')
            ->get(),
            'hinhdiadanh' =>HinhDiaDiem::get()],200);
    }

    //Lấy ds địa danh hot
    public function getDiaDanhHot()
    {
        return response([
            'diadanhs'=>DiaDanh::where('hot','=', '1')->orderby('created_at', 'desc')
            ->withCount('baiviets')->with('hinhdiadiem')
            ->get(),
           ],200);
    }
    //Lấy 1 địa danh theo id
    public function getDiaDanh(Request $request)
    {
        $attr= $request->validate(['dia_danh_id'=>'required']);
        
        return response([
            'diadanhs'=>DiaDanh::where('id','=', $attr['dia_danh_id'])->withCount('baiviets')->with('hinhdiadiem')
            ->get()],200);
    }
    //Lấy ds địa danh theo loại 5/2/20200
    public function getDDTheoMien(Request $request)
    {
        $attr= $request->validate(['mien_id'=>'required']);
        
        return response([
            'diadanhs'=>DiaDanh::where('mien_id','=', $attr['mien_id'])->withCount('baiviets')->with('hinhdiadiem')
            ->get()],200);
    }

    //8/2/2022 Tran Linh
    public function timKiem(Request $request)
    {
        $attr= $request->validate(['tenDiaDanh'=>'required']);
        
        return response([
            'diadanhs'=>DiaDanh::where('ten_dia_danh','LIKE', "%{$attr['tenDiaDanh']}%")->withCount('baiviets')->with('hinhdiadiem')->with('loaidiadanh')
            ->get()],200);
    }
    public function hinhdiadanh(Request $request)
    {
        $attr= $request->validate(['dia_danh_id'=>'required']);
        return response([
            'hinhdiadanh' =>HinhDiaDiem::where('dia_danh_id', $attr['dia_danh_id'])->get()],200);
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
