@extends('layouts.master')

@section('content-header')
    <h1>
        Marcas de Productos
    </h1>
    <ol class="breadcrumb">

    </ol>
@stop


@section('content')
    <div class="row">
        <div class="col-xs-12">
            <div class="row">
                <div class="btn-group pull-right" style="margin: 0 15px 15px 0;">
                    <a href="{{ route('admin.productos.marca.create') }}" class="btn btn-primary btn-flat" style="padding: 4px 10px;">
                        <i class="fa fa-pencil"></i> Crear Marca
                    </a>
                </div>
            </div>
            <div class="box box-primary">
                <div class="box-header">
                    <div class="col-md-3">
                        <label for="marca" class="control-label" >Nombre de Marca:   </label>
                        <input type="text" class="form-control input-sm" name="marca" id="marca" value="" >
                    </div>
                    <div class="col-md-3">
                        <p class="label label-warning" style="font-size:14px" >Stock General:   {{ $stock_general }}</p>
                    </div>


                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <table class="data-table table table-bordered table-hover">
                        <thead class="bg-primary">
                            <tr>
                                <th>Codigo</th>
                                <th>Nombre</th>
                                <th>Descripcion</th>
                                <th>Stock</th>
                                <th data-sortable="false">{{ trans('core::core.table.actions') }}</th>
                            </tr>
                        </thead>
                        <tbody>
                        <?php if (isset($marcas)): ?>
                        <?php foreach ($marcas as $marca): ?>
                        <tr>
                            <td>
                                <a href="{{ route('admin.productos.marca.edit', [$marca->id]) }}">
                                    {{ $marca->codigo }}
                                </a>
                            </td>

                            <td>
                                <a href="{{ route('admin.productos.marca.edit', [$marca->id]) }}">
                                    {{ $marca->nombre }}
                                </a>
                            </td>

                            <td>
                                <a href="{{ route('admin.productos.marca.edit', [$marca->id]) }}">
                                    {!! $marca->descripcion !!}
                                </a>
                            </td>
                            <td>
                                <a href="{{ route('admin.productos.marca.edit', [$marca->id]) }}">
                                    {!! $marca->stock !!}
                                </a>
                            </td>

                            <td>
                                <div class="btn-group">
                                    <a href="{{ route('admin.productos.marca.edit', [$marca->id]) }}" class="btn btn-default btn-flat"><i class="fa fa-pencil"></i></a>
                                    <button class="btn btn-danger btn-flat" data-toggle="modal" data-target="#modal-delete-confirmation" data-action-target="{{ route('admin.productos.marca.destroy', [$marca->id]) }}"><i class="fa fa-trash"></i></button>
                                </div>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                        <?php endif; ?>
                        </tbody>
                        <tfoot class="bg-primary">
                            <tr>
                                <th>Codigo</th>
                                <th>Nombre</th>
                                <th>Descripcion</th>
                                <th>Stock</th>
                                <th>{{ trans('core::core.table.actions') }}</th>
                            </tr>
                        </tfoot>
                    </table>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
        </div>
    </div>
    @include('core::partials.delete-modal')
@stop

@section('footer')
    <a data-toggle="modal" data-target="#keyboardShortcutsModal"><i class="fa fa-keyboard-o"></i></a> &nbsp;
@stop
@section('shortcuts')
    <dl class="dl-horizontal">
        <dt><code>c</code></dt>
        <dd>{{ trans('productos::marcas.title.create marca') }}</dd>
    </dl>
@stop

@section('scripts')

    <style type="text/css">

        table.data-table  > thead > tr:nth-child(2)
        {
            display: none;
        }

    </style>

    <script type="text/javascript">
        $( document ).ready(function()
        {

            $("#marca").on("keyup",function()
            {
                $("[id='Nombre']").val( $(this).val() ).keyup();
            });

        });
    </script>

    <script type="text/javascript">
        $(function ()
        {

            var table = $('.data-table').DataTable({
                "paginate": true,
                "lengthChange": true,
                "filter": true,
                "sort": true,
                "info": true,
                "autoWidth": true,
                "order": [[ 1, "asc" ]],
                language: {
                    processing:     "Procesando...",
                    search:         "Buscar",
                    lengthMenu:     "Mostrar _MENU_ Elementos",
                    info:           "Mostrando de _START_ a _END_ registros de un total de _TOTAL_ registros",
                    infoEmpty:      "Mostrando 0 registros",
                    infoFiltered:   ".",
                    infoPostFix:    "",
                    loadingRecords: "Cargando Registros...",
                    zeroRecords:    "No existen registros disponibles",
                    emptyTable:     "No existen registros disponibles",
                    paginate: {
                        first:      "Primera",
                        previous:   "Anterior",
                        next:       "Siguiente",
                        last:       "Ultima"
                    }
                }
            });

            $('.data-table tfoot th').each( function ()
            {
                $(this).html( '<input type="text" id="'+( $(this).text().trim() )+'" class="inputDatatable" placeholder="Search '+$(this).text()+'" />' );
            });
            $('.data-table').DataTable().columns().every( function ()
            {
                var that = this;

                $( 'input', that.footer() ).on( 'keyup change', function ()
                {
                    if ( that.search() !== this.value )
                    {
                        that
                        .search( this.value )
                        .draw();
                    }
                });
            });
            $('.data-table tfoot tr').appendTo('.data-table thead');

            $(document).keypressAction({actions: [{ key: 'c', route: "{{ route('admin.productos.marca.create') }}" }]});
        });
    </script>
@stop
