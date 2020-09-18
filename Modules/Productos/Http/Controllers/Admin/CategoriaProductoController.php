<?php namespace Modules\Productos\Http\Controllers\Admin;

use Laracasts\Flash\Flash;
use Illuminate\Http\Request;
use Modules\Productos\Entities\CategoriaProducto;
use Modules\Productos\Entities\Producto;
use Modules\Productos\Repositories\CategoriaProductoRepository;
use Modules\Core\Http\Controllers\Admin\AdminBaseController;

use Modules\Productos\Http\Requests\CategoriaProductoRequest;

class CategoriaProductoController extends AdminBaseController
{
    /**
     * @var CategoriaProductoRepository
     */
    private $categoriaproducto;

    public function __construct(CategoriaProductoRepository $categoriaproducto)
    {
        parent::__construct();

        $this->categoriaproducto = $categoriaproducto;
    }

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        $categoriaproductos = $this->categoriaproducto->all();

        $stock_general = Producto::stockGeneral();

        return view('productos::admin.categoriaproductos.index', compact('categoriaproductos','stock_general'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create()
    {
        return view('productos::admin.categoriaproductos.create', array('categoriaproducto' => new CategoriaProducto));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  Request $request
     * @return Response
     */
    public function store(CategoriaProductoRequest $request)
    {
        $this->categoriaproducto->create($request->all());

        flash()->success("La Categoria ha sido creada correctamente.");

        return redirect()->route('admin.productos.categoriaproducto.index');
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  CategoriaProducto $categoriaproducto
     * @return Response
     */
    public function edit(CategoriaProducto $categoriaproducto)
    {
        return view('productos::admin.categoriaproductos.edit', compact('categoriaproducto'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  CategoriaProducto $categoriaproducto
     * @param  Request $request
     * @return Response
     */
    public function update(CategoriaProducto $categoriaproducto, CategoriaProductoRequest $request)
    {
        $this->categoriaproducto->update($categoriaproducto, $request->all());

        flash()->success(trans('core::core.messages.resource updated', ['name' => trans('productos::categoriaproductos.title.categoriaproductos')]));

        return redirect()->route('admin.productos.categoriaproducto.index');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  CategoriaProducto $categoriaproducto
     * @return Response
     */
    public function destroy(CategoriaProducto $categoriaproducto)
    {
        try
        {
            $this->categoriaproducto->destroy($categoriaproducto);
        }
        catch (\Illuminate\Database\QueryException $e)
        {
            if($e->getCode() == "23000")
            {
                flash()->error('No se puede eliminar. La categoria está asociada a algun producto. ');
                return redirect()->back();
            }
            else
            {
                flash()->error('No se puede eliminar. Ocurrio un error. '/*.$e->getMessage()*/);
                return redirect()->back();
            }
        }

        flash()->success("Categoria eliminada correctamente");

        return redirect()->route('admin.productos.categoriaproducto.index');
    }
}
