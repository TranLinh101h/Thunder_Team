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

        Schema::create('hinh_bai_viets', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('bai_viet_id');
            $table->text('img'); // Man update 07/01/2022 : 12:30:47 | update: string ->text vi string sang mysql la nvarchar khong luu du base64 img
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
        Schema::dropIfExists('bai_viets');
    }
}
