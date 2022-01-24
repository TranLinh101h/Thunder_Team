<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDislikesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('likes', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->unsignedBigInteger('bai_viet_id');
            $table->unsignedBigInteger('user_id');
        });

        Schema::create('disLikes', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->unsignedBigInteger('bai_viet_id');
            $table->unsignedBigInteger('user_id');
        });

        Schema::create('views', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->unsignedBigInteger('bai_viet_id');
            $table->unsignedBigInteger('user_id');
        });

        Schema::create('danh_gias', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('dia_danh_id');
            $table->unsignedBigInteger('user_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('dislikes');
    }
}
