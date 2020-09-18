<?php namespace Modules\Ventas\Http\Controllers\Api;

use Illuminate\Routing\Controller;
use Illuminate\Http\Request;
use Validator, Auth;
use Modules\User\Entities\Sentinel\User;
use Modules\Ventas\Entities\Venta;
use Modules\Ventas\Entities\FacturaVenta;
use Modules\Ventas\Entities\DetalleVenta;
use Modules\Pagofacturascredito\Entities\Pagofacturacredito;
use Modules\Clientes\Entities\Cliente;
use Modules\Productos\Entities\Producto;
use Modules\Contabilidad\Entities\Asiento;
use Modules\Contabilidad\Entities\AsientoDetalle;
use Modules\Configuraciones\Entities\Configuracion;
use Modules\Visitas\Entities\Visita;
use Log, DB;
use Carbon\Carbon;
use Modules\Caja\Entities\Caja;
use Modules\Ventas\Entities\NumberToLetterConverter;


class VentaApiController extends Controller
{
    public function __construct()
    {
    }

    public function store(Request $request)
    {
       $user = User::where('token', $request->get('token'))->first();

       $visita_id = $request->json('visita_id');
       if ($visita_id == 0 or !Visita::where("id",$visita_id)->where("estado","abierta")->exists()){
         return response()->json(["status" => "Error", "message" => "No seleccionó visita o la visita está cerrada"]);
       }

       $caja  = Caja::where('activo',true)->first();
	     $cliente_id_aux	= $request->json('cliente_id');
       $cliente_id = $this->obtenerClienteId($cliente_id_aux);
       $monto_total = $request->get('monto_total');
       $converter = new NumberToLetterConverter;
       $monto_total_letras = $converter->to_word($monto_total);
       $descuento_total = $request->get('descuento_total');
       $gravado_10 = 0; //intval($monto_total/11*10);
       $total_iva_10 = 0; //$monto_total - $gravado_10;
       $total_iva = $total_iva_10;
       $gravado_excenta = $monto_total;
       $total_pagado = $monto_total;

       $hoy = Carbon::now();
       $forma_pago = "efectivo";

       $factor_de_descuento = $descuento_total / ($monto_total + $descuento_total);
       $descuento_porcentaje = $factor_de_descuento*100;


       DB::beginTransaction();
       try {

         //Cabecera venta
         $venta = Venta::create([
           "cliente_id" => $cliente_id,
           "tipo" => "venta",
           "estado" => "terminado",
           "nro_seguimiento" => "",
           "fecha_venta" => $hoy,
           "fecha_entrega" => $hoy,
           "usuario_sistema_id_create" => $user->id,
           "caja_id" => $caja->id,
           "monto_total" => $monto_total,
           "monto_total_letras" => $monto_total_letras,
           "descuento_total" => $descuento_total,
           "descuento_porcentaje" => $descuento_porcentaje,
           "gravado_excenta" => $gravado_excenta,
           "gravado_5" => 0,
           "gravado_10" => $gravado_10,
           "total_iva_5" => 0,
           "total_iva_10" => $total_iva_10,
           "total_iva" => $total_iva,
           "total_pagado" => $total_pagado,
           "comision_pagada" => false,
           "visita_id" => $visita_id
         ]);

         //Cabecera factura venta
         $factura_venta = FacturaVenta::create([
           "venta_id" => $venta->id,
           "nro_factura" => "",
           "fecha" => $hoy,
           "anulado" => false,
           "tipo_factura" => "contado",
           "usuario_sistema_id_create" => $user->id,
         ]);

         //Pago venta
         $pago_venta = Pagofacturacredito::create([
           "venta_id" => $venta->id,
           "fecha" => $hoy,
           "monto" => $monto_total,
           "caja_id" => $caja->id,
           "forma_pago" => $forma_pago,
           "nro_recibo" => "",
         ]);

         //Detalle Venta
         foreach ($request->get("detalles") as $detalle) {
           DetalleVenta::create([
             "venta_id" => $venta->id,
             "cantidad" => $detalle["cantidad"],
             "producto_id" => $detalle["producto_id"],
             "precio_unitario" => $detalle["precio_unitario"],
             "costo_unitario" => $detalle["costo_unitario"],
             "iva" => "11",
             "precio_total" => $detalle["precio_total"],
           ]);

           $producto = Producto::find($detalle["producto_id"]);
           $producto->stock = $producto->stock - $detalle["cantidad"];
           $producto->save();

         }

         //Asiento
         $asiento = Asiento::create([
             'fecha' => $hoy,
             'observacion' => 'Venta al Contado desde App | Cliente:  '.$venta->cliente->razon_social,
             'operacion' => 'Venta Contado',
             'usuario_create_id' => $user->id,
             'entidad_type' => FacturaVenta::class,
             'entidad_id' => $factura_venta->id,
         ]);

         //Detalle Asiento

         //Detalle Asiento - caja
         AsientoDetalle::create([
             'asiento_id' => $asiento->id,
             'cuenta_id' => \CuentasFijas::get('ventas.contado.facturaventa.caja.debe')->id,
             'debe' => $monto_total,
             'haber' => 0,
             'observacion' => ''
         ]);

         //Inicio - Sin IVA
          AsientoDetalle::create
          ([
              'asiento_id' => $asiento->id,
              'cuenta_id' => \CuentasFijas::get('ventas.contado.facturaventa.mercaderias_gravadas_iva.haber')->id,
              'debe' => 0,
              'haber' => $monto_total,
              'observacion' => ''
          ]);
         //Fin - Sin IVA


         //Inicio Si hubiera IVA:
         //Detalle Asiento - mercaderia
        //  AsientoDetalle::create
        //  ([
        //      'asiento_id' => $asiento->id,
        //      'cuenta_id' => \CuentasFijas::get('ventas.contado.facturaventa.mercaderias_gravadas_iva.haber')->id,
        //      'debe' => 0,
        //      'haber' => $gravado_10,
        //      'observacion' => ''
        //  ]);

         //Detalle Asiento - Credito Fiscal
        //  AsientoDetalle::create
        //  ([
        //      'asiento_id' => $asiento->id,
        //      'cuenta_id' => \CuentasFijas::get('ventas.contado.facturaventa.iva_credito_fiscal.haber')->id,
        //      'debe' => 0,
        //      'haber' => $total_iva,
        //      'observacion' => ''
        //  ]);
         //Fin - Si hubiera IVA





         DB::commit();
         return response()->json(['status' => "Ok", "message" => "Venta creada, id: " . $venta->id]);

       } catch (\Exception $e) {
         dd($e);
         DB::rollback();
         return response()->json(["status" => "Error", "message" => $e]);
       }




    }

