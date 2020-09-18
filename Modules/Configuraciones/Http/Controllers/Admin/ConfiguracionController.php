<?php namespace Modules\Configuraciones\Http\Controllers\Admin;

use Laracasts\Flash\Flash;
use Illuminate\Http\Request;
use Modules\Configuraciones\Entities\Configuracion;
use Modules\Configuraciones\Repositories\ConfiguracionRepository;
use Modules\Core\Http\Controllers\Admin\AdminBaseController;
use Modules\Configuraciones\Http\Requests\ConfiguracionRequest;

class ConfiguracionController extends AdminBaseController
{
    /**
     * @var ConfiguracionRepository
     */
    private $configuracion;

    public function __construct(ConfiguracionRepository $configuracion)
    {
        parent::__construct();

        $this->configuracion = $configuracion;
    }

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        Configuracion::findByIdentificadorOrCreate('monto_minimo_para_descuento_app',
                          'Monto a partir del cual se puede hacer descuento en la App',
                          '1000000');
        Configuracion::findByIdentificadorOrCreate('porcentaje_maximo_de_descuento_app',
                          'Porcentaje máximo de descuento en la App (en %)',
                          '20');
        Configuracion::findByIdentificadorOrCreate('cantidad_minima_pecio_venta_mayorista',
                          'Cantidad a partir de la cual se aplica el precio mayorista en la App',
                          '6');
        Configuracion::findByIdentificadorOrCreate('porcentaje_descuento_por_defecto_precio_venta_mayorista',
                          'Porcentaje de descuento que se aplica por defecto al precio mayorista al crear un producto (en %)',
                          '20');

        $configuraciones = Configuracion::orderBy('nombre')->get();

        return view('configuraciones::admin.configuracions.index', compact('configuraciones'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create()
    {
        return view('configuraciones::admin.configuracions.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  Request $request
     * @return Response
     */
    public function store(Request $request)
    {
        $this->configuracion->create($request->all());

        flash()->success(trans('core::core.messages.resource created', ['name' => trans('configuraciones::configuracions.title.configuracions')]));

        return redirect()->route('admin.configuraciones.configuracion.index');
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  Configuracion $configuracion
     * @return Response
     */
    public function edit(Configuracion $configuracion)
    {
        return view('configuraciones::admin.configuracions.edit', compact('configuracion'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  Configuracion $configuracion
     * @param  Request $request
     * @return Response
     */
    public function update(Configuracion $configuracion, ConfiguracionRequest $request)
    {
        $configuracion->update($request->all());

        flash()->success(trans('core::core.messages.resource updated', ['name' => trans('configuraciones::configuracions.title.configuracions')]));

        return redirect()->route('admin.configuraciones.configuracion.index');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  Configuracion $configuracion
     * @return Response
     */
    // public function destroy(Configuracion $configuracion)
    // {
    //     $this->configuracion->destroy($configuracion);
    //
    //     flash()->success(trans('core::core.messages.resource deleted', ['name' => trans('configuraciones::configuracions.title.configuracions')]));
    //
    //     return redirect()->route('admin.configuraciones.configuracion.index');
    // }
}
