<?php namespace Modules\Visitas\Repositories\Eloquent;

use Modules\Visitas\Repositories\VisitaRepository;
use Modules\Core\Repositories\Eloquent\EloquentBaseRepository;

class EloquentVisitaRepository extends EloquentBaseRepository implements VisitaRepository
{
	public function users_lists($order = 'ASC')
	{
		return \User::select('id', "first_name", "last_name")->orderBy("last_name", $order)->get()->lists("last_name_first_name", "id");
	}

	public function resumen($visita)
	{
		$detalles_productos = collect([]);
		$productos = collect([]);

		foreach ($visita->ventas->where("anulado", 0) as $venta)
    		foreach ($venta->detalles->where("servicio_id",null) as $venta_detalle_producto)
    			$detalles_productos->push( $venta_detalle_producto );

					//dd($detalles_productos);

        foreach ($visita->stocks_retirados as $stock_retirado):
        	//dd( $detalles_productos->where( "producto_id", $stock_retirado->producto_id )->sum('cantidad') );
        	$cantidad_vendida = $detalles_productos->where( "producto_id", $stock_retirado->producto_id )->sum('cantidad');

            $productos[] =
            [
            	'producto_id' => $stock_retirado->producto_id,
                'producto' => "Nombre: {$stock_retirado->producto->nombre}, codigo: {$stock_retirado->producto->codigo}",
								'nombre' => $stock_retirado->producto->nombre,
								'retiradas' => $stock_retirado->cantidad,
                'vendidas' => $cantidad_vendida,
                'restantes' => $stock_retirado->cantidad - $cantidad_vendida
            ];
        endforeach;

				$productos_ordenados = $productos->sortBy('nombre');

				//dd($productos_ordenados);

        return $productos_ordenados;
	}

	public function visitas($re, $visita_fields = ['*'], $user_fields = ['*'])
	{
		$visitas_query = \Visita::where('estado', $re['estado'] )
					->whereHas('user', function( $user_query ) use ($re)
					{
						if($re['user_id'] != '')
							$user_query->where("id", $re['user_id']);
					})
					->with
					([
						"user" => function( $user_query ) use ($user_fields)
						{
							$user_query->select( $user_fields );
						}
					])
					->select( $visita_fields );

		if( isset($re['fecha']) and $re['fecha'] != '' )
			$visitas_query->where("fecha", \Carbon::createFromFormat('d/m/Y', $re['fecha'])->format("Y-m-d") );

		//dd( $visitas_query->get()->toArray() );

		return $visitas_query;
	}


	public function stocks_retirados( $visita_id, $stock_retirado_columns = ["*"], $producto_column = ["*"])
	{
		$stocks_retirados_query =  \StockRetirado::
		with
		([
			'producto' => function( $producto_query ) use ($producto_column)
			{
				$producto_query->select($producto_column );
			}
		])
		->where('visita_id', $visita_id)
		->select( (new \StockRetirado)->getTable().".*" );
		return $stocks_retirados_query;
	}

	public function create_stock_retirado( $re )
	{
		return \StockRetirado::create( $re );
	}

}
