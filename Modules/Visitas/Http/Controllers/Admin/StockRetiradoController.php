<?php namespace Modules\Visitas\Http\Controllers\Admin;

use Laracasts\Flash\Flash;
use Illuminate\Http\Request;
use Modules\Visitas\Entities\StockRetirado;
use Modules\Visitas\Repositories\StockRetiradoRepository;
use Modules\Core\Http\Controllers\Admin\AdminBaseController;

class StockRetiradoController extends AdminBaseController
{
    /**
     * @var StockRetiradoRepository
     */
    private $stockretirado;

    public function __construct(StockRetiradoRepository $stockretirado)
    {
        parent::__construct();

        $this->stockretirado = $stockretirado;
    }

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        //$stockretirados = $this->stockretirado->all();

        return view('visitas::admin.stockretirados.index', compact(''));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create()
    {
        return view('visitas::admin.stockretirados.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  Request $request
     * @return Response
     */
    public function store(Request $request)
    {
        $this->stockretirado->create($request->all());

        flash()->success(trans('core::core.messages.resource created', ['name' => trans('visitas::stockretirados.title.stockretirados')]));

        return redirect()->route('admin.visitas.stockretirado.index');
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  StockRetirado $stockretirado
     * @return Response
     */
    public function edit(StockRetirado $stockretirado)
    {
        return view('visitas::admin.stockretirados.edit', compact('stockretirado'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  StockRetirado $stockretirado
     * @param  Request $request
     * @return Response
     */
    public function update(StockRetirado $stockretirado, Request $request)
    {
        $this->stockretirado->update($stockretirado, $request->all());

        flash()->success(trans('core::core.messages.resource updated', ['name' => trans('visitas::stockretirados.title.stockretirados')]));

        return redirect()->route('admin.visitas.stockretirado.index');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  StockRetirado $stockretirado
     * @return Response
     */
    public function destroy(StockRetirado $stockretirado)
    {
        $this->stockretirado->destroy($stockretirado);

        flash()->success(trans('core::core.messages.resource deleted', ['name' => trans('visitas::stockretirados.title.stockretirados')]));

        return redirect()->route('admin.visitas.stockretirado.index');
    }

    public function destroy_ajax(StockRetirado $stockretirado)
    {
        try
        {
          $this->stockretirado->destroy($stockretirado);
        }
        catch (\Illuminate\Database\QueryException $e)
        {
            if($e->getCode() == "23000")
              return response()->json(['status' => "NOK", "message" => 'No se puede eliminar. La stock está asociado a otro registro.']);
            else
                return response()->json(['status' => "NOK", "message" => 'No se puede eliminar. Ocurrio un error. [' . $e->getMessage() . ']'] );
        }

        return response()->json(['status' => "OK"]);
    }
}
