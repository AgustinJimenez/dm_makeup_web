<?php namespace Modules\Visitas\Repositories\Cache;

use Modules\Visitas\Repositories\StockRetiradoRepository;
use Modules\Core\Repositories\Cache\BaseCacheDecorator;

class CacheStockRetiradoDecorator extends BaseCacheDecorator implements StockRetiradoRepository
{
    public function __construct(StockRetiradoRepository $stockretirado)
    {
        parent::__construct();
        $this->entityName = 'visitas.stockretirados';
        $this->repository = $stockretirado;
    }
}
