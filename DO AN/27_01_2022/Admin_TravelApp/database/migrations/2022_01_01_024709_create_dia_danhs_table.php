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
            $table->unsignedBigInteger('loai_dia_danh_id')->nullable();
            $table->unsignedBigInteger('mien_id')->nullable();
            $table->unsignedBigInteger('phan_vung_id')->nullable();
            $table->string('ten_dia_danh')->nullable();
            $table->string('ten_Goi_Khac')->nullable();
            $table->longtext('mo_Ta');
            $table->string('kinh_Do')->default(1);
            $table->string('vi_Do')->default(1);
            $table->boolean('hot')->default(0);
            $table->integer('status')->default(1);
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
