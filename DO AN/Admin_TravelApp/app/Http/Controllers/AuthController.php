<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class AuthController extends Controller
{
    public function register(Request $request){
        $attrs= $request->validate([
            'name' => 'required|string',
            'sdt' => 'required|string',
            'email'=> 'required|email|unique:users,email',
            'password' => 'required|min:6|confirmed'

        ]);     

        //create
        $user= User::create([
            'name'=> $attrs['name'],
            'sdt'=> $attrs['sdt'],
            'email' => $attrs['email'],
            'password' => bcrypt($attrs['password'])
        ]);

        //return
        return response([
            'user' =>$user,
            'token'=>$user->createToken('secret')->plainTextToken
        ],200);
    }

    //login

    public function login(Request $request){
        $attrs= $request->validate([
            'email'=> 'required|email',
            'password' => 'required|min:6'
        ]);

        //attemp login
        if(!Auth::attempt($attrs)){
            return response([
                'messsage' => 'Cannot do it'
            ], 403);
        }
        //return
        return response([
            'user' =>auth()->user(),
            'token'=>auth()->user()->createToken('secret')->plainTextToken
        ],200);
    }

    //logout
    public function logout(){
        auth()->user()->tokens()->delete();
        return response([
            'message' =>'Logout success!'
        ],200);
    }
    //get user detail
    public function user(){
        return response([
            'user'=> auth()->user()
        ],200);
    } 
}
