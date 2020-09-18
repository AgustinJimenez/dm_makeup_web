<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateVentasVentasTable extends Migration
{
	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('ventas__ventas', function(Blueprint $table)
            {
			$table->engine = 'InnoDB';

                  $table->increments('id');

                  $table->enum('tipo', ['venta','preventa','otros']);

                  $table->enum('estado', ['preventa', 'terminado']);

                  $table->boolean('anulado');

                  $table->integer('usuario_sistema_id_create')->unsigned()->index();
                  $table->foreign('usuario_sistema_id_create')->references('id')->on('users');

                  $table->integer('usuario_sistema_id_edit')->unsigned()->index()->nullable();
                  $table->foreign('usuario_sistema_id_edit')->references('id')->on('users');

                  $table->integer('cliente_id')->unsigned()->index();
                  $table->foreign('cliente_id')->references('id')->on('clientes__clientes');

                  $table->integer('caja_id')->unsigned()->index();
                  $table->foreign('caja_id')->references('id')->on('caja_cajas');

                  $table->string('nro_seguimiento');

                  $table->date('fecha_venta');

			$table->date('fecha_entrega')->nullable();


/*OJO IZQ, OJO DER  Y DISTANCIA INTERPUPILAR PERTENECEN A VISION LEJANA*/

                  $table->bigInteger('monto_total');

                  $table->bigInteger('descuento_total')->nullable();

                  $table->string('monto_total_letras');

                  $table->bigInteger('gravado_excenta');

                  $table->bigInteger('gravado_5');

                  $table->bigInteger('gravado_10');

                  $table->bigInteger('total_iva_5');

                  $table->bigInteger('total_iva_10');

                  $table->bigInteger('total_iva');

                  $table->string('observacion_venta',1024);

                  $table->bigInteger('entrega')->nullable();

                  $table->bigInteger('pago_final')->nullable();

                  $table->bigInteger('total_pagado')->nullable();

                  $table->integer('descuento_porcentaje')->nullable();

                  $table->integer('visita_id')->unsigned()->index()->nullable();
                  $table->foreign('visita_id')->references('id')->on( (new \Visita)->getTable() );

                  $table->boolean('comision_pagada')->default(false);
                  //$table->integer('descuento_monto')->nullable();

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
		Schema::drop('ventas__ventas');
	}
}
