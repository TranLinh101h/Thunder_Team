<?php
// copy add het vo de add thieu no khong chay cung khong bao loi @@
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\BaiVietController;
use App\Http\Controllers\DiaDanhController;
use App\Http\Controllers\LoaiDiaDanhController;// Man add 09/01/2022
use App\Http\Controllers\DiemLuuTruController;
use App\Http\Controllers\HinhBaiVietController; // Man add 09/01/2022
use App\Http\Controllers\DeXuatController; // Man add 09/01/2022
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

Route::post('/register', [AuthController::class, 'register']);//rehister account
Route::post('/login', [AuthController::class, 'login']);//Login

Route::group(['middleware' =>['auth:sanctum']], function(){
    // User
    Route::get('/user', [AuthController::class, 'user']);
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::put('/user', [AuthController::class, 'update']); // Man update 07/01/2022 | update bai viet
    Route::put('/updatepass', [AuthController::class, 'updatePass']); // Man update 07/01/2022 | update bai viet
    Route::put('/hidenemail', [AuthController::class, 'hidenEmail']); // Man create 15/01/2022 | hiden profile
    Route::put('/hidensdt', [AuthController::class, 'hidenSDT']); // Man create 15/01/2022 | hiden profile


    //Post
    Route::get('/baiviet', [BaiVietController::class, 'index']);
    Route::post('/baivietuser', [BaiVietController::class, 'baivietuser']);
    Route::post('/baiviet', [BaiVietController::class, 'store']);// Man update 07/01/2022 | store bai viet
    Route::put('/baiviet/{id}', [BaiVietController::class, 'update']); // Man update 07/01/2022 | update bai viet
    Route::delete('/baiviet/{id}', [BaiVietController::class, 'destroy']); // Man update 07/01/2022 | Delate bai viet
    Route::post('/hinhbaiviet', [HinhBaiVietController::class, 'store']);// Man update 07/01/2022 | store bai viet
    Route::get('/idbaiviet', [BaiVietController::class, 'getId']); // Man create 09/01/2022 | Lấy ud bài viết mới nhất


    // Dia danh - Loai dia danh - De xuat
    Route::get('/diadanh', [DiaDanhController::class, 'index']);
    Route::get('/namediadanh', [DiaDanhController::class, 'getNameDiaDanh']); // Man update 07/01/2022 | Sử lý trong phần tạo bài viết android
    Route::get('/loaidiadanhid', [LoaiDiaDanhController::class, 'getloaidiadanh']); // Man update 07/01/2022 | Sử lý trong phần tạo bài viết android
    Route::post('/dexuat', [DeXuatController::class, 'store']);// Man update 07/01/2022 | store bai viet
    Route::post('/diemluutru', [DiemLuuTruController::class, 'index']);//Tran linh:  get all diem_luu_tru by dia_danh
    Route::get('/hinhdiadiem', [DiaDanhController::class, 'hinh']);//Tran Linh: get image dia_diem

    // Diem luu tru
     Route::post('/diemluutru', [DiemLuuTruController::class, 'index']);

     // Dia diem
    Route::get('/hinhdiadiem', [DiaDanhController::class, 'hinh']);

      //Tran Linh: like + dislike + view
      Route::post('/posts/{id}/likes', [LikeController::class, 'likeOrUnlike']);
      Route::post('/posts/{id}/checkedlike', [LikeController::class, 'checkedlike']);
      Route::post('/posts/{id}/checkeddislike', [LikeController::class, 'checkeddislike']);
      Route::post('/posts/{id}/dislikes', [DislikeController::class, 'dislikeOrUnlike']);
      Route::post('/posts/{id}/views', [ViewController::class, 'view']);
});