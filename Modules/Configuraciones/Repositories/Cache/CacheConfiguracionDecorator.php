<?php namespace Modules\Configuraciones\Repositories\Cache;

use Modules\Configuraciones\Repositories\ConfiguracionRepository;
use Modules\Core\Repositories\Cache\BaseCacheDecorator;

class CacheConfiguracionDecorator extends BaseCacheDecorator implements ConfiguracionRepository
{
    public function __construct(ConfiguracionRepository $configuracion)
    {
        parent::__construct();
        $this->entityName = 'configuraciones.configuracions';
        $this->repository = $configuracion;
    }
}
