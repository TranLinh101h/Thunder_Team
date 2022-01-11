<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\Storage; // Man create
use Illuminate\Support\Facades\URL; // Man create
use Illuminate\Http\File;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    public function saveImage($img, $path= 'public')
    {
        if(!$img)
        {
            return null;
        }

        $fileName =  time().'.png';
        Storage::disk($path)->put($fileName, base64_decode(!$img) );

        return URL::to('/').'/storage/'.$path.'/'.$fileName;
    }    // Man update 07/01/2022 function SaveIMG
}
