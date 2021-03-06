<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateComprasFacturasTable extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('compras_facturas', function(Blueprint $table)
        {
            $table->increments('id');

            $table->integer('compra_id')->unsigned()->index()->nullable();
            $table->foreign('compra_id')->references('id')->on('compras__compras')->onDelete('cascade');

            $table->string('nro_factura');
            $table->date('fecha');
            $table->boolean('anulado');
            $table->enum('forma_pago', ['contado','credito']);

            $table->integer('usuario_sistema_id_create')->unsigned()->index();
            $table->foreign('usuario_sistema_id_create')->references('id')->on('users');

            $table->integer('usuario_sistema_id_edit')->unsigned()->index()->nullable();
            $table->foreign('usuario_sistema_id_edit')->references('id')->on('users');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('compras_facturas');
    }

}
