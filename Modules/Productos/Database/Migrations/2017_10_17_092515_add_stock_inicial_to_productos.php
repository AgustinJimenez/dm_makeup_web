<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddStockInicialToProductos extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('productos__productos', function(Blueprint $table)
        {
            $table->double('stock_inicial', 25, 5);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('productos__productos', function(Blueprint $table)
        {
          $table->dropColumn('stock_inicial');
        });
    }

}
