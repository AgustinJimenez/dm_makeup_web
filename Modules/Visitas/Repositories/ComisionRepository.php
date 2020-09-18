<?php namespace Modules\Visitas\Repositories;

class ComisionRepository
{ 
	public function lista_usuarios()
	{
		return \User::select('id', "first_name", "last_name")->orderBy("last_name", "ASC")->get()->lists("last_name_first_name", "id")->all();
	}

	public function ventas_filtradas( $re = [] )
	{
		$ventas_query = \Venta::where('anulado', 0)
        ->whereNotNull('visita_id')
        ->where("estado", "terminado")
        ->whereHas('visita', function( $visita_query ) use ($re)
        {
            if( isset($re['user_id']) and $re['user_id'] != '' )
                $visita_query->where("user_id", $re['user_id']);
        })
        ->with
        ([
            "cliente" => function( $cliente_query )
            {
                $cliente_query->select( 'id', 'razon_social' );
            },
            "visita" => function( $visita_query )
            {
                $visita_query->select( 'id', 'lugar' );
            }
        ])
        ->select("id", "tipo", "estado", "anulado", "cliente_id", "fecha_venta", "monto_total", "visita_id", "comision_pagada" );

        if( isset($re['fecha_desde']) and $re['fecha_desde'] != '' )
            $ventas_query->where("fecha_venta", '>=',  \Carbon::createFromFormat("d/m/Y", $re['fecha_desde'])->format("Y-m-d") );
        if( isset($re['fecha_hasta']) and $re['fecha_hasta'] != '' )
            $ventas_query->where("fecha_venta", '<=',  \Carbon::createFromFormat("d/m/Y", $re['fecha_hasta'])->format("Y-m-d") );
        if( isset($re['estado']) and $re['estado'] != '' )
            $ventas_query->where("comision_pagada", $re['estado']);

        return $ventas_query;
	}





















}