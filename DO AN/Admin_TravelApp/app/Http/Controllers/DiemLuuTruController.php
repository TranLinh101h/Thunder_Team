<?php

namespace App\Http\Controllers;

use App\Models\DiemLuuTru;
use App\Http\Requests\StoreDiemLuuTruRequest;
use App\Http\Requests\UpdateDiemLuuTruRequest;
use Illuminate\Http\Request;

class DiemLuuTruController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
   
 public function index(Request $request)
    {
         $attrs= $request->validate([
            'dia_danh_id'=> 'required',
        ]);

        return response([
            'diemluutru'=> DiemLuuTru::where('dia_danh_id', '=', $attrs['dia_danh_id'])->get()
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
     * @param  \App\Http\Requests\StoreDiemLuuTruRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreDiemLuuTruRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\DiemLuuTru  $diemLuuTru
     * @return \Illuminate\Http\Response
     */
    public function show(DiemLuuTru $diemLuuTru)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\DiemLuuTru  $diemLuuTru
     * @return \Illuminate\Http\Response
     */
    public function edit(DiemLuuTru $diemLuuTru)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateDiemLuuTruRequest  $request
     * @param  \App\Models\DiemLuuTru  $diemLuuTru
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateDiemLuuTruRequest $request, DiemLuuTru $diemLuuTru)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\DiemLuuTru  $diemLuuTru
     * @return \Illuminate\Http\Response
     */
    public function destroy(DiemLuuTru $diemLuuTru)
    {
        //
    }
}
