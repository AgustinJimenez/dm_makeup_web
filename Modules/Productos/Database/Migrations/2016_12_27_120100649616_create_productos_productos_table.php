<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProductosProductosTable extends Migration
{
	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('productos__productos', function(Blueprint $table) {
			$table->engine = 'InnoDB';
            $table->increments('id');
            $table->string('nombre');
            $table->string('codigo')->nullable();
            $table->bigInteger('precio_compra');
            $table->double('precio_compra_promedio', 25, 5);
            $table->bigInteger('precio_venta');
            $table->date('fecha_compra');
            $table->double('stock', 25, 5);
            $table->double('stock_minimo', 25, 5);
            $table->boolean('activo');
            $table->string('archivo');
            $table->string('mime');
            $table->integer('categoria_id')->unsigned()->index();
            $table->foreign('categoria_id')->references('id')->on('productos__categoriaproductos');
            $table->integer('marca_id')->unsigned()->index();
            $table->foreign('marca_id')->references('id')->on('productos__marcas');
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
		Schema::drop('productos__productos');
	}
}
//2016_12_27_110100143769_
