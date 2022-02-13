<?php

namespace App\Http\Controllers;

use App\Models\DanhGia;
use App\Models\DiaDanh;

use Illuminate\Http\Request;
use App\Http\Requests\StoreDanhGiaRequest;
use App\Http\Requests\UpdateDanhGiaRequest;

class DanhGiaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function getDiemDanhGia(Request $request)
    {   
        $rq= $request->validate(['dia_danh_id' => 'required']);

        $lstDanhGia= DanhGia::where('dia_danh_id', '=', $rq['dia_danh_id'])->get();//Lấy ds đánh giá về địa danh
        $ratingUser= DanhGia::where('user_id', '=', auth()->user()->id)->where('dia_danh_id', '=', $rq['dia_danh_id'])->first();//kiểm tra ng dùng đã dánh giá địa danh trc đó chưa
//Tạo dữ liệu giả để trả về nếu ng dùng chưa đánh giá cho địa danh tránh lỗi
        if(!$ratingUser){
            $ratingUser= (['id'=>0, 'user_id'=> 0, 'dia_danh_id'=>0, 'danh_gia'=>0]);
        }

        //chưa có đánh giá nào cho địa danh thì trả về điểm đánh giá là 0
        if(count($lstDanhGia) == 0){
            return response(['rating'=>'0', 'danhgia'=>$ratingUser],200);
        }

        $rating=0;
        foreach($lstDanhGia as $danhgia){
            $rating += $danhgia->danh_gia;
        }
        $rating= $rating/ count($lstDanhGia);
        return response(['rating'=>round($rating,1), 'danhgia'=>$ratingUser],200);
    }
    public function DanhGiaOrUpdate(Request $request)
    {
        $rq= $request->validate(['dia_danh_id' => 'required', 'danh_gia'=> 'required']);

        $ratingUser= DanhGia::where('user_id', '=', auth()->user()->id)->where('dia_danh_id', '=', $rq['dia_danh_id'])->first();
        
        //Nếu chưa đánh giá cho địa danh thì tạo đánh giá
        if(!$ratingUser ){
            DanhGia::create([
                'user_id'=>auth()->user()->id,
                'dia_danh_id'=> $rq['dia_danh_id'],
                'danh_gia'=> $rq['danh_gia']
            ]);
        }
        //Nếu điểm đánh giá trùng với điểm đánh giá trước đó trả điểm đánh giá về 0
        if($ratingUser->danh_gia == $rq['danh_gia']){
            $ratingUser->update([
            'danh_gia'=> 0
            
        ]);
        }

        else{
        //Ngược lại cập nhật điểm đánh giá mới
        $ratingUser->update([
            'danh_gia'=> $rq['danh_gia']
        ]);
        }
        
         $lstDanhGia= DanhGia::where('dia_danh_id', '=', $rq['dia_danh_id'])->get();//Lấy ds đánh giá về địa danh
         $diaDanh= DiaDanh::where('id', $rq['dia_danh_id'])->first();
         $rating=0;
        foreach($lstDanhGia as $danhgia){
            $rating += $danhgia->danh_gia;
        }
        $rating= $rating/ count($lstDanhGia);

        if($rating >=4.5){
            $diaDanh->update([
                'hot'=>1
            ]);
        }
        else{
             $diaDanh->update([
                'hot'=>0
            ]);
        }
        return response(['message'=>'successed'],200);

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
     * @param  \App\Http\Requests\StoreDanhGiaRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreDanhGiaRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\DanhGia  $danhGia
     * @return \Illuminate\Http\Response
     */
    public function show(DanhGia $danhGia)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\DanhGia  $danhGia
     * @return \Illuminate\Http\Response
     */
    public function edit(DanhGia $danhGia)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateDanhGiaRequest  $request
     * @param  \App\Models\DanhGia  $danhGia
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateDanhGiaRequest $request, DanhGia $danhGia)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\DanhGia  $danhGia
     * @return \Illuminate\Http\Response
     */
    public function destroy(DanhGia $danhGia)
    {
        //
    }
}
