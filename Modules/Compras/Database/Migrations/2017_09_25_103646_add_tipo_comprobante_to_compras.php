<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddTipoComprobanteToCompras extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('compras__compras', function(Blueprint $table)
        {
            $table->string('tipo_comprobante')->default('Factura');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('compras__compras', function(Blueprint $table)
        {
            $table->dropColumn('tipo_comprobante');
        });
    }

}
