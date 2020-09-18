<?php namespace Modules\Visitas\Repositories\Eloquent;

use Modules\Visitas\Repositories\ComisionRepository;
use Modules\Core\Repositories\Eloquent\EloquentBaseRepository;

class EloquentComisionRepository extends EloquentBaseRepository implements ComisionRepository
{

	public function here()
	{
		return "here";
	}
}