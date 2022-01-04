<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDiaDanhsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('dia_danhs', function (Blueprint $table) {
             $table->id();
            $table->string('dia_danh_id');
            $table->unsignedBigInteger('loai_dia_danh_id')->nullable();
            $table->unsignedBigInteger('mien_id')->nullable();
            $table->unsignedBigInteger('phan_vung_id')->nullable();
            $table->string('ten_Goi_Khac')->nullable();
            $table->longtext('mo_Ta');
            $table->double('kinh_Do')->nullable();
            $table->double('vi_Do')->nullable();
            $table->boolean('hot');
            $table->integer('status');
            $table->timestamps();
             $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('dia_danhs');
    }
}
