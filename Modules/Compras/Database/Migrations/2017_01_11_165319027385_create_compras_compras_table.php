<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateComprasComprasTable extends Migration
{
	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('compras__compras', function(Blueprint $table) {
			$table->engine = 'InnoDB';
            $table->increments('id');
            $table->enum('tipo',['producto','cristal','servicio','otro']);
            $table->string('nro_factura');
            $table->string('timbrado');
            $table->boolean('anulado');


            $table->integer('proveedor_id')->unsigned()->index();
            $table->foreign('proveedor_id')->references('id')->on('proveedores__proveedors');

            $table->date('fecha');
            $table->enum('tipo_factura',['contado','credito']);
            $table->bigInteger('monto_total');
            $table->string('monto_total_letras');
            $table->bigInteger('gravado_excenta');
            $table->bigInteger('gravado_5');
            $table->bigInteger('gravado_10');
            $table->bigInteger('total_iva_5');
            $table->bigInteger('total_iva_10');
            $table->bigInteger('total_iva');
            $table->string('observacion');
            $table->bigInteger('total_pagado');
            $table->boolean('comprobante');
            $table->enum('moneda',['Guaranies','Dolares','Euros']);
            $table->string('cambio',10);


            $table->integer('usuario_sistema_id')->unsigned()->index();
            $table->foreign('usuario_sistema_id')->references('id')->on('users');

            $table->integer('usuario_sistema_id_edit')->unsigned()->index()->nullable();
            $table->foreign('usuario_sistema_id_edit')->references('id')->on('users');

            // Your fields
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
		Schema::drop('compras__compras');
	}
}
