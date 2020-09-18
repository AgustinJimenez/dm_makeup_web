<?php namespace Modules\Visitas\Providers;

use Illuminate\Support\ServiceProvider;

class VisitasServiceProvider extends ServiceProvider
{
    /**
     * Indicates if loading of the provider is deferred.
     *
     * @var bool
     */
    protected $defer = false;

    /**
     * Register the service provider.
     *
     * @return void
     */
    public function register()
    {
        $this->registerBindings();
    }

    /**
     * Get the services provided by the provider.
     *
     * @return array
     */
    public function provides()
    {
        return array();
    }

    private function registerBindings()
    {
        $this->app->bind(
            'Modules\Visitas\Repositories\VisitaRepository',
            function () {
                $repository = new \Modules\Visitas\Repositories\Eloquent\EloquentVisitaRepository(new \Modules\Visitas\Entities\Visita());

                if (! config('app.cache')) {
                    return $repository;
                }

                return new \Modules\Visitas\Repositories\Cache\CacheVisitaDecorator($repository);
            }
        );
        $this->app->bind(
            'Modules\Visitas\Repositories\StockRetiradoRepository',
            function () {
                $repository = new \Modules\Visitas\Repositories\Eloquent\EloquentStockRetiradoRepository(new \Modules\Visitas\Entities\StockRetirado());

                if (! config('app.cache')) {
                    return $repository;
                }

                return new \Modules\Visitas\Repositories\Cache\CacheStockRetiradoDecorator($repository);
            }
        );
// add bindings


    }
}
