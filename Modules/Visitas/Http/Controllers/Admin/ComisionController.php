<?php namespace Modules\Visitas\Http\Controllers\Admin;

use Laracasts\Flash\Flash;
use Illuminate\Http\Request;
use Modules\Core\Http\Controllers\Admin\AdminBaseController;
use Modules\Visitas\Repositories\ComisionRepository;

class ComisionController extends AdminBaseController
{
    private $comision;

    public function __construct(ComisionRepository $comision)
    {
        parent::__construct();

        $this->comision = $comision;
    }

    public function index()
    {
        return view('visitas::admin.comisiones.index', 
            array(
                "fecha_inicio_mes" => \Carbon::now()->startOfMonth()->format("d/m/Y"),
                "users_lists" => $this->comision->lista_usuarios()
                ));
    }

    public function index_ajax( Request $re )
    {
        $ventas_query = $this->comision->ventas_filtradas( $re );

        $object = \Datatables::of( $ventas_query )
        ->setRowClass(function () 
        {
            return "text-center";
        })
        ->editColumn('fecha_venta', function ($row) 
        {
            return $row->fecha_venta_format;
        })
        ->editColumn('visita.lugar', function ($row) 
        {
            return str_limit($row->visita->lugar, 40);
        })
        ->editColumn('cliente.razon_social', function ($row) 
        {
            return $row->cliente->razon_social;
        })
        ->editColumn('monto_total', function ($row) 
        {
            return  $row->monto_total_formateado;
        })
        ->make( true );
        $data = $object->getData(true);
        $data['monto_total_general'] = number_format( $ventas_query->get()->sum("monto_total") , 0, '', '.');
        return response()->json( $data );
    }

    public function marcar_comisiones(Request $re)
    {
        $ventas_query = $this->comision->ventas_filtradas( $re );
        if( $ventas_query->update(["comision_pagada" => true]) )
            return response()->json(["status" => "OK"]);
        else
            return response()->json(["status" => "NOK", "message" => "Ocurrio un error al intentar actualizar el estado de las ventas"]);
    }
}