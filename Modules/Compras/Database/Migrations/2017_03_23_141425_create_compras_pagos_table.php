<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateComprasPagosTable extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('compras_pagos', function(Blueprint $table)
        {
            $table->increments('id');

            $table->integer('compra_id')->unsigned()->index();
            $table->foreign('compra_id')->references('id')->on('compras__compras');

            $table->integer('caja_id')->unsigned()->index();
            $table->foreign('caja_id')->references('id')->on('caja_cajas');

            $table->date('fecha');

            $table->enum('forma_pago', ['efectivo', 'cheque', 'tarjeta_credito', 'tarjeta_debito']);

            $table->bigInteger('monto');

            $table->string('nro_recibo');
            $table->string('observacion');


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
        Schema::drop('compras__pagos');
    }

}
