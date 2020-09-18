<?php namespace Modules\Visitas\Http\Controllers\Api;

use Illuminate\Routing\Controller;
use Illuminate\Http\Request;
use Validator, Auth;
use Modules\User\Entities\Sentinel\User;
use Modules\Visitas\Entities\Visita;
use Log;
use Modules\Visitas\Repositories\VisitaRepository;

class VisitaApiController extends Controller
{

  public function __construct(VisitaRepository $visita)
  {
      $this->visita = $visita;
  }

    public function search(Request $request){
      $user = User::where('token', $request->get('token'))->first();
      $visitas = Visita::where("estado","abierta")
                        ->where("user_id",$user->id)
                        ->get();

      return response()->json(["status" => "Ok",
              "message" => "Lista de visitas activas segun usuario",
              "visitas" => $visitas,
            ]);
    }

    public function searchActiva($visita_id, Request $request){
      $user = User::where('token', $request->get('token'))->first();
      $visita = Visita::where("id",$visita_id)
                        ->first();

      return response()->json(["status" => "Ok",
              "message" => "Visita",
              "visita" => $visita,
            ]);
    }

    public function indexProductos($visita_id, Request $request){
      $user = User::where('token', $request->get('token'))->first();
      $permiso_productos = $user->hasAccess('configuraciones.app.productos-de-otras-visitas');

      if($permiso_productos && $visita_id == 0){
        $visita = Visita::where('estado','abierta')->orderBy('created_at','desc')->first();
        if($visita){
          $visitas = Visita::where('estado','abierta')
                    ->where('id',"!=",$visita->id)->orderBy('created_at','desc')->get();
          $productos = $this->visita->resumen( Visita::find($visita->id) );
          return response()->json(["status" => "Ok",
                                  "message" => "Lista de productos por visita",
                                  "productos" => $productos,
                                  "visitas" => $visitas,
                                  "visita_seleccionada" => $visita]);

        }else{
          return response()->json(["status" => "Error",
                                  "message" => "No hay visitas abiertas.",
                                  "productos" => []]);
        }
      }

      $visita = Visita::find($visita_id);

      if($visita->user_id != $user->id && !$permiso_productos){
        return response()->json(["status" => "Error",
                                "message" => "Permiso denegado",
                                "productos" => []]);

      }

      //dd($this->visita);

      $productos = $this->visita->resumen( Visita::find($visita_id) );

      if($visita->user_id == $user->id && !$permiso_productos){
        return response()->json(["status" => "Ok",
                                "message" => "Lista de productos por visita",
                                "productos" => $productos,
                                "visitas" => [$visita],
                                "visita_seleccionada" => $visita]);

      }

      if($permiso_productos){
        $visitas = Visita::where('estado','abierta')
                ->where('id',"!=",$visita->id)->orderBy('created_at','desc')->get();

        return response()->json(["status" => "Ok",
                                "message" => "Lista de productos por visita",
                                "productos" => $productos,
                                "visitas" => $visitas,
                                "visita_seleccionada" => $visita]);

      }


      return response()->json(["status" => "Error",
                              "message" => "Solicitud no valida",
                              "productos" => [] ]);
    }
}
