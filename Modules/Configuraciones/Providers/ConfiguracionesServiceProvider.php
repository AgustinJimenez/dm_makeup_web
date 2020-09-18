<?php namespace Modules\Configuraciones\Providers;

use Illuminate\Support\ServiceProvider;

class ConfiguracionesServiceProvider extends ServiceProvider
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
            'Modules\Configuraciones\Repositories\ConfiguracionRepository',
            function () {
                $repository = new \Modules\Configuraciones\Repositories\Eloquent\EloquentConfiguracionRepository(new \Modules\Configuraciones\Entities\Configuracion());

                if (! config('app.cache')) {
                    return $repository;
                }

                return new \Modules\Configuraciones\Repositories\Cache\CacheConfiguracionDecorator($repository);
            }
        );
// add bindings

    }
}
