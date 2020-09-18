<?php namespace Modules\Visitas\Entities;

use Illuminate\Database\Eloquent\Model;
use DateTime;

class Visita extends Model
{
    protected $table = 'visitas__visitas';
    protected $fillable =
    [
    	"lugar",
		"fecha",
		'user_id',
		"estado"
    ];

    protected $appends = ['fecha_format',];

    public function setFechaAttribute($value)
    {
        $this->attributes['fecha'] = \Carbon::createFromFormat("d/m/Y", $value);
    }

    public function ventas()
    {
        return $this->hasMany( \Venta::class, 'visita_id');
    }

     public function user()
    {
        return $this->belongsTo( \User::class, "user_id" );
    }

    public function stocks_retirados()
    {
        return $this->HasMany( \StockRetirado::class, "visita_id");
    }

    public function getLinkEditAttribute()
    {
        return route("admin.visitas.visita.edit", [$this->id]);
    }

    public function getLinkAgregarProductosAttribute()
    {
        return route("admin.visitas.visita.index_productos", [$this->id]);
    }
    public function getLinkResumenAttribute()
    {
        return route("admin.visitas.visita.resumen", [$this->id]);
    }

    public function getLinkDeleteAttribute()
    {
        return route("admin.visitas.visita.destroy", [$this->id]);
    }
    public function getLinkDeleteAjaxAttribute()
    {
        return route("admin.visitas.visita.destroy_ajax", [$this->id]);
    }
    public function getLinkVentasAttribute()
    {
        return route("admin.visitas.visita.ventas", [$this->id]);
    }

    public function getFechaFormatedAttribute()
    {
        return \Carbon::createFromFormat("Y-m-d", $this->fecha)->format("d/m/Y");
    }

    public function getUserFullNameAttribute()
    {
        $user = $this->user;
        return $user->last_name . " " . $user->first_name;
    }

    public function getLinkUpdateAttribute()
    {
        return route("admin.visitas.visita.update", [$this->id]);
    }

    public function getLinkUpdateAjaxAttribute()
    {
        return route("admin.visitas.visita.update_ajax", [$this->id]);
    }

    public function getFechaFormatAttribute()
    {
        $date = $this->fecha;
        $dateObject = DateTime::createFromFormat('Y-m-d', $date);
        return $dateObject->format('d/m/Y');
    }



}