    private function obtenerClienteId($cliente_id_aux){
      if(!$cliente_id_aux || $cliente_id_aux == 0){
        $cliente_default = Cliente::where("razon_social","Sin nombre")->first();
        if($cliente_default){
          return $cliente_default->id;
        }else{
          $cliente_default = Cliente::create(["razon_social"=>"Sin nombre"]);
          return $cliente_default->id;
        }
      }
      else{
        return $cliente_id_aux;
      }
    }

    public function descuentoConfig(Request $request){
      $user = User::where('token', $request->get('token'))->first();
      $permiso_descuento = false;
      if ($user->hasAccess('configuraciones.app.descuento')){
        $permiso_descuento = true;
      }
      $monto_minimo_para_descuento = Configuracion::where('identificador','monto_minimo_para_descuento_app')->first()->valor;
      $porcentaje_maximo_de_descuento = Configuracion::where('identificador','porcentaje_maximo_de_descuento_app')->first()->valor;


      Configuracion::findByIdentificadorOrCreate('monto_minimo_para_descuento_app','Monto a partir del cual se puede hacer descuento en la App','1000000');
      Configuracion::findByIdentificadorOrCreate('porcentaje_maximo_de_descuento_app','Porcentaje máximo de descuento en la App (en %)','20');

      return response()->json([
        "status" => "Ok",
        "message" => "Configuracion de descuentos",
        "permiso_descuento" => $permiso_descuento,
        "monto_minimo_para_descuento" => $monto_minimo_para_descuento,
        "porcentaje_maximo_de_descuento" => $porcentaje_maximo_de_descuento,
      ]);


    }

    public function indexByVisita($visita_id, Request $request){
      $user = User::where('token', $request->get('token'))->first();
      $permiso_ventas = $user->hasAccess('configuraciones.app.ventas-de-otras-visitas');


      if($permiso_ventas && $visita_id == 0){
        $visita = Visita::where('estado','abierta')->orderBy('created_at','desc')->first();
        if($visita){
          $visitas = Visita::where('estado','abierta')
                    ->where('id',"!=",$visita->id)->orderBy('created_at','desc')->get();
          $ventas = Venta::with('cliente')
                      ->where("visita_id",$visita->id)
                      ->where('anulado',0)
                      ->orderBy("created_at","desc")->get();
          return response()->json(["status" => "Ok",
                                  "message" => "Lista de productos por visita",
                                  "ventas" => $ventas,
                                  "visitas" => $visitas,
                                  "visita_seleccionada" => $visita]);

        }else{
          return response()->json(["status" => "Error",
                                  "message" => "No hay visitas abiertas.",
                                  "productos" => []]);
        }
      }




      $visita = Visita::find($visita_id);

      if($visita->user_id != $user->id && !$permiso_ventas){
        return response()->json(["status" => "Error",
                                "message" => "Permiso denegado",
                                "ventas" => []]);

      }

      $ventas = Venta::with('cliente')
                ->where("visita_id",$visita_id)
                ->where('anulado',0)
                ->orderBy("created_at","desc")->get();

      if($visita->user_id == $user->id && !$permiso_ventas){
        return response()->json(["status" => "Ok",
                                "message" => "Lista de ventas por visita",
                                "ventas" => $ventas,
                                "visitas" => [$visita],
                                "visita_seleccionada" => $visita]);

      }

      if($permiso_ventas){
        $visitas = Visita::where('estado','abierta')
                    ->where('id',"!=",$visita_id)
                    ->orderBy('created_at','desc')->get();
        return response()->json(["status" => "Ok",
                                "message" => "Lista de ventas por visita",
                                "ventas" => $ventas,
                                "visitas" => $visitas,
                                "visita_seleccionada" => $visita]);

      }


    }

    public function detalle($venta_id, Request $request){
      $venta = Venta::with('cliente','detalles.producto')->where("id",$venta_id)->first();
      //dd($venta);
      return response()->json(["status" => "Ok",
                              "message" => "Detalle de venta",
                              "venta" => $venta]);
    }


}
