<?php namespace Modules\Visitas\Repositories\Cache;

use Modules\Visitas\Repositories\ComisionRepository;
use Modules\Core\Repositories\Cache\BaseCacheDecorator;

class CacheComisionDecorator extends BaseCacheDecorator implements ComisionRepository
{
    public function __construct(ComisionRepository $comision)
    {
        parent::__construct();
        $this->entityName = 'visitas.visitas';
        $this->repository = $comision;
    }
}