<?php namespace Modules\Productos\Http\Controllers\Admin;

use Laracasts\Flash\Flash;
use Illuminate\Http\Request;
use Modules\Productos\Entities\AltabajaProducto;
use Modules\Productos\Repositories\AltabajaProductoRepository;
use Modules\Core\Http\Controllers\Admin\AdminBaseController;
use Modules\Productos\Entities\Producto;
use DB;
use Modules\Productos\Http\Requests\AltaBajaProductoRequest;
use DateTime;
use Modules\Core\Contracts\Authentication;
use Yajra\Datatables\Facades\Datatables;
use Carbon\Carbon;


class AltabajaProductoController extends AdminBaseController
{
    /**
     * @var AltabajaProductoRepository
     */
    private $altabajaproducto;

    private $auth;

    public function __construct(AltabajaProductoRepository $altabajaproducto,Authentication $auth )
    {
        parent::__construct();

        $this->auth=$auth;

        $this->altabajaproducto = $altabajaproducto;
    }

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        
        return view('productos::admin.altabajaproductos.index');
    }
    public function indexAjax(Request $request)
    {
        $query = AltabajaProducto::join('users','users.id','=','usuario_sistema_id')
                ->join('productos__productos as productos','productos.id','=','producto_id')
                ->select([
                        'productos__altabajaproductos.id as id',
                        'productos.nombre',
                         'productos__altabajaproductos.operacion as operacion',
                          'descripcion',
                           'productos__altabajaproductos.cantidad as cantidad',
                            'productos__altabajaproductos.fecha as fecha',
                         DB::raw('CONCAT(users.last_name," ",users.first_name) as usuario')
                         ]);

        $object = Datatables::of( $query )
            ->addColumn('acciones', function ($tabla) 
                {
                    $asEdit = "admin.productos.altabajaproducto.edit";

                    $asDestroy = "admin.productos.altabajaproducto.destroy";

                    $editRoute = route( $asEdit, [$tabla->id]);

                    $deleteRoute = route( $asDestroy, [$tabla->id]);
 
                    $buttons="<div class='btn-group'>
                                <!--
                                <a href='".$editRoute." ' class='btn btn-default btn-flat'>
                                    <i class='fa fa-pencil'></i>
                                </a>
                                -->
                                <button class='btn btn-danger btn-flat' data-toggle='modal' data-target='#modal-delete-confirmation' data-action-target='".$deleteRoute."'>
                                    <i class='fa fa-trash'></i>
                                </button>
                            </div>";

                    return $buttons;
                })
            ->filter(function ($query) use ($request) 
            {
                if ($request->has('fecha_inicio') && trim($request->get('fecha_inicio') !== '') ) 
                    $query->where('fecha', '>', date_create_from_format('d/m/Y', $request->get('fecha_inicio'))->modify('-1 day')  );

                if ($request->has('fecha_fin') && trim($request->get('fecha_fin') !== '') ) 
                    $query->where('fecha', '<', date_create_from_format('d/m/Y', $request->get('fecha_fin'))  );

                if ($request->has('producto')  && trim($request->get('producto') !== '') ) 
                    $query->where('productos.nombre', 'like', "%{$request->get('producto')}%");

                if ($request->has('usuario')  && trim($request->get('usuario') !== '') ) 
                    $query->where( DB::raw('CONCAT( users.last_name," ",users.first_name)'), 'like', "%{$request->get('usuario')}%");


                if ($request->has('operacion')  && trim($request->get('operacion') !== '') ) 
                    $query->where('productos__altabajaproductos.operacion', 'like', "%{$request->get('operacion')}%");
            })
            ->make( true );
   
            

        //dd( $object );

        return $object;
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create(Producto $producto, Request $re)
    {
        $now=Carbon::now('America/Asuncion')->format('Y/m/d');

        $userID = $this->auth->id();

        $datosUsuario = DB::table('users')->where('id',$userID)->first();
        $permisos = collect($re->user()->get_full_permisos->get("Permisos Especiales Productos"));
        return view('productos::admin.altabajaproductos.create',compact('producto','now','datosUsuario', "permisos"));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  Request $request
     * @return Response
     */
    public function store(AltaBajaProductoRequest $request)
    {   
        $alta_baja_producto = new AltabajaProducto;
        $alta_baja_producto
        ->fill( $request->all() )
        ->save();

        \Producto::find($request->get('producto_id'))
                    ->update(['stock' => $request->get('stockAlter') ]);


        flash()->success("alta/baja creada correctamente.");

        return redirect()->route('admin.productos.altabajaproducto.index');
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  AltabajaProducto $altabajaproducto
     * @return Response
     */
    public function edit(AltabajaProducto $altabajaproducto, Request $re)
    {
        $producto=Producto::where('id',$altabajaproducto->producto_id)->first();

        $fecha = DateTime::createFromFormat('d/m/Y', $altabajaproducto->fecha )->format('Y-m-d'); 

        if($altabajaproducto->operacion=='alta')
        {
            $anteriorStock = $producto->stock-$altabajaproducto->cantidad;
        }
        else
        {
            $anteriorStock = $producto->stock+$altabajaproducto->cantidad;
        }


        $permisos = collect($re->user()->get_full_permisos->get("Permisos Especiales Productos"));

        return view('productos::admin.altabajaproductos.edit', compact('altabajaproducto','producto','fecha','anteriorStock', "permisos"));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  AltabajaProducto $altabajaproducto
     * @param  Request $request
     * @return Response
     */
    public function update(AltabajaProducto $altabajaproducto, Request $request)
    {  
/*
        $descripcion = $request->get('descripcion');

        $operacion = $request->get('operacion');

        $cantidad = $request->get('cantidad');

        $fecha = $request->get('fecha');
*/
        $producto_id = $request->get('producto_id');

        $stock = $request->get('stockAlter');

        $this->altabajaproducto->update($altabajaproducto, $request->all());

        DB::table('productos__productos')
            ->where('id', $request->get('producto_id') )
            ->update(['stock' => $stock]);

        flash()->success(trans('core::core.messages.resource updated', ['name' => trans('productos::altabajaproductos.title.altabajaproductos')]));

        return redirect()->route('admin.productos.altabajaproducto.index');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  AltabajaProducto $altabajaproducto
     * @return Response
     */
    public function destroy(AltabajaProducto $altabajaproducto)
    {
        //dd( $altabajaproducto );
        $producto = \Producto::find( $altabajaproducto->producto_id );

        if( $altabajaproducto->operacion == 'alta' )
            $stock_original =  $producto->stock - $altabajaproducto->cantidad;
        else
            $stock_original =  $producto->stock + $altabajaproducto->cantidad;

        $producto->update(['stock' => $stock_original]);

        $this->altabajaproducto->destroy( $altabajaproducto );

        flash()->success("alta/baja eliminada correctamente");

        return redirect()->route('admin.productos.altabajaproducto.index');
    }

    public function seleccionProductos()
    {
        $productos=Producto::get();

        //dd($productos);

        return view('productos::admin.altabajaproductos.seleccionProductos',compact('productos') );
    }

}
