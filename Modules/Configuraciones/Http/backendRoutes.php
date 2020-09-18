<?php

use Illuminate\Routing\Router;
/** @var Router $router */

$router->group(['prefix' =>'/configuraciones'], function (Router $router) {
    $router->bind('configuracion', function ($id) {
        return app('Modules\Configuraciones\Repositories\ConfiguracionRepository')->find($id);
    });
    $router->get('configuracions', [
        'as' => 'admin.configuraciones.configuracion.index',
        'uses' => 'ConfiguracionController@index',
        'middleware' => 'can:configuraciones.configuracions.index'
    ]);
    // $router->get('configuracions/create', [
    //     'as' => 'admin.configuraciones.configuracion.create',
    //     'uses' => 'ConfiguracionController@create',
    //     'middleware' => 'can:configuraciones.configuracions.create'
    // ]);
    // $router->post('configuracions', [
    //     'as' => 'admin.configuraciones.configuracion.store',
    //     'uses' => 'ConfiguracionController@store',
    //     'middleware' => 'can:configuraciones.configuracions.store'
    // ]);
    $router->get('configuracions/{configuracion}/edit', [
        'as' => 'admin.configuraciones.configuracion.edit',
        'uses' => 'ConfiguracionController@edit',
        'middleware' => 'can:configuraciones.configuracions.edit'
    ]);
    $router->put('configuracions/{configuracion}', [
        'as' => 'admin.configuraciones.configuracion.update',
        'uses' => 'ConfiguracionController@update',
        'middleware' => 'can:configuraciones.configuracions.update'
    ]);
    $router->delete('configuracions/{configuracion}', [
        'as' => 'admin.configuraciones.configuracion.destroy',
        'uses' => 'ConfiguracionController@destroy',
        'middleware' => 'can:configuraciones.configuracions.destroy'
    ]);
// append

});
