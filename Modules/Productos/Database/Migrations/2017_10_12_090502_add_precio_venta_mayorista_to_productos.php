<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddPrecioVentaMayoristaToProductos extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('productos__productos', function(Blueprint $table)
        {
            $table->bigInteger('precio_venta_mayorista');
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
            $table->dropColumn('precio_venta_mayorista');
        });
    }

}
