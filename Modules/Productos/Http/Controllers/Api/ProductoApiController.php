<?php namespace Modules\Productos\Http\Controllers\Api;

use Illuminate\Routing\Controller;
use Illuminate\Http\Request;
use Validator, Auth;
use Modules\User\Entities\Sentinel\User;
use Modules\Productos\Entities\Producto;
use Modules\Configuraciones\Entities\Configuracion;
use Log;


class ProductoApiController extends Controller
{
    public function __construct()
    {
    }

    public function searchByCode($code)
    {
      $producto = Producto::where("codigo",$code)->first();
      if($producto){
        $cantidad_minima_mayorista = Configuracion::where('identificador','cantidad_minima_pecio_venta_mayorista')->first()->valor;
        return response()->json(['status' => "OK",
                                "message" => "Producto obtenido por codigo: " . $code,
                                "producto" => $producto,
                                "cantidad_minima_mayorista" => $cantidad_minima_mayorista]);

      }else{
        return response()->json(['status' => "Error",
                                "message" => "No se encontro ningun producto con el codigo: " . $code,
                                ]);
      }

    }

    public function search($q)
    {
      $q = "%" . $q . "%";
      $productos = Producto::join('productos__marcas','productos__productos.marca_id',"=","productos__marcas.id")
            ->where("productos__productos.nombre","like",$q)
            ->orWhere("productos__productos.codigo","like",$q)
            ->orWhere("productos__marcas.nombre","like",$q)
            ->orderBy("productos__productos.nombre")
            ->select("productos__productos.*", "productos__marcas.nombre as marca_nombre")
            ->limit(20)->get();

      $cantidad_minima_mayorista = Configuracion::where('identificador','cantidad_minima_pecio_venta_mayorista')->first()->valor;

      return response()->json(['status' => "OK",
                              "message" => "Lista de productos",
                              "productos" => $productos,
                              "cantidad_minima_mayorista" => $cantidad_minima_mayorista]);


    }

}
