<?php

namespace App\Http\Controllers;

use App\Models\DeXuat;
use Illuminate\Http\Request; // Man update 07/01/2022 :12:20:46 | su dung de nhan request tu client 
use Illuminate\Support\Facades\Auth; // Man update 07/01/2022 :12:20:46 
use App\Http\Requests\StoreDeXuatRequest;
use App\Http\Requests\UpdateDeXuatRequest;
use App\Http\Controllers\Controller; // Man update 07/01/2022 :12:20:46 
use Illuminate\Support\Facades\Storage; // Man create
use Illuminate\Http\File; // man create

class DeXuatController extends Controller
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
     * @param  \App\Http\Requests\StoreDeXuatRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {                                          // Path luu trong file system
        $img = $this->saveImage($request->img, 'hinh_dia_diems');

        $deXuat = DeXuat::create([
            'loai_dia_danh_id' =>$request->loai_dia_danh_id,
            'user_id' =>auth()->user()->id,
            'ten_Diem' =>$request->ten_Diem, 
            'ten_Goi_Khac' =>$request->ten_Goi_Khac,
            'mo_Ta' =>$request->mo_Ta,
            'kinh_Do' =>$request->kinh_Do,
            'vi_Do' =>$request->vi_Do,
            'img' => $img
        ]);

        return response([
            'message' => 'Đề xuất thành công',
            'deXuat' => $deXuat
        ], 200);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\DeXuat  $deXuat
     * @return \Illuminate\Http\Response
     */
    public function show(DeXuat $deXuat)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\DeXuat  $deXuat
     * @return \Illuminate\Http\Response
     */
    public function edit(DeXuat $deXuat)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateDeXuatRequest  $request
     * @param  \App\Models\DeXuat  $deXuat
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateDeXuatRequest $request, DeXuat $deXuat)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\DeXuat  $deXuat
     * @return \Illuminate\Http\Response
     */
    public function destroy(DeXuat $deXuat)
    {
        //
    }
}
