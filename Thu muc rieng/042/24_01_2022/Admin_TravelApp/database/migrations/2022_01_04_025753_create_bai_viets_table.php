<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBaiVietsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bai_viets', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->softDeletes();
             $table->unsignedBigInteger('user_id');
             $table->unsignedBigInteger('dia_danh_id')->nullable();
             $table->text('noi_Dung');
             $table->boolean('checked')->nullable()->default(0); // 06/01/2022 : 20:21:03 | update: add default(0)
             $table->integer('status')->nullable()->default(1);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('bai_viets');
    }
}
