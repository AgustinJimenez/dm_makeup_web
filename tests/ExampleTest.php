<?php

use Route;

class ExampleTest extends TestCase {

	/**
	 * A basic functional test example.
	 *
	 * @return void
	 */
	public function testBasicExample()
	{
		$routeCollection = Route::getRoutes();

		foreach ($routeCollection as $value) {
		    echo $value->getPath();
		}

		$response = $this->call('GET', 'en/backend');

		$this->assertEquals(200, $response->getStatusCode());
	}

}
