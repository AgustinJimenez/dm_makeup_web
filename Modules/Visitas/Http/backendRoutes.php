<?php

use Illuminate\Routing\Router;
/** @var Router $router */

$router->group(['prefix' =>'/visitas'], function (Router $router)
{
    $router->bind('visita', function ($id) {
        return \Visita::find($id);
    });
    $router->get('visitas', [
        'as' => 'admin.visitas.visita.index',
        'uses' => 'VisitaController@index',
        'middleware' => 'can:visitas.visitas.index'
    ]);
    $router->get('visitas/{visita}/resumen',
    [
        'as' => 'admin.visitas.visita.resumen',
        'uses' => 'VisitaController@resumen',
        'middleware' => 'can:visitas.visitas.resumen'
    ]);
    $router->post('visitas/index_ajax', [
        'as' => 'admin.visitas.visita.index_ajax',
        'uses' => 'VisitaController@index_ajax',
        'middleware' => 'can:visitas.visitas.index_ajax'
    ]);

    $router->get('visitas/create', [
        'as' => 'admin.visitas.visita.create',
        'uses' => 'VisitaController@create',
        'middleware' => 'can:visitas.visitas.create'
    ]);


    //Inicio - Visitas-Productos Opcion 1
    $router->get('visitas/{visita}/agregar_productos',
    [
        'as' => 'admin.visitas.visita.agregar_productos',
        'uses' => 'VisitaController@agregar_productos',
        'middleware' => 'can:visitas.visitas.agregar_productos'
    ]);

    $router->post('visitas/visita_productos_ajax',
    [
        'as' => 'admin.visitas.visita.visita_productos_ajax',
        'uses' => 'VisitaController@visita_productos_ajax',
        'middleware' => 'can:visitas.visitas.visita_productos_ajax'
    ]);
    //Fin - Visitas-Productos Opcion 1

    //Inicio - Visitas-Productos Opcion 2
    $router->get('visitas/{visita}/index_productos',
    [
        'as' => 'admin.visitas.visita.index_productos',
        'uses' => 'VisitaController@index_productos',
        'middleware' => 'can:visitas.visitas.index_productos'
    ]);
    $router->post('visitas/{visita}/index_productos_ajax',
    [
      'as' => 'admin.visitas.visita.index_productos_ajax',
      'uses' => 'VisitaController@index_productos_ajax',
      'middleware' => 'can:visitas.visitas.index_productos_ajax'
    ]);

    $router->post('visitas/save_producto',
    [
      'as' => 'admin.visitas.visita.save-producto',
      'uses' => 'VisitaController@save_producto',
      'middleware' => 'can:visitas.visitas.save_producto'
    ]);

    $router->post('visitas/edit_producto',
    [
      'as' => 'admin.visitas.visita.edit-producto',
      'uses' => 'VisitaController@edit_producto',
      'middleware' => 'can:visitas.visitas.edit_producto'
    ]);

    $router->post('visitas/save_productos_filtrados',
    [
      'as' => 'admin.visitas.visita.save-productos-filtrados',
      'uses' => 'VisitaController@save_productos_filtrados',
      'middleware' => 'can:visitas.visitas.save_productos_filtrados'
    ]);

    //Fin - Visitas-Productos Opcion 2


    $router->post('visitas/visita_productos_ajax',
    [
        'as' => 'admin.visitas.visita.visita_productos_ajax',
        'uses' => 'VisitaController@visita_productos_ajax',
        'middleware' => 'can:visitas.visitas.visita_productos_ajax'
    ]);




    $router->post('visitas',
    [
        'as' => 'admin.visitas.visita.store',
        'uses' => 'VisitaController@store',
        'middleware' => 'can:visitas.visitas.store'
    ]);
    $router->get('visitas/{visita}/edit', [
        'as' => 'admin.visitas.visita.edit',
        'uses' => 'VisitaController@edit',
        'middleware' => 'can:visitas.visitas.edit'
    ]);

    $router->put('visitas/update_ajax/{visita}',
    [
        'as' => 'admin.visitas.visita.update_ajax',
        'uses' => 'VisitaController@update_ajax',
        'middleware' => 'can:visitas.visitas.update_ajax'
    ]);
    $router->put('visitas/{visita}', [
        'as' => 'admin.visitas.visita.update',
        'uses' => 'VisitaController@update',
        'middleware' => 'can:visitas.visitas.update'
    ]);
    $router->delete('visitas/{visita}', [
        'as' => 'admin.visitas.visita.destroy',
        'uses' => 'VisitaController@destroy',
        'middleware' => 'can:visitas.visitas.destroy'
    ]);
    $router->delete('visitas/destroy_ajax/{visita}', [
        'as' => 'admin.visitas.visita.destroy_ajax',
        'uses' => 'VisitaController@destroy_ajax',
        'middleware' => 'can:visitas.visitas.destroy_ajax'
    ]);


    $router->get('visitas/ventas/{visita}', [
        'as' => 'admin.visitas.visita.ventas',
        'uses' => 'VisitaController@ventas',
        'middleware' => 'can:visitas.visitas.ventas'
    ]);

    $router->post('visitas/ventas-index-ajax/', [
        'as' => 'admin.visitas.visita.ventas-index-ajax',
        'uses' => 'VisitaController@ventas_index_ajax',
        'middleware' => 'can:visitas.visitas.ventas_index_ajax'
    ]);


    $router->bind('stockretirado', function ($id)
    {
        return \StockRetirado::find($id);
    });
    $router->get('stockretirados', [
        'as' => 'admin.visitas.stockretirado.index',
        'uses' => 'StockRetiradoController@index',
        'middleware' => 'can:visitas.stockretirados.index'
    ]);
    $router->get('stockretirados/create', [
        'as' => 'admin.visitas.stockretirado.create',
        'uses' => 'StockRetiradoController@create',
        'middleware' => 'can:visitas.stockretirados.create'
    ]);
    $router->post('stockretirados', [
        'as' => 'admin.visitas.stockretirado.store',
        'uses' => 'StockRetiradoController@store',
        'middleware' => 'can:visitas.stockretirados.store'
    ]);
    $router->get('stockretirados/{stockretirado}/edit', [
        'as' => 'admin.visitas.stockretirado.edit',
        'uses' => 'StockRetiradoController@edit',
        'middleware' => 'can:visitas.stockretirados.edit'
    ]);
    $router->put('stockretirados/{stockretirado}', [
        'as' => 'admin.visitas.stockretirado.update',
        'uses' => 'StockRetiradoController@update',
        'middleware' => 'can:visitas.stockretirados.update'
    ]);
    $router->delete('stockretirados/{stockretirado}',
    [
        'as' => 'admin.visitas.stockretirado.destroy',
        'uses' => 'StockRetiradoController@destroy',
        'middleware' => 'can:visitas.stockretirados.destroy'
    ]);
    $router->delete('stockretirados/destroy_ajax/{stockretirado}',
    [
        'as' => 'admin.visitas.stockretirado.destroy_ajax',
        'uses' => 'StockRetiradoController@destroy_ajax',
        'middleware' => 'can:visitas.stockretirados.destroy_ajax'
    ]);
// append

    $router->get('/comisiones',
    [
        'as' => 'admin.visitas.comisiones.index',
        'uses' => 'ComisionController@index',
        'middleware' => 'can:visitas.comisiones.index'
    ]);
    $router->post('/comisiones/index_ajax',
    [
        'as' => 'admin.visitas.comisiones.index_ajax',
        'uses' => 'ComisionController@index_ajax',
        'middleware' => 'can:visitas.comisiones.index_ajax'
    ]);

    $router->post('/comisiones/marcar_comisiones',
    [
        'as' => 'admin.visitas.comisiones.marcar_comisiones',
        'uses' => 'ComisionController@marcar_comisiones',
        'middleware' => 'can:visitas.comisiones.marcar_comisiones'
    ]);

});
