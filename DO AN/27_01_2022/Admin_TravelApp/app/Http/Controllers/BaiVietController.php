<?php

namespace App\Http\Controllers;

use App\Models\BaiViet;
use Illuminate\Http\Request; // Man update 07/01/2022 :12:20:46 | su dung de nhan request tu client 
use Illuminate\Support\Facades\Auth; // Man update 07/01/2022 :12:20:46 | | su dung nhung chuc nang lien quan acount
use App\Http\Requests\StoreBaiVietRequest;
use App\Http\Requests\UpdateBaiVietRequest;
use App\Models\User;
use App\Models\DiaDanh;
use App\Models\Like;
use App\Models\Dislike;
use App\Models\View;
use App\Models\HinhBaiViet;

class BaiVietController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //Tran Linh Update 12/1/2022
        return response([
            'baiviets'=>BaiViet::where('status', '=', '1')->orderby('created_at', 'desc')->with('user:name,id,img')->with('hinhbaiviet')
            ->withCount('views', 'likes', 'dislikes')->with('likes', function($like){
                return $like->where('user_id', auth()->user()->id)->select('id', 'user_id', 'bai_viet_id')->get();
            })->with('dislikes', function($dislike){
                return $dislike->where('user_id', auth()->user()->id)->select('id', 'user_id', 'bai_viet_id')->get();
            })->get()],200);
    }

     public function baivietuser(Request $request)
    {
         $attrs= $request->validate([
            'user_id'=> 'required',
        ]);

        return response([
            'baiviets'=>BaiViet::where('user_id', $attrs['user_id'])->orderby('created_at', 'desc')->with('user:name,id,img')->with('hinhbaiviet')
            ->withCount('views', 'likes', 'dislikes')->with('likes', function($like){
                return $like->where('user_id', auth()->user()->id)->select('id', 'user_id', 'bai_viet_id')->get();
            })->with('dislikes', function($dislike){
                return $dislike->where('user_id', auth()->user()->id)->select('id', 'user_id', 'bai_viet_id')->get();
            })->get()],200);
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
     * @param  \App\Http\Requests\StoreBaiVietRequest  $request
     * @return \Illuminate\Http\Response
     */

    public function getId() // Man create 09/01/2022 | method này dùng để trả về cái Id mới nhất sau khi thêm bài viết lên serve
    {
        // return response([
        //     'idBaiViet' => BaiViet::all()->last()->id
        // ], 200);
        return response([
            'idBaiViet'=>BaiViet::all('id')->last(),
        ],200);
    }

    public function store(Request $request)
    {
        $baiViet = BaiViet::create([
            'user_id' => auth()->user()->id,
            'dia_danh_id' => $request->dia_danh_id,
            'noi_Dung'=> $request->noi_Dung
        ]);

        return response([
            'message' => 'Tao bai thanh cong',
            'baiViet' => $baiViet
        ], 200);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\BaiViet  $baiViet
     * @return \Illuminate\Http\Response
     */
    public function show(BaiViet $baiViet)
    {
        //$
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\BaiViet  $baiViet
     * @return \Illuminate\Http\Response
     */
    public function edit(BaiViet $baiViet)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateBaiVietRequest  $request
     * @param  \App\Models\BaiViet  $baiViet
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $baiViet = BaiViet::find($id);

        if(!$baiViet)
        {
            return response([
                'message' => 'Khong tim thay bai viet.'
            ], 403);
        }

        if($baiViet->user_id != auth()->user()->id)
        {
            return response([
                'message' => 'Permission denied.'
            ], 403);
        }

        $attrs = $request->validate([
            'noi_Dung'=> 'required|string'
        ]);

        $baiViet->update([
            'noi_Dung'=> $attrs['noi_Dung']
        ]);

        return response([
            'message' => 'Tao bai thanh cong',
            'baiViet' => $baiViet
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\BaiViet  $baiViet
     * @return \Illuminate\Http\Response
     */
    public function destroy(BaiViet $baiViet)
    {
        $baiViet = BaiViet::find($id);

        if(!$baiViet)
        {
            return response([
                'message' => 'Khong tim thay bai viet'
            ], 403);
        }

        if(!$baiViet->user_id != auth()->user()->id )
        {
            return response([
                'message' => 'Persision denied'
            ], 403);
        }

        $baiViet->delete();

        return response([
            'message' => 'Xoa bai viet',
            'baiViet' => $baiViet
        ], 200);
    }
}
