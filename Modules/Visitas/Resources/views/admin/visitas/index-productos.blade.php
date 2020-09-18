@extends('layouts.master')

@section('content-header')
    <h1>
        {{ trans('visitas::visitas.agregar-productos.titulo') }}
    </h1>
    <ol class="breadcrumb">
        <li><a href="{{ route('dashboard.index') }}"><i class="fa fa-dashboard"></i> {{ trans('core::core.breadcrumb.home') }}</a></li>
        <li><a href="{{ route('admin.visitas.visita.index') }}">{{ trans('visitas::visitas.title.visitas') }}</a></li>
        <li class="active">Productos</li>
    </ol>
@stop

@section('styles')
    {!! Theme::script('js/vendor/ckeditor/ckeditor.js') !!}

@stop

@section('content')

    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary container-fluid">

                <div class="row">
                    <div class="col-md-4">
                        <h4><b>Fecha: </b>{{ \Carbon::createFromFormat("Y-m-d", $visita->fecha)->format("d/m/Y") }}</h4>
                    </div>
                    <div class="col-md-4">
                        <h4><b>Usuario: </b>{{ $visita->user_full_name }}</h4>
                    </div>
                    <div class="col-md-2">
                        <br>
                        <a href="{{ $visita->link_edit }}" class="btn btn-primary"><i class="fa fa-pencil"></i>  <b>EDITAR</b></a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <h4><b>Lugar: </b>{{ $visita->lugar }}</h4>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <div class="box box-primary">
        <div class="box-header">
          <div class="row" id="contenedor-filtros">

            {!! Form::open(array('route' => ['admin.productos.producto.index_ajax'],'method' => 'post', 'id' => 'search-form')) !!}

                <div class="col-md-2">
                    {!! Form::normalInput('codigo', 'Codigo:', $errors, null) !!}
                </div >
                <div class="col-md-2 select-categorias"></div>
                <div class="col-md-2">
                    {!! Form::normalInput('marca', 'Marca:', $errors, null) !!}
                </div >

                <div class="col-md-2">
                    {!! Form::normalInput('nombreProducto', 'Producto:', $errors, null) !!}
                </div >

                <div class="col-md-2">
                  <div class="form-group ">
                    <label for="stock">Stock mayor a:</label>
                    <input class="form-control" placeholder="Stock mayor a:" type="number" name="stock" value="0" id="stock">
                  </div>
                </div >


                <div class="col-md-2">
                    <label for="">Estado: </label>
                    <select class="form-control" id="estado" name="estado">
                        <option value='' selected>--</option>
                        <option value='1'>Activo</option>
                        <option value='0' >Inactivo</option>
                    </select>
                </div>
                @if( isset($stock_minimo) )
                    {!! Form::hidden('stock_minimo', $stock_minimo, array('id' => 'stock_minimo')) !!}
                @endif
            {!! Form::close() !!}
          </div>
          <div class="row">
            <div class="col-md-3">
              <button type="button" id="btn-agregar" class="btn btn-warning" name="button">Agregar todos los productos filtrados</button>
            </div>
            <div class="col-md-3">
              <button type="button" id="btn-eliminar" class="btn btn-danger" name="button">Eliminar todos los productos filtrados</button>
            </div>

          </div>

        </div>
        <!-- /.box-header -->
        <div class="box-body table-responsive">
            <table class="data-table table table-bordered table-hover" id="tablaProductos" width="100%">
                <thead class="bg-primary">
                    <tr>
                        <th>Codigo</th>
                        <th>Categoria</th>
                        <th>Marca</th>
                        <th>Nombre</th>
                        <th>Stock</th>
                        <th data-sortable="false">Agregar</th>
                        <th data-sortable="false">Cantidad</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td align="center"></td>
                        <td></td>
                    </tr>
                </tbody>
                <tfoot class="bg-primary">
                <tr>
                    <th>Codigo</th>
                    <th>Categoria</th>
                    <th>Marca</th>
                    <th>Nombre</th>
                    <td>Stock</td>
                    <th data-sortable="false">Agregar</th>
                    <th data-sortable="false">Cantidad</th>
                </tr>
                </tfoot>
            </table>
            <!-- /.box-body -->
        </div>
        <!-- /.box -->



@stop

@section('footer')
    <a data-toggle="modal" data-target="#keyboardShortcutsModal"><i class="fa fa-keyboard-o"></i></a> &nbsp;
@stop
@section('shortcuts')
    <dl class="dl-horizontal">
        <dt><code>b</code></dt>
        <dd>{{ trans('core::core.back to index') }}</dd>
    </dl>
@stop

