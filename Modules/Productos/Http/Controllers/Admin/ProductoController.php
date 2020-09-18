<?php namespace Modules\Productos\Http\Controllers\Admin;

use Laracasts\Flash\Flash;
use Illuminate\Http\Request;
use Modules\Productos\Entities\Producto;
use Modules\Productos\Repositories\ProductoRepository;
use Modules\Core\Http\Controllers\Admin\AdminBaseController;
use Modules\Productos\Events\ProductoWasCreated;
use Modules\Media\Repositories\FileRepository;
use Modules\Productos\Http\Requests\ProductoRequest;
use Modules\Productos\Entities\CategoriaProducto;
use Modules\Productos\Entities\Marca;
use Yajra\Datatables\Facades\Datatables;
use Response;
use DB,Session;
use Dompdf\Dompdf;
use Dompdf\Options;
use Modules\Ventas\Entities\DetalleVenta;
use Modules\Configuraciones\Entities\Configuracion;
include( base_path().'/Modules/funciones_varias.php');
use PDF;
class ProductoController extends AdminBaseController
{
    /**
     * @var ProductoRepository
     */
    private $producto;

    public function __construct(ProductoRepository $producto)
    {
        parent::__construct();

        $this->producto = $producto;
    }

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        $stock_general = Producto::stockGeneral();

