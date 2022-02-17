<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class ForeignKey extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        //
         Schema::table('dia_danhs', function (Blueprint $table) {
            $table->foreign('loai_dia_danh_id')->references('id')->on('loai_dia_danhs');
        });

        Schema::table('dia_danhs', function (Blueprint $table) {
            $table->foreign('phan_vung_id')->references('id')->on('phan_vungs');
        });

         Schema::table('dia_danhs', function (Blueprint $table) {
            $table->foreign('mien_id')->references('id')->on('miens');
        });

        //danh gia
        Schema::table('danh_gias', function (Blueprint $table) {
            $table->foreign('user_id')->references('id')->on('users');
        });

        Schema::table('danh_gias', function (Blueprint $table) {
            $table->foreign('dia_danh_id')->references('id')->on('dia_danhs');
        });
        //bai viet
        Schema::table('bai_viets', function (Blueprint $table) {
            $table->foreign('user_id')->references('id')->on('users');
        });

        Schema::table('bai_viets', function (Blueprint $table) {
            $table->foreign('dia_danh_id')->references('id')->on('dia_danhs');
        });
        //diem luu tru
        Schema::table('diem_luu_trus', function (Blueprint $table) {
            $table->foreign('loai_luu_tru_id')->references('id')->on('loai_luu_trus');
        });
        Schema::table('diem_luu_trus', function (Blueprint $table) {
            $table->foreign('dia_danh_id')->references('id')->on('dia_danhs');
        });
        //like, view, dislike
        Schema::table('likes', function (Blueprint $table) {
            $table->foreign('bai_viet_id')->references('id')->on('bai_viets');
        });
        Schema::table('likes', function (Blueprint $table) {
            $table->foreign('user_id')->references('id')->on('users');
        });
        //
        Schema::table('dislikes', function (Blueprint $table) {
            $table->foreign('bai_viet_id')->references('id')->on('bai_viets');
        });
        Schema::table('dislikes', function (Blueprint $table) {
            $table->foreign('user_id')->references('id')->on('users');
        });
        //
        Schema::table('views', function (Blueprint $table) {
            $table->foreign('bai_viet_id')->references('id')->on('bai_viets');
        });
        Schema::table('views', function (Blueprint $table) {
            $table->foreign('user_id')->references('id')->on('users');
        });
        //de xuat
        Schema::table('de_xuats', function (Blueprint $table) {
            $table->foreign('user_id')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
       
    }
}
