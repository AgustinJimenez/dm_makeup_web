<?php

use Illuminate\Routing\Router;
/** @var Router $router */

$router->group(['prefix' => 'v1/ventas', 'middleware' => 'api'], function (Router $router) {
    # Login
    $router->post('store', ['uses' => 'VentaApiController@store']);
    $router->get('descuento-config', ['uses' => 'VentaApiController@descuentoConfig']);
    $router->get('index-by-visita/{visita_id}', ['uses' => 'VentaApiController@indexByVisita']);
    $router->get('detalle/{venta_id}', ['uses' => 'VentaApiController@detalle']);

});
