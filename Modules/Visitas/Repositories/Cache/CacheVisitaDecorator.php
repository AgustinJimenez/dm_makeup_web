<?php namespace Modules\Visitas\Repositories\Cache;

use Modules\Visitas\Repositories\VisitaRepository;
use Modules\Core\Repositories\Cache\BaseCacheDecorator;

class CacheVisitaDecorator extends BaseCacheDecorator implements VisitaRepository
{
    public function __construct(VisitaRepository $visita)
    {
        parent::__construct();
        $this->entityName = 'visitas.visitas';
        $this->repository = $visita;
    }
}
