<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AdminController;

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

Route::get('/', [App\Http\Controllers\AdminController::class,'thongke']);
Route::get('/admin/thongke', [App\Http\Controllers\AdminController::class,'thongke']);
Route::get('/admin/dsdiadanh', [App\Http\Controllers\AdminController::class,'dsdiadanh']);
Route::get('/admin/taodiadanh', [App\Http\Controllers\AdminController::class,'taodiadanh']);
Route::get('/admin/nhucau', [App\Http\Controllers\AdminController::class,'nhucau']);
Route::get('/admin/dexuat', [App\Http\Controllers\AdminController::class,'dexuat']);
Route::get('/admin/taikhoan', [App\Http\Controllers\AdminController::class,'taikhoan']);
Route::get('/admin/errors', [App\Http\Controllers\AdminController::class,'errors']);
