<?php

use Illuminate\Routing\Router;
/** @var Router $router */

$router->group(['prefix' => 'v1/clientes', 'middleware' => 'api'], function (Router $router) {
    # Login
    $router->post('store', ['uses' => 'ClienteApiController@store']);
    $router->get('search/{q}', ['uses' => 'ClienteApiController@search']);

});
