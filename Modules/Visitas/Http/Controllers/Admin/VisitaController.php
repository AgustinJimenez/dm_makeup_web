<?php namespace Modules\Visitas\Http\Controllers\Admin;

use Laracasts\Flash\Flash;
use Illuminate\Http\Request;
use Modules\Visitas\Entities\Visita;
use Modules\Visitas\Repositories\VisitaRepository;
use Modules\Core\Http\Controllers\Admin\AdminBaseController;
use Modules\Ventas\Entities\FacturaVenta;
use Modules\Productos\Entities\Producto;
use Modules\Productos\Entities\CategoriaProducto;
use Yajra\Datatables\Facades\Datatables;
use DB;
include( base_path().'/Modules/funciones_varias.php');

class VisitaController extends AdminBaseController
{
    /**
     * @var VisitaRepository
     */
    private $visita;

    public function __construct(VisitaRepository $visita)
    {
        parent::__construct();

        $this->visita = $visita;
    }

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        $users_lists_tmp = $this->visita->users_lists()->toArray();
        $users_lists[''] = 'Todos';
        foreach ($users_lists_tmp as $key => $value)
            $users_lists[$key] = $value;
        return view('visitas::admin.visitas.index', compact('users_lists') );
    }

    public function resumen(\Visita $visita)
    {
        $productos_resumenes = $this->visita->resumen( $visita );
        return view("visitas::admin.visitas.resumen", compact("visita", "productos_resumenes") );
    }

    public function update_ajax(\Visita $visita, Request $re)
    {
        $response = ( $visita->update($re->all()) )?['status' => 'OK']:['status' => 'NOK', 'message' => 'Ocurrio un problema al intentar actualizar.'];
        return response()->json($response);
    }

    public function index_ajax(Request $re)
    {
        return
        \Datatables::of
        (
            $this->visita->visitas
            (
                $re->all(),
                ['id', 'lugar', 'fecha', 'user_id', 'estado'],
                ['id', 'first_name', 'last_name', \DB::raw('CONCAT(last_name," ",first_name) last_name_first_name')]
            )
        )
        ->setRowClass(function ()
        {
            return "text-center";
        })
        ->editColumn('fecha', function ($row)
        {
            return \Carbon::createFromFormat( "Y-m-d", $row->fecha )->format("d/m/Y");
        })
        ->editColumn('lugar', function ($row)
        {
            return str_limit($row->lugar, 40);
        })
        ->addColumn('actions', function ($row)
        {
            $buttons = '<div class="btn-group btn-group-sm">

                            <a href="' . $row->link_resumen . '" class="btn btn-small btn-success btn-md">
                                <b>RESUMEN</b>
                            </a>

                            <a href="' . $row->link_ventas . '" class="btn btn-small btn-success btn-md">
                                <b>VENTAS</b>
                            </a>

                            <a href="' . $row->link_agregar_productos . '" class="btn btn-primary btn-md">
                                <b>EDITAR</b>
                            </a>';

                $buttons .= ($row->estado == 'abierta')?
                            '<button class="btn btn-warning btn-md open-modal" method="update" link="' . $row->link_update_ajax . '">
                                <b>CERRAR</b>
                            </button>':
                            '';

                $buttons .= '<button class="btn btn-danger btn-md open-modal" method="delete" link="' . $row->link_delete_ajax . '">
                                <b>ELIMINAR</b>
                            </button>';

            $buttons .= '</div>';

            return $buttons;
        })
        ->make( true );
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create()
    {
        $users_lists = $this->visita->users_lists()->toArray();
        $visita = new \Visita;
        return view('visitas::admin.visitas.create', compact("users_lists", 'visita') );
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  Request $request
     * @return Response
     */
    public function store(Request $request)
    {
        \DB::beginTransaction();
        try
        {
            $visita = $this->visita->create($request->all());
        }
        catch (\Illuminate\Database\QueryException $exception)
        {
            \DB::rollBack();
            flash()->error("Ocurrio un error, contacte con el administrador. [{$exception->getMessage()}]");
            return redirect()->back();
        }
        \DB::commit();
        flash()->success("Visita creada correctamente");
        return redirect()->route('admin.visitas.visita.agregar_productos', array($visita->id));
    }

    public function agregar_productos(\Visita $visita)
    {
        return view('visitas::admin.visitas.agregar-productos', compact('visita'));
    }

    public function visita_productos_ajax(Request $re)
    {
        if( isset($re['store_visita_producto']) ):

            if( \StockRetirado::where( "visita_id", $re['visita_id'] )->where("producto_id", $re['producto_id'])->exists() )
                return response()->json(["status" => "NOK", "message" => "El producto ya esta agregado."]);
            else
                return response()
                ->json
                (
                    ($this->visita->create_stock_retirado( $re->all() ) )?
                    ["status" => "OK"]:
                    ["status" => "NOK", "message" => "Ocurrio un error al guardar."]
                );
        ;else:

            $object =
            \Datatables::of( $this->visita->stocks_retirados( $re['visita_id'], null, ["id", \DB::raw("CONCAT(nombre,' -codigo: ',codigo) as nombre"), "codigo"]) )
            ->setRowClass(function ($row)
            {
                return "text-center";
            })
            ->addColumn('actions', function ($row)
            {
                return '<button class="btn btn-danger open-modal" method="delete" link="' . $row->link_destroy_ajax . '" xd="'.$row->id.'">
                            <i class="glyphicon glyphicon-trash"></i>
                        </button>';
            });


            return $object->make( true );

        endif;
    }

    public function index_productos(\Visita $visita)
    {
        return view('visitas::admin.visitas.index-productos', compact('visita'));
    }



    /**
     * Show the form for editing the specified resource.
     *
     * @param  Visita $visita
     * @return Response
     */
    public function edit(Visita $visita)
    {
        $users_lists = $this->visita->users_lists()->toArray();
        return view('visitas::admin.visitas.edit', compact('visita', 'users_lists'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  Visita $visita
     * @param  Request $request
     * @return Response
     */
    public function update(Visita $visita, Request $request)
    {
        $this->visita->update($visita, $request->all());

        flash()->success(trans('core::core.messages.resource updated', ['name' => trans('visitas::visitas.title.visitas')]));

        return redirect()->route('admin.visitas.visita.index');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  Visita $visita
     * @return Response
     */
    public function destroy(Visita $visita)
    {
        $this->visita->destroy($visita);

        flash()->success(trans('core::core.messages.resource deleted', ['name' => trans('visitas::visitas.title.visitas')]));

        return redirect()->route('admin.visitas.visita.index');
    }

    public function destroy_ajax(Visita $visita)
    {
        try
        {
          $this->visita->destroy($visita);
        }
        catch (\Illuminate\Database\QueryException $e)
        {
            if($e->getCode() == "23000")
              return response()->json(['status' => "NOK", "message" => 'No se puede eliminar. La visita está asociado a otro registro.']);
            else
                return response()->json(['status' => "NOK", "message" => 'No se puede eliminar. Ocurrio un error. [' . $e->getMessage() . ']'] );
        }

        return response()->json(['status' => "OK"]);
    }

    public function ventas(Visita $visita){
          return view('visitas::admin.ventas.index', compact('visita'));
    }

    public function ventas_index_ajax(Request $request)
    {
        //dd( $request['isOtros'] );

        $query = FacturaVenta::
                join('ventas__ventas','ventas__ventas.id','=','venta_id')
               ->join('clientes__clientes','clientes__clientes.id','=','ventas__ventas.cliente_id')
               ->join('users as user1','user1.id','=','ventas__facturaventas.usuario_sistema_id_create')
               ->leftjoin('users as user2','user2.id','=','ventas__facturaventas.usuario_sistema_id_edit')
               ->orderBy('ventas__ventas.created_at','desc');

        $query->where('visita_id',$request['visita_id']);
        $query->whereNotIn('ventas__ventas.tipo',['otros']);

        $fecha_inicio = 'fecha_inicio';
        $fecha_fin = 'fecha_fin';
        $nro_seguimiento = 'nro_seguimiento';
        $razon_social = 'razon_social';
        $anulado = 'anulado';
        $pendiente = 'pendiente';

        if ($request->has($fecha_inicio) && trim($request->has($fecha_inicio) !== '') )
            $query->where('fecha', '>', date_to_server2($request[$fecha_inicio])->modify('-1 day')  );

        if ($request->has($fecha_fin) && trim($request->has($fecha_fin) !== '') )
            $query->where('fecha', '<', date_to_server2($request[$fecha_fin])  );

        if ($request->has($nro_seguimiento)  && trim($request->has($nro_seguimiento) !== '') )
            $query->where('nro_seguimiento', 'like', "%{$request[$nro_seguimiento]}%");

        if ($request->has($razon_social)  && trim($request->has($razon_social) !== '') )
            $query->where('clientes__clientes.razon_social', 'like', "%{$request[$razon_social]}%");

         if ($request->has('factura')  && trim($request->has('factura') !== '') )
            $query->where('ventas__facturaventas.nro_factura', 'like', "%{$request['factura']}%");

        if ($request->has('anulado')  && trim($request->has('anulado') !== '') )
            $query->where('ventas__ventas.anulado', $request->get('anulado'));

       if ( $request['pendiente'] )
       {
           $query->whereRaw('total_pagado < monto_total');
           $query->where('ventas__facturaventas.anulado', false);
       }
       else if($request['isOtros']==0)
           $query->whereRaw('total_pagado >= monto_total');

        $query->select
       (
            'ventas__facturaventas.id as id',
            'ventas__facturaventas.fecha as fecha',
            'ventas__facturaventas.nro_factura as nro_factura',
            'clientes__clientes.razon_social as razon_social',
            'ventas__facturaventas.anulado as anulado',
            'ventas__ventas.monto_total as monto_total',
            'ventas__ventas.total_pagado as total_pagado',
            DB::raw('CONCAT(user1.last_name," ",user1.first_name) as creado_por'),
            DB::raw('CONCAT(user2.last_name," ",user2.first_name) as editado_por')
        );



        $object = \Datatables::of( $query )
            ->addColumn('acciones', function ($tabla) use ($request)
            {
                $base_path = "admin.ventas.facturaventa";
                $asEdit = $base_path.".edit";
                $asDestroy = $base_path.".destroy";
                if ( $request['pendiente'])
                    $editRoute = route($asEdit, ['id' => $tabla->id, 'pendiente=1']);
                else
                    $editRoute = route($asEdit, ['id' => $tabla->id]);

                $deleteRoute = route($asDestroy, [$tabla->id]);
                $buttons = "<div class='btn-group'>";
                if($tabla->anulado)
                    $buttons = $buttons."<a href='".$editRoute." ' class='btn btn-default btn-flat'><strong>DETALLES</strong></a>";
                else
                    $buttons = $buttons."<a href='".$editRoute." ' class='btn btn-default btn-flat'><strong>DETALLES</strong></a>";
                return $buttons;
            })
            ->editColumn('fecha', function($tabla)
            {
                return date_from_server($tabla->fecha);
            })
            ->editColumn('monto_total', function($tabla)
            {
                return thousands_separator_dots($tabla->monto_total);
            })
            ->editColumn('total_pagado', function($tabla)
            {
                return thousands_separator_dots($tabla->total_pagado);
            })
            ->editColumn('anulado', function($tabla)
            {
                if($tabla->anulado)
                    return "SI";
                else
                    return "NO";
            })
            ->make(true);

        return $object;
    }


    public function index_productos_ajax(Request $request, Visita $visita)
    {
        $query = $this->queryProductoVisita($request,$visita);

                        $query->select
                              ([
                                'productos__productos.id',
                                'productos__productos.codigo',
                                'productos__categoriaproductos.nombre as categoria',
                                'productos__marcas.nombre as marca',
                                'productos__productos.nombre',
                                'productos__productos.stock',
                                'productos__productos.stock_minimo',
                                'productos__productos.activo as activo',
                                'productos__productos.archivo as archivo',
                                'productos__productos.precio_venta as precio_venta'
                              ]);


        $object = Datatables::of( $query )
            ->addColumn('agregar', function ($tabla) use ($visita) {
              if ($tabla->isInVisita($visita->id))
                   $checkbox="<input type='checkbox' name='producto' class='check-producto' value='".$tabla->id."' checked='checked'>";
               else
                   $checkbox="<input type='checkbox' name='producto' class='check-producto' value='".$tabla->id."'>";

                return $checkbox;
            })

            ->addColumn('cantidad', function ($tabla) use ($visita) {
              $cantidad = $tabla->cantidadInVisita($visita->id);
                if ($cantidad > 0)
                   $input="<input type='text' id=cantidad-producto-$tabla->id class='cantidad-producto' value='$cantidad'>";
                else
                   $input="<input type='text' id=cantidad-producto-$tabla->id class='cantidad-producto' value='0' disabled>";
                return $input;
            })

            ->filter(function ($query) use ($request)
            {
            })

            ->editColumn('stock', function($tabla)
            {
                return number_format($tabla->stock, 1, ',', '.');
            })
            ->editColumn('activo',' @if($activo)
                                        SI
                                    @else
                                        NO
                                    @endif')
            ->editColumn('archivo', function($tabla)
            {
              return '<a href"'. $tabla->getImgThumb() .'" data-toggle="lightbox" onclick="event.preventDefault();$(this).ekkoLightbox();">
                                        <img src="'.$tabla->getImgThumb() .'" class="img-thumbnail" alt="" class="" style="width: 70px; height: 70px;">
                                    </a>';
            })
            ->make(true);



            $data = $object->getData(true);

            $data['categorias'] = CategoriaProducto::orderBy('nombre')->get();

            return response()->json( $data );
    }

    private function queryProductoVisita(Request $request, Visita $visita){
      $query = Producto::join('productos__marcas','productos__marcas.id','=','productos__productos.marca_id')
                      ->join('productos__categoriaproductos','productos__categoriaproductos.id','=','productos__productos.categoria_id');

                      if ($request->has('categoria')  && trim($request->has('categoria') !== '') )
                        $query->where('productos__categoriaproductos.id', $request['categoria'] );

                      if ($request->has('marca')  && trim($request->has('marca') !== '') )
                        $query->where('productos__marcas.nombre', 'like', "%{$request->get('marca')}%");

                      if ($request->has('codigo')  && trim($request->has('codigo') !== '') )
                        $query->where('productos__productos.codigo', 'like', "%{$request->get('codigo')}%");

                      if ($request->has('nombre')  && trim($request->has('nombre') !== '') )
                        $query->where('productos__productos.nombre', 'like', "%{$request->get('nombre')}%");

                      if ($request->has('activo')  && trim($request->has('activo') !== '') )
                        $query->where('activo',$request->get('activo') );

                      if ($request->has('stock')  && trim($request->has('stock') !== '') )
                        $query->where('stock',">",$request->get('stock') );

        return $query;

    }

    public function save_producto(Request $request)
    {
        $visita_id = $request->get('visita_id');
        $producto_id = $request->get('producto_id');
        $action = $request->get('action');

        $response_array = $this->save_producto_to_database($visita_id,$producto_id,$action);


        return response()->json($response_array);
    }

    private function save_producto_to_database($visita_id,$producto_id,$action){
            DB::beginTransaction();

            try
            {
                if ($action == 'add'){
                    if(!\StockRetirado::where('visita_id',$visita_id)->where('producto_id',$producto_id)->exists()){
                      $producto = Producto::find($producto_id);
                      if($producto->stock <= 0)
                        $cantidad = 0;
                      else
                        $cantidad = $producto->stock;

                      \StockRetirado::create(['visita_id' => $visita_id,
                                              'producto_id' => $producto_id,
                                              'cantidad' => $cantidad]);

                    }
                    $cantidad = 0;
                }
                else{
                    \StockRetirado::where('visita_id', $visita_id)->where('producto_id', $producto_id)->delete();
                    $cantidad = 0;
                }
            }
            catch (ValidationException $e)
            {
                DB::rollBack();
                return ['status' => 'Error',
                        'message' => 'Error al procesar los datos'];
            }

            DB::commit();

            return ['status' => 'Ok',
                    'message' => 'Datos actualizados correctamente',
                    'action'  => $action,
                    'producto_id' => $producto_id,
                    'cantidad' => $cantidad];
    }

    public function edit_producto(Request $request)
    {
        $visita_id = $request->get('visita_id');
        $producto_id = $request->get('producto_id');
        $cantidad = $request->get('cantidad');

        if($cantidad <= 0){
          return response()->json(['status' => 'Error',
                                  'message' => 'La cantidad no puede ser 0 ni menor a 0.']);

        }


        DB::beginTransaction();

        try
        {
            $visita_producto = \StockRetirado::where('visita_id',$visita_id)->where('producto_id',$producto_id)->first();
            $visita_producto->cantidad = $cantidad;
            $visita_producto->save();
        }
        catch (ValidationException $e)
        {
            DB::rollBack();
            return response()->json(['status' => 'Error',
                                    'message' => 'Error al procesar los datos']);
        }

        DB::commit();

        return response()->json(['status' => 'Ok',
                                'message' => 'Datos actualizados correctamente',
                                'producto_id' => $producto_id,
                                'cantidad' => $cantidad]);
    }

    public function save_productos_filtrados(Request $request){
      $visita = Visita::find($request->get("visita_id"));
      $action = $request->get("action");
      $query = $this->queryProductoVisita($request,$visita);
      $productos = $query->select('productos__productos.id')->get();
      $i = 0;
      foreach ($productos as $producto) {
        $response_array = $this->save_producto_to_database($visita->id,$producto->id,$action);
        if( $response_array["status"] == "Error"){
          return response()->json($response_array);
          break;
        }
        $i++;
      }

      return response()->json(['status' => 'Ok',
                              'message' => 'Datos actualizados correctamente',
                              'cantidad' => $i
                            ]);


    }


}
