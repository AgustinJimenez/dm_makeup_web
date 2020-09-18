<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProductosAltabajaProductosTable extends Migration
{
	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('productos__altabajaproductos', function(Blueprint $table) {
			$table->engine = 'InnoDB';
            $table->increments('id');
            $table->enum('operacion', ['alta', 'baja']);
            $table->string('descripcion');
						$table->double('cantidad', 25, 5);

            $table->date('fecha');

            $table->integer('producto_id')->unsigned()->index();
            $table->foreign('producto_id')->references('id')->on('productos__productos');

            $table->integer('usuario_sistema_id')->unsigned()->index();
            $table->foreign('usuario_sistema_id')->references('id')->on('users');
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
		Schema::drop('productos__altabajaproductos');
	}
}
