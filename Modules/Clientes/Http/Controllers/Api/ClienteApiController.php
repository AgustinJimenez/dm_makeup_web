<?php namespace Modules\Clientes\Http\Controllers\Api;

use Illuminate\Routing\Controller;
use Illuminate\Http\Request;
use Validator, Auth;
use Modules\User\Entities\Sentinel\User;
use Modules\Clientes\Entities\Cliente;
use Log;


class ClienteApiController extends Controller
{
    public function __construct()
    {
    }

    public function store(Request $request)
    {
        Log::info('Entro a ClienteApiController - Store');

        $rules = array(
            'razon_social'    => 'required',
        );


        $data = array(
            'razon_social' => $request->json('razon_social'),
            'ruc'  => $request->json('ruc'),
            'celular'  => $request->json('celular'),
            'email'  => $request->json('email'),
            'activo' => true,
        );

        $validator = Validator::make($data, $rules);

        if ($validator->fails()) {
            return response()->json(['status' => "Error", "message" => $validator->errors()->first()]);

        }
        else {
            try{
                $cliente = Cliente::create($data);
                return response()->json(['status' => "OK", "message" => "Cliente creado correctamente.", "cliente_id" => $cliente->id]);
            }
            catch (Exception $e){
              return response()->json(['status' => "Error", "message" => $e->getMessage()]);
            }
        }

    }

    public function search($q)
    {
      $q = "%" . $q . "%";
      $clientes = Cliente::where("razon_social","like",$q)
            ->orWhere("ruc","like",$q)
            ->orWhere("cedula","like",$q)
            ->orWhere("ruc","like",$q)
            ->orderBy("razon_social")->limit(10)->get();


      return response()->json(['status' => "OK",
                              "message" => "Lista de clientes",
                              "clientes" => $clientes]);

    }
}
