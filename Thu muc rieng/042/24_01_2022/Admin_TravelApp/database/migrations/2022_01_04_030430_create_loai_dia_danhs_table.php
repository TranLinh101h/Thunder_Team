<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateLoaiDiaDanhsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('loai_dia_danhs', function (Blueprint $table) { // Man update 
            $table->id();
            $table->string('ten_Loai');
            $table->integer('status')->default(1);
            $table->timestamps(); 
        });
        Schema::create('hinh_dia_diems', function (Blueprint $table) {
            $table->id();
            $table->string('img');
            $table->unsignedBigInteger('dia_danh_id');
            $table->unsignedBigInteger('diem_luu_tru_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('loai_dia_danhs');
    }
}
