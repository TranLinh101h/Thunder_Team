<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\BaiVietController;
use App\Http\Controllers\DiaDanhController;
use App\Http\Controllers\DiemLuuTruController;
use App\Http\Controllers\LikeController;
use App\Http\Controllers\DislikeController;
use App\Http\Controllers\ViewController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

//Tran Linh
Route::post('/register', [AuthController::class, 'register']);//rehister account
Route::post('/login', [AuthController::class, 'login']);//Login

Route::group(['middleware' =>['auth:sanctum']], function(){
    Route::get('/user', [AuthController::class, 'user']);// get info user
    Route::post('/logout', [AuthController::class, 'logout']);// Logout

    Route::get('/baiviet', [BaiVietController::class, 'index']);// get all bai_viet
    Route::get('/diadanh', [DiaDanhController::class, 'index']);// get all dia_danh
     Route::post('/diemluutru', [DiemLuuTruController::class, 'index']);// get all diem_luu_tru by dia_danh
    Route::get('/hinhdiadiem', [DiaDanhController::class, 'hinh']);// get image dia_diem

    //like
    Route::post('/posts/{id}/likes', [LikeController::class, 'likeOrUnlike']);
     Route::post('/posts/{id}/checkedlike', [LikeController::class, 'checkedlike']);
      Route::post('/posts/{id}/checkeddislike', [LikeController::class, 'checkeddislike']);
    Route::post('/posts/{id}/dislikes', [DislikeController::class, 'dislikeOrUnlike']);
    Route::post('/posts/{id}/views', [ViewController::class, 'view']);
});