@section('scripts')

      {!! Theme::script('js/spin.min.js') !!}

  <script type="text/javascript">
      $.fn.dataTable.ext.errMode = 'none';
      $(function ()
      {

          $(document).on("change", "select[name=categoria]" ,function()
          {
              $("#search-form").submit();
          });

          $("#marca").on("keyup",function()
          {
              $("#search-form").submit();
          });

          $("#codigo").on("keyup",function()
          {
              $("#search-form").submit();
          });

          $("#nombreProducto").on("keyup",function()
          {
              $("#search-form").submit();
          });

          $("#estado").on("change",function()
          {
              $("#search-form").submit();
          });

          $("#stock").on("change",function()
          {
              $("#search-form").submit();
          });


          $('#search-form').on('submit', function(e)
          {
              table.draw();
              e.preventDefault();
          });

          var table = $('.data-table').DataTable(
          {
              dom: "<'row'<'col-xs-12'<'col-xs-6'l><'col-xs-6'p>>r>"+
              "<'row'<'col-xs-12't>>"+
              "<'row'<'col-xs-12'<'col-xs-6'i><'col-xs-6'p>>>",
              "deferRender": true,
              processing: true,
              serverSide: true,
              "iDisplayLength": 100,
              "paginate": true,
              "lengthChange": true,
              "filter": true,
              "sort": true,
              "info": true,
              "order": [[ 0, "asc" ]],
              "autoWidth": true,
              ajax:
               {
                  url: '{!! route('admin.visitas.visita.index_productos_ajax',$visita->id) !!}',
                  type: "POST",
                  headers: {'X-CSRF-TOKEN': '{{ csrf_token() }}'},
                  data: function (e)
                  {
                      e.categoria = $("select[name=categoria]").val();
                      e.marca = $('#marca').val();
                      e.codigo = $('#codigo').val();
                      e.nombre = $('#nombreProducto').val();
                      e.activo = $('#estado').val();
                      e.stock = $('#stock').val();
                  },
                  "dataSrc": function ( json )
                  {

                      if( $(".select-categorias").html() == '' )
                      {
                          var element_content = '{!!  php_to_js(

                                                      '<label for="categoria" class="control-label" >Categoria:</label>
                                                          <select name="categoria" class="form-control">
                                                              <option value="">--</option>'
                                                  )
                                                  !!}';

                          element_content = element_content.replace(/(?:\r\n|\r|\n)/g, '');

                          json.categorias.forEach(function(item, index)
                          {
                              element_content += '<option value="' + item.id + '">' + item.nombre  + '</option>';
                          });

                          element_content += '</select>';

                          $(".select-categorias").html(element_content);
                      }


                      return json.data;
                  }
              },
              columns:
              [
                  { data: 'codigo', name: 'codigo' },
                  { data: 'categoria' , name: 'categoria' },
                  { data: 'marca', name: 'marca' },
                  { data: 'nombre', name: 'nombre' },
                  { data: 'stock', name: 'stock' },
                  { data: 'agregar', name: 'agregar' },
                  { data: 'cantidad', name: 'cantidad' },
              ],

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
        });

        <?php
                function php_to_js( $code ){return trim(preg_replace('/\s\s+/', ' ', htmlspecialchars_decode($code)));}
        ?>

        $('.data-table').on("click", "tbody tr input[type='checkbox']", function(e)
        {
            e.stopImmediatePropagation();
            id = $(this).val();
            if ($(this).is(":checked"))
                save_producto(id, 'add');
            else
                save_producto(id, 'delete');
        });



        function save_producto(id, action)
        {
            $.ajax({
                type: 'POST',
                url: '{!! route('admin.visitas.visita.save-producto') !!}',
                headers: {'X-CSRF-TOKEN': '{{ csrf_token() }}'},
                data: {'visita_id': {{ $visita->id }},  'producto_id':id, 'action':action},
                success: function(result)
                {
                    if(result.status == 'Ok'){
                      var input_cantidad = $('#cantidad-producto-' + result.producto_id);
                      if(result.action == 'add'){
                        input_cantidad.prop('disabled', false);
                        input_cantidad.val(result.cantidad);
                        input_cantidad.focus().select();
                      }else{
                        input_cantidad.val(result.cantidad);
                        input_cantidad.prop('disabled', true);
                      }
                    }else{
                      alert(result.message)
                    };
                }
            });
        }



        $('.data-table').on("change", "tbody tr input[type='text']", function(e)
        {
            e.stopImmediatePropagation();
            id = $(this).attr("id").split("-")[2];
            cantidad = $(this).val();
            edit_producto(id,cantidad);
        });

        function edit_producto(id, cantidad)
        {
            $.ajax({
                type: 'POST',
                url: '{!! route('admin.visitas.visita.edit-producto') !!}',
                headers: {'X-CSRF-TOKEN': '{{ csrf_token() }}'},
                data: {'visita_id': {{ $visita->id }},  'producto_id':id, 'cantidad':cantidad},
                success: function(result)
                {
                    if(result.status != 'Ok'){
                      alert(result.message)
                    }
                }
            });
        }

        $('#btn-agregar').on("click", function(){
          save_productos_filtrados('add');
        });

        $('#btn-eliminar').on("click", function(){
          save_productos_filtrados('delete');
        });


        function save_productos_filtrados(action)
        {
            var target = document.getElementById('contenedor-filtros');
            var spinner = new Spinner().spin()
            target.appendChild(spinner.el)
            $.ajax({
                type: 'POST',
                url: '{!! route('admin.visitas.visita.save-productos-filtrados') !!}',
                headers: {'X-CSRF-TOKEN': '{{ csrf_token() }}'},
                data: {'visita_id': {{ $visita->id }},
                      'action': action,
                      'categoria': $("select[name=categoria]").val(),
                      'marca': $('#marca').val(),
                      'codigo': $('#codigo').val(),
                      'nombre': $('#nombreProducto').val(),
                      'activo': $('#estado').val(),
                      'stock': $('#stock').val(),
                      },
                success: function(result)
                {
                    if(result.status == 'Ok'){
                      spinner.stop();
                      $("#search-form").submit();
                    }else{
                      spinner.stop();
                      $("#search-form").submit();
                    };
                }
            });
        }


    </script>
@stop
