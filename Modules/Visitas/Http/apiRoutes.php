<?php

use Illuminate\Routing\Router;
/** @var Router $router */

$router->group(['prefix' => 'v1/visitas', 'middleware' => 'api'], function (Router $router) {
    # Login
    $router->get('search', ['uses' => 'VisitaApiController@search']);
    $router->get('search-activa/{visita_id}', ['uses' => 'VisitaApiController@searchActiva']);
    $router->get('index-productos/{visita_id}', ['uses' => 'VisitaApiController@indexProductos']);

});
