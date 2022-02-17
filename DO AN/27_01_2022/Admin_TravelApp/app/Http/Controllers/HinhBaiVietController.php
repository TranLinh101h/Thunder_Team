<?php

namespace App\Http\Controllers;

use App\Models\HinhBaiViet;
use Illuminate\Http\Request; // Man update 07/01/2022 :12:20:46 | su dung de nhan request tu client 
use Illuminate\Support\Facades\Auth; // Man update 07/01/2022 :12:20:46 | | su dung nhung chuc nang lien quan acount
use App\Http\Requests\StoreHinhBaiVietRequest;
use App\Http\Requests\UpdateHinhBaiVietRequest;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage; // Man create
use Illuminate\Http\File; // man create
 
class HinhBaiVietController extends Controller
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
     * @param  \App\Http\Requests\StoreHinhBaiVietRequest  $request
     * @return \Illuminate\Http\Response
     */


    public function store(Request $request)  // Man create 08/01/2022
    {                                            
        $img = $this->saveImage($request->img, 'hinh_bai_viets'); // method saveImage khai báo bên controller dùng để decoded cái base 64 về lại ảnh để lưu ảnh trên server
                                
        $hinhAnh = HinhBaiViet::create([
            'bai_viet_id' => $request->bai_viet_id,
            'img' =>  $img
        ]);

        return response([
            'message' => 'img them thanh cong',
            'hinhAnh' => $hinhAnh
        ], 200);
    }


    /**
     * Display the specified resource.
     *
     * @param  \App\Models\HinhBaiViet  $hinhBaiViet
     * @return \Illuminate\Http\Response
     */
    public function show(HinhBaiViet $hinhBaiViet)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\HinhBaiViet  $hinhBaiViet
     * @return \Illuminate\Http\Response
     */
    public function edit(HinhBaiViet $hinhBaiViet)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateHinhBaiVietRequest  $request
     * @param  \App\Models\HinhBaiViet  $hinhBaiViet
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateHinhBaiVietRequest $request, HinhBaiViet $hinhBaiViet)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\HinhBaiViet  $hinhBaiViet
     * @return \Illuminate\Http\Response
     */
    public function destroy(HinhBaiViet $hinhBaiViet)
    {
        //
    }
}
