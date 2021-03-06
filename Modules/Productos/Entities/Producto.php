<?php namespace Modules\Productos\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Media\Support\Traits\MediaRelation;
use Modules\Visitas\Entities\StockRetirado;
use DateTime;

class Producto extends Model
{
    use  MediaRelation;

    protected $table = 'productos__productos';
    protected $fillable =
    [
	    'nombre',
	    'codigo',
	    'precio_compra',
      'precio_compra_promedio',
	    'precio_venta',
      'precio_venta_mayorista',
	    'stock',
      'stock_inicial',
	    'stock_minimo',
	    'activo',
	    'archivo',
	    'mime',
	    'categoria_id',
        'marca_id',
        'fecha_compra'
    ];

    protected $appends = ['archivo'];

    public function getArchivoAttribute()
    {
        if ($this->files()->first())
        {
          return $this->files()->first()->path->getUrl();
        }
        else
        {
          return "";
        }
    }

    public function getArchivoPath()
    {
        if ($this->files()->first())
        {
            $aux = './assets/media/'.$this->files()->first()->filename;
            $aux = explode(".",$aux);
            $aux[count($aux)-2] = $aux[count($aux)-2] . "_mediumThumb";
            $aux = implode(".",$aux);
            return $aux;
        }
        else
        {
          return "";
        }
    }

    public function getImg()
    {
        if ($this->files()->first())
        {
            $aux = '/assets/media/'.$this->files()->first()->filename;
            return $aux;
        }
        else
        {
          return "";
        }
      }


    public function getImgThumb()
    {
        if ($this->files()->first())
        {
            $aux = '/assets/media/'.$this->files()->first()->filename;
            $aux = explode(".",$aux);
            $aux[count($aux)-2] = $aux[count($aux)-2] . "_smallThumb";
            $aux = implode(".",$aux);
            return $aux;
        }
        else
        {
          return "";
        }
      }


    public function categoria()
    {
        return $this->belongsTo('Modules\Productos\Entities\CategoriaProducto','categoria_id');
    }

    public function marca()
    {
        return $this->belongsTo('Modules\Productos\Entities\Marca','marca_id');
    }

    public function alta_baja()
    {
        return $this->belongsTo('Modules\Productos\Entities\AltabajaProducto');
    }

    public function detalle_ventas()
    {
        return $this->hasMany('Modules\Ventas\Entities\DetalleVenta', 'producto_id');
    }

    public function detalles_compra()
    {
        return $this->hasMany('Modules\Compras\Entities\Detallecompra', 'producto_id');
    }

    public function getFechaCompraAttribute()
    {
        $date = $this->attributes['fecha_compra'];
        $dateObject = DateTime::createFromFormat('Y-m-d', $date);
        return $dateObject->format('d/m/Y');
    }

    public function isInVisita($visita_id){
      return StockRetirado::where('visita_id',$visita_id)->where('producto_id',$this->id)->exists();
    }

    public function cantidadInVisita($visita_id){
      if ($this->isInVisita($visita_id))
        return StockRetirado::where('visita_id',$visita_id)->where('producto_id',$this->id)->first()->cantidad;
      else
        return 0;
    }

    public static function stockGeneral(){
      return self::get()->sum('stock');
    }

}
