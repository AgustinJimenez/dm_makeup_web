<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateConfiguracionesConfiguracionsTable extends Migration
{
	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('configuraciones__configuracions', function(Blueprint $table) {
			$table->engine = 'InnoDB';
            $table->increments('id');
						$table->string('identificador');
						$table->string('nombre');
						$table->string('valor');

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
		Schema::drop('configuraciones__configuracions');
	}
}
