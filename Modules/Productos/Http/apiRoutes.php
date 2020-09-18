<?php

use Illuminate\Routing\Router;
/** @var Router $router */

$router->group(['prefix' => 'v1/productos', 'middleware' => 'api'], function (Router $router) {
    # Login
    $router->get('search-by-code/{code}', ['uses' => 'ProductoApiController@searchByCode']);
    $router->get('search/{q}', ['uses' => 'ProductoApiController@search']);

});
