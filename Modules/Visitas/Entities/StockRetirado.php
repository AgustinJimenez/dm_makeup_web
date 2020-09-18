<?php namespace Modules\Visitas\Entities;

use Illuminate\Database\Eloquent\Model;

class StockRetirado extends Model
{
    protected $table = 'visitas__stocks_retirados';
    protected $fillable = 
    [
    	'visita_id',
		'producto_id',
		'cantidad'
    ];

    public function visita()
    {
    	return $this->belongsTo( \Visita::class, "visita_id");
    }

    public function getLinkDestroyAttribute()
    {
        return route( "admin.visitas.stockretirado.destroy", [$this->id] );
    }

    public function getLinkDestroyAjaxAttribute()
    {
        return route( "admin.visitas.stockretirado.destroy_ajax", [$this->id] );
    }

    public function producto()
    {
    	return $this->hasOne( \Producto::class, "id", "producto_id");
    }

}
