<?php

namespace App\Http\Controllers;

use App\Models\Mien;
use App\Http\Requests\StoreMienRequest;
use App\Http\Requests\UpdateMienRequest;

class MienController extends Controller
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
     * @param  \App\Http\Requests\StoreMienRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreMienRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Mien  $mien
     * @return \Illuminate\Http\Response
     */
    public function show(Mien $mien)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Mien  $mien
     * @return \Illuminate\Http\Response
     */
    public function edit(Mien $mien)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateMienRequest  $request
     * @param  \App\Models\Mien  $mien
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateMienRequest $request, Mien $mien)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Mien  $mien
     * @return \Illuminate\Http\Response
     */
    public function destroy(Mien $mien)
    {
        //
    }
}
