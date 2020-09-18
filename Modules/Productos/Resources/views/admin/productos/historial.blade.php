@extends('layouts.master')

@section('content-header')
<h1>
    {{ 'Historial de Stock: ' . $producto->nombre  . ". Stock actual: " . $producto->stock }}
</h1>
<ol class="breadcrumb">
</ol>
@stop

@section('content')
<div class="row">
    <div class="col-xs-12">
      <div class="row">
          <div class="btn-group pull-right" style="margin: 0 15px 15px 0;">
              <a href="{{ route('admin.productos.altabajaproducto.create',$producto->id) }}" class="btn btn-primary btn-flat" style="padding: 4px 10px;">
                  <i class="fa fa-pencil"></i> Crear Alta/Baja
              </a>
          </div>
      </div>

        <div class="box box-primary">
            <div class="box-header">
            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <table class="data-table table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>Fecha</th>
                            <th>Operación</th>
                            <th>Cantidad</th>
                            <th>Costo unitario</th>
                            <th data-sortable="false">{{ trans('user::users.table.actions') }}</th>
                        </tr>
                    </thead>
                    <tbody>
                      <?php if (isset($stock_inicial)): ?>
                          <?php foreach ($stock_inicial as $operacion): ?>
                            <tr>
                                <td>{{ $operacion->fecha }}</td>
                                <td>{{ $operacion->operacion }}</td>
                                @if ($operacion->operacion == "venta" || $operacion->operacion == "baja" )
                                  <td>{{ $operacion->cantidad*-1 }}</td>
                                @else
                                  <td>{{ $operacion->cantidad }}</td>
                                @endif
                                <td>{{ $operacion->costo_unitario }}</td>
                                <td>
                                    <div class="btn-group">
                                        <a href="{{ route('admin.productos.producto.edit', $operacion->operacion_id) }}" class="btn btn-default btn-flat">Ver operación</a>
                                    </div>
                                </td>
                            </tr>
                          <?php endforeach; ?>
                      <?php endif; ?>


                    <?php if (isset($operaciones)): ?>
                        <?php foreach ($operaciones as $operacion): ?>
                            <tr>
                                <td>{{ $operacion->fecha }}</td>
                                <td>{{ $operacion->operacion }}</td>
                                @if ($operacion->operacion == "venta" || $operacion->operacion == "baja" )
                                  <td>{{ $operacion->cantidad*-1 }}</td>
                                @else
                                  <td>{{ $operacion->cantidad }}</td>
                                @endif
                                <td><?php echo number_format($operacion->costo_unitario, 0, ",","."); ?> </td>
                                <td>
                                    <div class="btn-group">
                                      @if ($operacion->operacion == "venta")
                                        <a href="{{ route('admin.ventas.facturaventa.edit', $operacion->operacion_id) }}" class="btn btn-default btn-flat">Ver operación</a>
                                      @else
                                        @if ($operacion->operacion == "compra")
                                          <a href="{{ route('admin.compras.compra.factura', $operacion->operacion_id) }}" class="btn btn-default btn-flat">Ver operación</a>
                                        @else
                                          <a href="{{ route('admin.productos.altabajaproducto.index') }}" class="btn btn-default btn-flat">Ver operación</a>
                                        @endif
                                      @endif
                                    </div>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                    </tbody>
                    <tfoot>
                        <tr>
                          <th>Fecha</th>
                          <th>Operación</th>
                          <th>Cantidad</th>
                          <th data-sortable="false">{{ trans('user::users.table.actions') }}</th>
                        </tr>
                    </tfoot>
                </table>
            <!-- /.box-body -->
            </div>
        <!-- /.box -->
    </div>
<!-- /.col (MAIN) -->
</div>
</div>

@stop

@section('scripts')
<?php $locale = App::getLocale(); ?>
<script type="text/javascript">
    $(function () {
        $('.data-table').dataTable({
            "paginate": true,
            "lengthChange": true,
            "filter": true,
            "sort": false,
            "info": true,
            "autoWidth": true,
            "order": [[ 0, "asc" ]],
            "language": {
                "url": '<?php echo Module::asset("core:js/vendor/datatables/{$locale}.json") ?>'
              }
          });
      });
  </script>
  @stop
