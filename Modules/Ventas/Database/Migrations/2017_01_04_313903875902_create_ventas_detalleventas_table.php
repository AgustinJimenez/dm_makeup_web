<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateVentasDetalleVentasTable extends Migration
{
	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('ventas__detalleventas', function(Blueprint $table)
		{
			$table->engine = 'InnoDB';
            $table->increments('id');
            $table->integer('venta_id')->unsigned()->index();
            $table->foreign('venta_id')->references('id')->on('ventas__ventas')->onDelete('cascade');

            $table->integer('producto_id')->unsigned()->index()->nullable();
            $table->foreign('producto_id')->references('id')->on('productos__productos');

            $table->integer('servicio_id')->unsigned()->index()->nullable();
            $table->foreign('servicio_id')->references('id')->on('servicios__servicios');

            $table->string('descripcion')->nullable();

            $table->double('cantidad', 25, 5);

            $table->enum('iva',['11','21','0']);//[10,5,excenta]

            $table->bigInteger('precio_unitario');

            $table->double('costo_unitario', 12, 5);

            $table->bigInteger('precio_total');

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
		Schema::drop('ventas__detalleventas');
	}
}