        return view('productos::admin.productos.index',compact('stock_general'));
    }

    public function index_stock_critico()
    {
      $stock_minimo = true;


    return view('productos::admin.productos.index', compact('stock_minimo'));
    }

    public function index_ajax(Request $request)
    {
        $query =Producto::join('productos__marcas','productos__marcas.id','=','productos__productos.marca_id')
                        ->join('productos__categoriaproductos','productos__categoriaproductos.id','=','productos__productos.categoria_id');

                        if ($request->has('categoria')  && trim($request->has('categoria') !== '') )
                          $query->where('productos__categoriaproductos.id', $request['categoria'] );


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
            ->addColumn('action', function ($tabla)
            {
                $asEdit = "admin.productos.producto.edit";

                $asDestroy = "admin.productos.producto.destroy";

                $asHistorial =  "admin.productos.producto.historial";

                $editRoute = route( $asEdit, [$tabla->id]);

                $deleteRoute = route( $asDestroy, [$tabla->id]);

                $historialRoute = route( $asHistorial, [$tabla->id]);

                $buttons="<div class='btn-group'>
                            <a href='". $editRoute." ' class='btn btn-default btn-flat'>
                                <i class='fa fa-pencil'></i>
                            </a>
                            <button class='btn btn-danger btn-flat' data-toggle='modal' data-target='#modal-delete-confirmation' data-action-target='". $deleteRoute ."'>
                                <i class='fa fa-trash'></i>
                            </button>
                            <a href='". $historialRoute." ' class='btn btn-default btn-flat'>
                                Historial
                            </a>
                        </div>";

                return $buttons;
            })

            ->filter(function ($query) use ($request)
            {
                if ($request->stock_minimo)
                  $query->whereRaw('productos__productos.stock <= productos__productos.stock_minimo');

                if ($request->has('marca')  && trim($request->has('marca') !== '') )
                  $query->where('productos__marcas.nombre', 'like', "%{$request->get('marca')}%");

                if ($request->has('codigo')  && trim($request->has('codigo') !== '') )
                  $query->where('productos__productos.codigo', 'like', "%{$request->get('codigo')}%");

                if ($request->has('nombre')  && trim($request->has('nombre') !== '') )
                  $query->where('productos__productos.nombre', 'like', "%{$request->get('nombre')}%");

                if ($request->has('activo')  && trim($request->has('activo') !== '') )
                  $query->where('activo',$request->get('activo') );

            })
            ->editColumn('precio_venta', function($tabla)
            {
                return number_format($tabla->precio_venta, 0, '', '.');
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
              return '<a href="'. $tabla->getImg() .'" data-toggle="lightbox" onclick="event.preventDefault();$(this).ekkoLightbox();">
                                        <img src="'.$tabla->getImgThumb() .'" class="img-thumbnail" alt="" class="" style="width: 70px; height: 70px;">
                                    </a>';
            })
            ->make(true);



            $data = $object->getData(true);

            $data['categorias'] = CategoriaProducto::orderBy('nombre')->get();

            return response()->json( $data );
    }

    public function search_producto( Request $request )
    {
      $results = collect([]);

        if ($request->has('term')  && trim($request->has('term') !== '') )
        {
          $term = $request->get('term') . "%";
          $productos = Producto::where('productos__productos.activo',true)
          ->where(function ($q) use ($term)
          {
              $q->where('nombre', 'like', $term )
                ->orWhere('codigo', 'like', $term);
          })
          ->where(function ($q) use ($request)
          {
              if(isset($request['visita_id']))
                $q->whereNotIn("id", \Visita::find( $request['visita_id'] )->stocks_retirados->lists('producto_id')->toArray() );
          });
          $productos = $productos->limit(5)->get();

          if( $productos->count() )
            foreach ($productos as $p)
            {
              if(!$p->nombre)
                $p->nombre = " ";
                $results->push(['status' => 'OK' ,'id' => $p->id, 'value' => $p->nombre . " -codigo: " . $p->codigo . " -marca: " . $p->marca->nombre . " -stock: " .$p->stock ,'precio' => $p->precio_venta]);
            }
        }
        else if( isset( $request['from_lector'] ) and $request->has("codigo") and $request->get("codigo") != '' )
        {
          $productos = Producto::
          where( "codigo", $request->get('codigo') )
          ->where(function ($q) use ($request)
          {
              if(isset($request['visita_id']))
                $q->whereNotIn("id", \Visita::find( $request['visita_id'] )->stocks_retirados->lists('producto_id')->toArray() );
          })
          ->get();
          if( $productos->count() == 1 )
          {
            $p = $productos->first();
            $results->push
            ([
              'status' => 'OK',
              'id' => $p->id,
              'value' => $p->nombre . " -codigo: " . $p->codigo . " -marca: " . $p->marca->nombre . " -stock: " .$p->stock ,
              'precio' => $p->precio_venta
            ]);
          }
          else if( $productos->count() > 1 )
            $results->push([ "status" => "NOK", 'message' => "Se encontraron mas de 1 producto con ese codigo." ]);
          else
            $results->push([ "status" => "NOK", 'message' => "No se encontraron productos con ese codigo." ]);
        }

        return Response::json( $results );
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create(Request $re)
    {
        $categorias=CategoriaProducto::orderBy('nombre')->lists('nombre','id')->all();

        $marcas=Marca::orderBy('nombre')->lists('nombre','id')->all();

        date_default_timezone_set('America/Asuncion');

        $porcentaje_precio_mayorista = Configuracion::where('identificador',
                                      'porcentaje_descuento_por_defecto_precio_venta_mayorista')->first();
        $factor_precio_mayorista = (100 - $porcentaje_precio_mayorista->valor)/100;

        $fecha_hoy = date('d/m/Y', time());

        $permisos = collect($re->user()->get_full_permisos->get("Permisos Especiales Productos"));

        return view('productos::admin.productos.create', compact('imagen','categorias','marcas','fecha_hoy', 'permisos','factor_precio_mayorista'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  Request $request
     * @return Response
     */
    public function store(ProductoRequest $request)
    {


      if(!$request->get('codigo'))
        $request['codigo'] = null;
      if( !$request->get("pecio_compra") )$request['precio_compra'] = 0;
      if( !$request->get("codigo") )$request['codigo'] = null;

      $request['fecha_compra'] = date("Y-m-d", strtotime( str_replace('/', '-', $request['fecha_compra']) ));

      $request['precio_compra'] = $request['precio_compra_promedio'];

      $request['stock'] = $request['stock_inicial'];

      $producto = $this->producto->create($request->all());



      event(new ProductoWasCreated($producto, $request->all()));

      flash()->success(trans('core::core.messages.resource created', ['name' => trans('productos::productos.title.productos')]));

      return redirect()->route('admin.productos.producto.index');
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  Producto $producto
     * @return Response
     */
    public function edit(Producto $producto, FileRepository $FileRepository, Request $re)
    {
        $categorias=CategoriaProducto::orderBy('nombre')->lists('nombre','id')->all();

        $marcas=Marca::orderBy('nombre')->lists('nombre','id')->all();

        $archivo = $FileRepository->findFileByZoneForEntity('archivo',$producto);

        $producto->precio_compra_promedio = number_format($producto->precio_compra_promedio, 3, ',', '.');

        $permisos = collect($re->user()->get_full_permisos->get("Permisos Especiales Productos"));

        $porcentaje_precio_mayorista = Configuracion::where('identificador',
                                      'porcentaje_descuento_por_defecto_precio_venta_mayorista')->first();
        $factor_precio_mayorista = (100 - $porcentaje_precio_mayorista->valor)/100;

        $producto->stock = str_replace('.', ',', $producto->stock);
        $producto->stock_minimo = str_replace('.', ',', $producto->stock_minimo);
        return view('productos::admin.productos.edit', compact('producto','categorias','marcas','archivo', 'permisos','factor_precio_mayorista'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  Producto $producto
     * @param  Request $request
     * @return Response
     */
    public function update(Producto $producto, ProductoRequest $request)
    {
      if(!$request->get('codigo'))
        $request['codigo'] = null;

        $request['fecha_compra'] = date("Y-m-d", strtotime( str_replace('/', '-', $request['fecha_compra']) ));

        $this->producto->update($producto, $request->all());

        flash()->success(trans('core::core.messages.resource updated', ['name' => trans('productos::productos.title.productos')]));

        return redirect()->route('admin.productos.producto.index');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  Producto $producto
     * @return Response
     */
    public function destroy(Producto $producto)
    {
      try
      {
        $this->producto->destroy($producto);
      }
      catch (\Illuminate\Database\QueryException $e)
      {
        if($e->getCode() == "23000")
        {
          flash()->error('No se puede eliminar. El producto está asociado a alguna venta, compra o alta/baja.');
          return redirect()->back();
        }
        else
        {
            flash()->error('No se puede eliminar. Ocurrio un error. '/*.$e->getMessage()*/);
            return redirect()->back();
        }
      }


      flash()->success("Producto eliminado correctamente.");
      return redirect()->route('admin.productos.producto.index');
    }

    public function inventario_producto_performance()
    {
        $categorias=CategoriaProducto::lists('nombre','id')->all();

        return view('productos::admin.productos.inventario_producto_performance', compact('categorias'));
    }


    public function productos_vendidos()
    {
      $categorias = CategoriaProducto::orderBy('codigo')
                                      ->orderBy('nombre')
                                      ->select('id', 'nombre', 'codigo')
                                      ->get('id', 'nombre', 'codigo')
                                      ->all();

      $productos__categoria[''] = 'Todas';

      foreach ($categorias as $key => $categoria)
        $productos__categoria[$categoria->id] = $categoria->codigo . ' ' . $categoria->nombre;

      $marcas = Marca::orderBy('codigo')
                      ->orderBy('nombre')
                      ->select('id', 'nombre', 'codigo')
                      ->get('id', 'nombre', 'codigo')
                      ->all();

      $productos__marca[''] = 'Todas';

      foreach ($marcas as $key => $marca)
        $productos__marca[$marca->id] = $marca->codigo . ' ' . $marca->nombre;

      return view('productos::admin.productos.productos-vendidos', compact('productos__categoria','productos__marca'));
    }


    public function productos_vendidos_ajax(Request $request)
    {
      $query = $this->productos_vendidos_query($request);

      $total_ganancia = 0;

      $object = Datatables::of( $query )

          ->editColumn('ganancia', function($tabla) use ($query)
          {
              return number_format($tabla->ganancia, 0, '', '.');
          })

          ->editColumn('total_venta', function($tabla) use ($query)
          {

              return number_format($tabla->total_venta, 0, '', '.');
          })

          ->editColumn('total_costo', function($tabla) use ($query)
          {
              return number_format($tabla->total_costo, 0, '', '.');
          })
          ->make(true);

      $data = $object->getData(true);

      return response()->json( $data );
    }

    public function productos_vendidos_query(Request $request)
    {
       $query = DetalleVenta::
                join('productos__productos','productos__productos.id','=','ventas__detalleventas.producto_id')
              ->join('productos__marcas','productos__marcas.id','=','productos__productos.marca_id')
              ->join('productos__categoriaproductos','productos__categoriaproductos.id','=','productos__productos.categoria_id')
              ->join('ventas__ventas','ventas__ventas.id','=','ventas__detalleventas.venta_id')
              ->where('ventas__ventas.anulado',false);

              if ($request->has('fecha_inicio') && trim($request->has('fecha_inicio') !== '') )
                  $query->where('ventas__ventas.fecha_venta', '>', date_create_from_format('d/m/Y', $request->get('fecha_inicio'))->modify('-1 day')  );

              if ($request->has('fecha_fin') && trim($request->has('fecha_fin') !== '') )
                  $query->where('ventas__ventas.fecha_venta', '<', date_create_from_format('d/m/Y', $request->get('fecha_fin'))  );

              if ($request->has('categoria') && trim($request->has('categoria') !== '') )
                  $query->where('productos__categoriaproductos.id', $request->get('categoria')  );

              if ($request->has('marca') && trim($request->has('marca') !== '') )
                  $query->where('productos__marcas.id', $request->get('marca')  );

              if ($request->has('productos') && trim($request->has('productos') !== '') )
                  $query->where('productos__productos.nombre', 'like', "%{$request->get('productos')}%"  );

              $query->select
              ([
                  'productos__productos.id as id',
                  'productos__productos.nombre',
                  'productos__productos.codigo as codigo',
                  'ventas__ventas.fecha_venta as fecha',

                  DB::raw('CONCAT(productos__categoriaproductos.nombre,"  -codigo:",productos__categoriaproductos.codigo) as categoria'),

                  DB::raw('CONCAT( COALESCE(productos__productos.nombre,""),"  -codigo:",productos__productos.codigo) as producto_nombre'),

                  DB::raw('CONCAT( COALESCE(productos__marcas.codigo,""),"  -codigo:",productos__marcas.nombre) as marca'),

                  DB::raw('SUM(ventas__detalleventas.cantidad) as cantidad'),

                  DB::raw('SUM(ventas__detalleventas.cantidad * ventas__detalleventas.precio_unitario * (100-ventas__ventas.descuento_porcentaje)/100 ) as total_venta'),

                  DB::raw('SUM(ventas__detalleventas.cantidad * ventas__detalleventas.costo_unitario) as total_costo'),

                  DB::raw('SUM(ventas__detalleventas.cantidad * ventas__detalleventas.precio_unitario * (100-ventas__ventas.descuento_porcentaje)/100) - SUM(ventas__detalleventas.cantidad * ventas__detalleventas.costo_unitario) as ganancia'),
                ])
              ->groupBy('id');
        //dd( $query->toSql() );


        return $query;
    }

    public function productos_vendidos_xls(Request $re)
    {
      $re["fecha_inicio"] = $re->get('fecha_inicio_excel');
      $re["fecha_fin"] = $re->get('fecha_fin_excel');
      $re["producto"] = $re->get('producto_excel');
      $re["categoria"] = $re->get('categoria_excel');
      $re["marca"] = $re->get('marca_excel');
      $detalles_ventas = $this->productos_vendidos_query( $re )->get();
      //dd($re->all() );
      \Excel::create('Reporte_Productos_Vendidos_' . date("Y_m_d"), function($excel) use ($detalles_ventas, $re)
      {
          $excel->sheet('Reporte_Productos_Vendidos', function($sheet) use ($detalles_ventas, $re)
          {
              $fecha_inicio = $re->fecha_inicio;
              $fecha_fin = $re->fecha_fin;
              $producto = $re->producto;
              $categoria = CategoriaProducto::find( $re->categoria );
              $marca = Marca::find( $re->marca );
              //return view('productos::admin.productos.productos-vendidos-excel', compact('detalles_ventas','fecha_inicio', 'fecha_fin', 'producto', 'categoria', 'marca'));
              $sheet->loadView( 'productos::admin.productos.productos-vendidos-excel', compact('detalles_ventas','fecha_inicio', 'fecha_fin', 'producto', 'categoria', 'marca') );
          });
      })->export('xls');
    }

    public function inventario_producto_pdf(Request $request)
    {
      set_time_limit(0);
      ini_set('memory_limit', '-1');
      if(!$request['categoria'])
      {
        flash()->warning('Debe seleccionar alguna categoria.')->important();

        return redirect()->back();
      }

      $imagen = $request['imagen'];

      $precio_compra = (int)$request['precio_compra'];

      $precio_venta = (int)$request['precio_venta'];

      $seleccion_categoria = $request['categoria'];

      $categorias_productos = CategoriaProducto::has('producto')->select('id', 'nombre', 'codigo')->whereIn('id',$seleccion_categoria)->orderBy('nombre')->get();

      //dd( $categorias_productos->first()->producto->first()->getArchivoPath() );

      $fecha = date('d/m/Y');

      $anho_ejercicio = Session::get('ejercicio');

       if($request->get('exportar-excel'))
       {
          \Excel::create('Reporte_Inventario_Producto_' . date("Y_m_d"), function($excel) use (  $anho_ejercicio, $fecha, $categorias_productos, $precio_compra, $precio_venta, $imagen )
          {
              $excel->sheet('Reporte_Inventario_Producto', function($sheet) use (  $anho_ejercicio, $fecha, $categorias_productos, $precio_compra, $precio_venta, $imagen )
              {
                $sheet->loadView( 'productos::admin.productos.inventario_producto_excel', compact('anho_ejercicio','fecha','categorias_productos','precio_compra','precio_venta','imagen' ) );
              });
          })->export('xls');
       }
       else
       {
          $view = view('productos::admin.productos.inventario_producto_pdf', compact( 'anho_ejercicio','fecha','categorias_productos','precio_compra','precio_venta','imagen' ));
          $pdf = PDF::setOptions(['defaultFont' => 'sans-serif', 'isPhpEnabled' => true, 'isJavascriptEnabled' => true, 'debugCss' => false])
            ->loadHTML($view)
            ->setPaper("legal", "portrait")
            ->stream('caja', array("Attachment" => 0));//0 preview/ 1 download
            return $pdf;
       }



    }

    public function cargar_productos_desde_excel()
    {
      return view( 'productos::admin.carga_productos_excel.carga');
    }

    public function store_productos_desde_excel(Request $re)
    {
      DB::beginTransaction();
      try
      {
        $archivo = \File2::find($re['medias_single']['archivo']);
        $file_path = base_path().'/public/assets/media/'.$archivo->filename;
        $rows = \Excel::load($file_path)->get()->toArray();
        $mensaje = false;
        foreach ($rows as $key => $row)
        {
            $producto = new Producto();
            $producto->nombre = $row['nombre']?$row['nombre']:"sin nombre " . Producto::count();
            $producto->codigo = $row['codigo'];
            $producto->precio_compra = $row['precio_de_compra']?$row['precio_de_compra']:0;
            $producto->precio_compra_promedio = $row['precio_de_compra']?$row['precio_de_compra']:0;
            $producto->precio_venta = $row['precio_de_venta'];
            $producto->stock = $row['stock']?$row['stock']:0;
            $producto->stock_minimo = $row['stock_minimo']?$row['stock_minimo']:0;
            $producto->activo = true;

            $categoria = CategoriaProducto::where("nombre", "like", ("%".$row['categoria']."%") )->first();
            if($categoria)
              $producto->categoria_id = $categoria->id;
            else
            {
              $categoria = new CategoriaProducto();
              $categoria->nombre = $row['categoria'];
              $categoria->codigo = null;
              $categoria->save();
              $producto->categoria_id = $categoria->id;
            }

            $marca = Marca::where("nombre", "like", ("%".$row['marca']."%") )->first();
            if($marca)
              $producto->marca_id = $marca->id;
            else
            {
              $marca = new Marca();
              $marca->nombre = $row['marca'];
              $marca->codigo = Marca::count();
              $marca->save();
              $producto->marca_id = $marca->id;
            }
            $producto->fecha_compra = $row['fecha_de_compra']?$row['fecha_de_compra']:"2000-01-01";

            if(!Producto::where('codigo', $producto->codigo)->count())
              $producto->save();
            else
              $mensaje .= "-Producto: {$producto->nombre}, con categoria {$row['categoria']}, con marca {$row['marca']} con codigo: {$producto->codigo}, precio de compra: {$producto->precio_compra} precio_venta: {$producto->precio_venta} ERROR: el codigo de este producto es igual a otro ya guardado en la base de datos, omitiendo este producto. ||";

        }
      }
        catch (ValidationException $e)
        {
            DB::rollBack();
            flash()->success( "Occurrio un error al procesar el archio");
            return redirect()->back();
        }
        DB::commit();

        if($mensaje)
          flash()->warning($mensaje);
      return redirect()->route('admin.productos.producto.index');

    }

    public function historial(Request $request, Producto $producto){

      //$this->atualizarStockInicial();
      //$this->controlarCostos();
      $stock_inicial = DB::select("SELECT
                                        stock_inicial as cantidad,
                                        date(created_at) as fecha,
                                        'stock inicial' as operacion,
                                        precio_compra as costo_unitario,
                                        id as operacion_id
                                  FROM productos__productos
                                  where id = :producto_id",
                                  ['producto_id' => $producto->id]);


      $operaciones = DB::select("SELECT
                                        SUM(cantidad) as cantidad,
                                        venta.created_at as fecha,
                                        'venta' as operacion,
                                        costo_unitario as costo_unitario,
                                        factura_venta.id as operacion_id
                                  FROM ventas__detalleventas AS det_venta
                                  JOIN ventas__ventas as venta
                                  ON det_venta.venta_id = venta.id
                                  JOIN ventas__facturaventas as factura_venta
                                  ON factura_venta.venta_id = venta.id
                                  where producto_id = :venta_producto_id
                                  AND venta.anulado = false
                                  GROUP BY operacion_id

                                  UNION
                                  SELECT
                                        SUM(cantidad) as cantidad,
                                        compra.created_at as fecha,
                                        'compra' as operacion,
                                        precio_unitario as costo_unitario,
                                        compra.id as operacion_id
                                  FROM compras__detallecompras AS det_compra
                                  JOIN compras__compras as compra
                                  ON det_compra.compra_id = compra.id
                                  where producto_id = :compra_producto_id
                                  AND compra.anulado = false
                                  GROUP BY operacion_id

                                  UNION
                                  SELECT
                                        cantidad,
                                        created_at,
                                        operacion,
                                        0 as costo_unitario,
                                        id as operacion_id
                                  FROM productos__altabajaproductos
                                  where producto_id = :altabaja_producto_id

                                  order by fecha",

                                  [
                                  'venta_producto_id' => $producto->id,
                                  'compra_producto_id' => $producto->id,
                                  'altabaja_producto_id' => $producto->id,
                                  ]);

        //dd($operaciones);
        return view( 'productos::admin.productos.historial',compact('producto','operaciones','stock_inicial'));
    }

    public function atualizarStockInicial(){
      $productos = Producto::get();
      $producto_ids = [];
      foreach ($productos as $producto) {
        $operaciones = DB::select("SELECT
                                          SUM(cantidad) as cantidad,
                                          fecha_venta as fecha,
                                          'venta' as operacion,
                                          factura_venta.id as operacion_id
                                    FROM ventas__detalleventas AS det_venta
                                    JOIN ventas__ventas as venta
                                    ON det_venta.venta_id = venta.id
                                    JOIN ventas__facturaventas as factura_venta
                                    ON factura_venta.venta_id = venta.id
                                    where producto_id = :venta_producto_id
                                    AND venta.anulado = false
                                    GROUP BY operacion_id

                                    UNION
                                    SELECT
                                          SUM(cantidad),
                                          fecha,
                                          'compra' as operacion,
                                          compra.id as operacion_id
                                    FROM compras__detallecompras AS det_compra
                                    JOIN compras__compras as compra
                                    ON det_compra.compra_id = compra.id
                                    where producto_id = :compra_producto_id
                                    AND compra.anulado = false
                                    GROUP BY operacion_id

                                    UNION
                                    SELECT
                                          cantidad,
                                          fecha,
                                          operacion,
                                          id as operacion_id
                                    FROM productos__altabajaproductos
                                    where producto_id = :altabaja_producto_id

                                    order by fecha",

                                    ['venta_producto_id' => $producto->id,
                                    'compra_producto_id' => $producto->id,
                                    'altabaja_producto_id' => $producto->id,
                                    ]);
              $stock_positivo = 0;
              $stock_negativo = 0;
              foreach ($operaciones as $operacion) {
                if($operacion->operacion == "baja" || $operacion->operacion == "venta"){
                  $stock_negativo += $operacion->cantidad;
                }
                else {
                    $stock_positivo += $operacion->cantidad;
                }
              }

              $stock_inicial = $producto->stock +$stock_negativo -$stock_positivo;
              if($stock_inicial < 0){
                array_push($producto_ids,$producto->id);
              }

              // $producto->stock_inicial = $stock_inicial;
              // $producto->save();

              if($stock_inicial != $producto->stock_inicial){
                // $producto->stock_inicial = $stock_inicial;
                // $producto->save();
                // $producto->stock_inicial_calculado = $stock_inicial;
                // dd($producto);
                // array_push($producto_ids,$producto->id);
              }

      }
      dd($producto_ids);
    }

    public function controlarCostos(){
      $datos = (object)NULL;
      $datos->errorCosto = [];
      $datos->costoPromedioCero = [];

      $productos = Producto::orderBy('id')->get();
      foreach ($productos as $producto) {
        $primera_compra_o_venta = true;
        $operaciones = $this->getOperaciones($producto);
        $costo_promedio = 0;
        $stock_actual = $producto->stock_inicial;

        foreach ($operaciones as $operacion) {
          switch ($operacion->operacion) {
            case 'venta':
              if($primera_compra_o_venta){
                $primera_compra_o_venta = false;
                $producto->precio_compra = $operacion->costo_unitario;
                $producto->precio_compra_promedio = $operacion->costo_unitario;
                $producto->save();
                $costo_promedio = $operacion->costo_unitario;
              }
              $stock_actual = $stock_actual - $operacion->cantidad;

              if (abs($operacion->costo_unitario - $costo_promedio) > 1){
                if(!in_array($producto->id,$datos->errorCosto)){
                  array_push($datos->errorCosto,$producto->id);
                }

                if($costo_promedio == 0){
                  array_push($datos->costoPromedioCero,$producto->id);
                  break;
                }

                $detalles_venta = DetalleVenta::where('venta_id',$operacion->operacion_id)
                            ->where('producto_id',$producto->id)->get();
                foreach ($detalles_venta as $detalle_venta) {
                  $detalle_venta->costo_unitario = $costo_promedio;
                  $detalle_venta->save();
                }

              }
              break;

            case 'compra':
              if($primera_compra_o_venta){
                $primera_compra_o_venta = false;
                $producto->precio_compra = $operacion->costo_unitario;
                $producto->save();
                $costo_promedio = $operacion->costo_unitario;
              }

              if ($stock_actual + $operacion->cantidad == 0){
                $costo_promedio = $operacion->costo_unitario;
                $stock_actual = $stock_actual + $operacion->cantidad;
              }else{
                $costo_promedio = ($stock_actual*$costo_promedio + $operacion->cantidad*$operacion->costo_unitario)/($stock_actual+$operacion->cantidad);
                $stock_actual = $stock_actual + $operacion->cantidad;
              }
              $producto->precio_compra_promedio = $costo_promedio;
              $producto->save();
              break;

            case 'alta':
              $stock_actual = $stock_actual + $operacion->cantidad;
              break;

            case 'baja':
              $stock_actual = $stock_actual - $operacion->cantidad;
              break;

            default:
              dd("Case no considerado en el switch");
              break;
          }

        }
        if($primera_compra_o_venta){
          $producto->precio_compra = $producto->precio_compra_promedio;
          $producto->save();
        }



      }

      dd($datos);
    }

    private function getOperaciones($producto){
      return DB::select("SELECT
                              SUM(cantidad) as cantidad,
                                venta.created_at as fecha,
                                'venta' as operacion,
                                costo_unitario as costo_unitario,
                                factura_venta.id as operacion_id
                          FROM ventas__detalleventas AS det_venta
                          JOIN ventas__ventas as venta
                          ON det_venta.venta_id = venta.id
                          JOIN ventas__facturaventas as factura_venta
                          ON factura_venta.venta_id = venta.id
                          where producto_id = :venta_producto_id
                          AND venta.anulado = false
                          GROUP BY operacion_id

                          UNION
                          SELECT
                                SUM(cantidad) as cantidad,
                                compra.created_at as fecha,
                                'compra' as operacion,
                                precio_unitario as costo_unitario,
                                compra.id as operacion_id
                          FROM compras__detallecompras AS det_compra
                          JOIN compras__compras as compra
                          ON det_compra.compra_id = compra.id
                          where producto_id = :compra_producto_id
                          AND compra.anulado = false
                          GROUP BY operacion_id

                          UNION
                          SELECT
                                cantidad,
                                created_at as fecha,
                                operacion,
                                0 as costo_unitario,
                                id as operacion_id
                          FROM productos__altabajaproductos
                          where producto_id = :altabaja_producto_id

                          order by fecha",

                          ['venta_producto_id' => $producto->id,
                          'compra_producto_id' => $producto->id,
                          'altabaja_producto_id' => $producto->id,
                          ]);

    }
}
