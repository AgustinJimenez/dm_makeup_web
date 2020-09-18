<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateVisitasStockRetiradosTable extends Migration
{
	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('visitas__stocks_retirados', function(Blueprint $table) 
		{
			$table->engine = 'InnoDB';
            $table->increments('id');

            $table->integer('visita_id')->unsigned()->index();
            $table->foreign('visita_id')->references('id')->on('visitas__visitas');
            
            $table->integer('producto_id')->unsigned()->index();
            $table->foreign('producto_id')->references('id')->on('productos__productos');

            $table->double('cantidad', 25, 5)->default(0);

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
		Schema::drop('visitas__stocks_retirados');
	}
}
