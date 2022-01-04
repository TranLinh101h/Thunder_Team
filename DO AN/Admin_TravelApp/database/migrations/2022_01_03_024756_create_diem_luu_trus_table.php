<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDiemLuuTrusTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('diem_luu_trus', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('loai_luu_tru_id');
            $table->unsignedBigInteger('dia_danh_id');
            $table->double('kinh_Do')>nullable();
            $table->double('vi_Do')>nullable();
            $table->string('ten_Diem');
            $table->string('sdt')>nullable();
            $table->text('mo_Ta');
            $table->integer('status');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('loai_luu_trus', function (Blueprint $table) {
            $table->id();
             $table->string('ten_Loai');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('diem_luu_trus');
    }
}
