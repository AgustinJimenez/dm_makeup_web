<?php namespace Modules\Configuraciones\Entities;

use Dimsav\Translatable\Translatable;
use Illuminate\Database\Eloquent\Model;

class Configuracion extends Model
{
    protected $table = 'configuraciones__configuracions';
    public $translatedAttributes = [];
    protected $fillable = [
      'identificador',
      'nombre',
      'valor'
    ];

    public static function findByIdentificadorOrCreate($identificador,$nombre,$valor){
      $obj_count = static::where('identificador',$identificador)->count();
      if ($obj_count == 0){
        $obj = new static;
        $obj->identificador = $identificador;
        $obj->nombre = $nombre;
        $obj->valor = $valor;
        $obj->save();
      }
    }
}
