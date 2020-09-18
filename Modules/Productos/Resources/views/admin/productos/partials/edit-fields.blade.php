<div class="box-body">
    <div class="row">
      <div class="col-md-4">
        {!! Form::normalSelect('categoria_id', 'Categoria', $errors, $categorias, $producto,array('required' => 'required')) !!}
      </div>

      <div class="col-md-4">
        {!! Form::normalSelect('marca_id', 'Marca', $errors, $marcas, $producto, array('required' => 'required')) !!}
      </div>

    </div>

    <div class="row">
      <div class="col-md-4">
          {!! Form::normalInput('nombre', 'Nombre', $errors, $producto, array('required' => 'required')) !!}
      </div>
      <div class="col-md-4">
          {!! Form::normalInput('codigo', 'Codigo', $errors, $producto, array('required' => 'required')) !!}
      </div>
    </div>

    <div class="row">

        <div class="col-md-4">
            @if($permisos->get("Ver Precios de Compra"))
                {!! Form::normalInput('precio_compra_promedio', 'Precio de Compra Promedio', $errors, $producto, ['readonly'=>'']) !!}
            @else
                <dir style="display:none;">
                    {!! Form::normalInput('precio_compra_promedio', 'Precio de Compra Promedio', $errors, $producto, ['readonly'=>'']) !!}
                </dir>
            @endif
        </div>

        <div class="col-md-4">
            {!! Form::normalInput('precio_venta', 'Precio de Venta', $errors, $producto) !!}
        </div>

        <div class="col-md-4">
            {!! Form::normalInput('precio_venta_mayorista', 'Precio de Venta Mayorista', $errors, $producto) !!}
        </div>

    </div>

    <div class="row">
        <div class="col-md-4">
            {!! Form::normalInput('stock', 'Stock', $errors, $producto, ['readonly'=>'']) !!}
        </div>

        <div class="col-md-4">
            {!! Form::normalInput('stock_minimo', 'Stock Minimo', $errors, $producto) !!}
        </div>


        <div class="col-md-4">
            {!! Form::normalInput('stock_inicial', 'Stock Inicial', $errors, $producto,  ['readonly'=>'']) !!}
        </div>

        {{-- <div class="col-md-4">
            {!! Form::normalInput('fecha_compra', 'Ultima Compra', $errors, $producto, ['readonly'=>'']) !!}
        </div> --}}
    </div>
        {!! Form::normalCheckbox('activo', 'Activo', $errors, $producto) !!}

        @include('media::admin.fields.file-link',
        [
	        'entityClass' => 'Modules\\\\Productos\\\\Entities\\\\Producto',
	        'entityId' => $producto->id,
	        'zone' => 'archivo'
      	])


</div>

{!! Theme::script('js/jquery.number.min.js') !!}
{!! Theme::style('css/bootstrap-datetimepicker.min.css') !!}
{!! Theme::script('js/moment.js') !!}
{!! Theme::script('js/moment.es.js') !!}
{!! Theme::script('js/bootstrap-datetimepicker.min.js') !!}
{!! Theme::script('js/bootstrap-datetimepicker.es.js') !!}

<script type="text/javascript">
        $( document ).ready(function()
        {
            $('#fecha_compra').datetimepicker(
            {
                format: 'DD/MM/YYYY',
                locale: 'es'
            });
        @if($permisos->get("Ver Precios de Compra"))
        @endif
            $("#stock").attr('name', 'stock_no_edit');

        	if( $("#stock").val()=='' )
        		$("#stock").val(0);

        	if( $("#stock_minimo").val()=='' )
                $("#stock_minimo").val(0);

            $(window).keydown(function(event)
            {
                if(event.keyCode == 13)
                {
                  event.preventDefault();
                  //$("#fakesubmit").click();
                  return false;
                }
            });

            $("#stock").number( true , 1, ',', '.' );
            $("#stock_minimo").number( true , 1, ',', '.' );
            $("#stock_inicial").number( true , 1, ',', '.' );
            $("#precio_venta").number( true , 0, ',', '.' );
            $("#precio_venta_mayorista").number( true , 0, ',', '.' );
            $("#precio_compra_promedio").number( true , 5, ',', '.' );



            $("#fakesubmit").click(function(event)
            {

                if( $("#stock").val()=='' )
                    $("#stock").val(0);

                if( $("#stock_minimo").val()=='' )
                    $("#stock_minimo").val(0);

                $("#stock_inicial").number( true , 0, ',', '' );
                $("#stock_minimo").number( true , 0, ',', '' );
                $("#stock_inicial").number( true , 0, ',', '' );
                $("#precio_venta").number( true , 0, ',', '' );
                $("#precio_venta_mayorista").number( true , 0, ',', '' );
                $("#precio_compra_promedio").number( true , 0, ',', '' );

                $("#submit").click();

            });

            $("#precio_venta").keyup(function(){
              $("#precio_venta_mayorista").val(
                Math.round(
                  $("#precio_venta").val()*{{ $factor_precio_mayorista }}
                )
              );
            });


        });
</script>
