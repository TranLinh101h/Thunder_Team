<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDeXuatsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('de_xuats', function (Blueprint $table) { // Man update
            $table->id();
            $table->integer('loai_dia_danh_id');
            $table->unsignedBigInteger('user_id');
            $table->string('ten_Diem');
            $table->string('ten_Goi_Khac')->nullable(); 
            $table->longtext('mo_Ta')->nullable();
            $table->string('kinh_Do');
            $table->string('vi_Do');
            $table->string('img')->nullable();
            $table->integer('status')->default('1');  
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
        Schema::dropIfExists('de_xuats');
    }
}
