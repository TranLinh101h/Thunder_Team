<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\DiaDanhController;
use App\Http\Controllers\BaiVietController;
use App\Http\Controllers\DeXuatController;
use App\Http\Controllers\LoaiDiaDanhController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Route::get('/', [DiaDanhController::class, 'index']);
Route::get('/admin/thongke', [App\Http\Controllers\AdminController::class,'thongke']);
Route::get('/admin/dsdiadanh', [App\Http\Controllers\AdminController::class,'dsdiadanh']);
Route::get('/admin/taodiadanh', [App\Http\Controllers\AdminController::class,'taodiadanh']);
Route::get('/admin/nhucau', [App\Http\Controllers\AdminController::class,'nhucau']);
Route::get('/admin/dexuat', [App\Http\Controllers\AdminController::class,'dexuat']);
Route::get('/admin/taikhoan', [App\Http\Controllers\AdminController::class,'taikhoan']);
Route::get('/admin/errors', [App\Http\Controllers\AdminController::class,'errors']);

Route::resource('diaDanh', DiaDanhController::class);
Route::resource('deXuat', DeXuatController::class);
Route::resource('baiViet', BaiVietController::class);
Route::resource('loaiDiaDanh', LoaiDiaDanhController::class);
//Route::resource('user', DiaDanhController::class);
