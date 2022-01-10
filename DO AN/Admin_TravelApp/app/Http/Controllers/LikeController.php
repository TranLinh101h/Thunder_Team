<?php

namespace App\Http\Controllers;

use App\Models\Like;
use App\Models\Dislike;
use App\Http\Requests\StoreLikeRequest;
use App\Http\Requests\UpdateLikeRequest;
use App\Models\User;
use App\Models\BaiViet;

class LikeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function likeOrUnlike($id)
    {
        $post= BaiViet::find($id);

        $like= $post->likes()->where('user_id', auth()->user()->id)->first();
        $dislike= $post->dislikes()->where('user_id', auth()->user()->id)->first();

        //if not liked then liked
        if(!$like)
        {
            Like::create([
                'bai_viet_id' =>$id,
                'user_id' => auth()->user()->id
            ]);

            if($dislike){
                $dislike->delete();
            }

            return response([
                'message'=> 'Liked'
            ], 200);

            
        }
        
        //else dislike
        $like->delete();
        return response([
                'message'=> 'UnLiked'
            ], 200);
    }

     public function checkedlike($id)
    {
        $post= BaiViet::find($id);

        $like= $post->likes()->where('user_id', auth()->user()->id)->first();

        //if not liked then liked
        if(!$like)
        {
            return response([
                'message'=> 'falselike'
            ], 200);
        }

            return response([
                'message'=> 'truelike'
            ], 201);
    }

    public function checkeddislike($id)
    {
        $post= BaiViet::find($id);

        $dislike= $post->dislikes()->where('user_id', auth()->user()->id)->first();

        if($dislike)
        {
            return response([
                'message'=> 'truedislike'
            ], 202);
        }
        //else dislike
        return response([
                'message'=> 'falsedislike'
            ], 203);
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
     * @param  \App\Http\Requests\StoreLikeRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreLikeRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Like  $like
     * @return \Illuminate\Http\Response
     */
    public function show(Like $like)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Like  $like
     * @return \Illuminate\Http\Response
     */
    public function edit(Like $like)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateLikeRequest  $request
     * @param  \App\Models\Like  $like
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateLikeRequest $request, Like $like)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Like  $like
     * @return \Illuminate\Http\Response
     */
    public function destroy(Like $like)
    {
        //
    }
}
