<div class="box-body">
    <div class="row">
        <div class="col-md-4">
          {!! Form::normalSelect('categoria_id', 'Categoria', $errors, $categorias, array('required' => 'required')) !!}
        </div>

        <div class="col-md-4">
          {!! Form::normalSelect('marca_id', 'Marca', $errors, $marcas, array('required' => 'required')) !!}
        </div>
    </div>
    <div class="row">
      <div class="col-md-4">
          {!! Form::normalInput('nombre', 'Nombre', $errors, array('required' => 'required')) !!}
      </div>
      <div class="col-md-4">
          {!! Form::normalInput('codigo', 'Codigo', $errors, array('required' => 'required')) !!}
      </div>

    </div>

    <div class="row">
        <div class="col-md-4">
            {!! Form::normalInput('precio_compra_promedio', 'Precio de Compra (si hay stock inicial)', $errors) !!}
        </div>
        <div class="col-md-4">
            {!! Form::normalInput('precio_venta', 'Precio de Venta', $errors) !!}
        </div>
        <div class="col-md-4">
            {!! Form::normalInput('precio_venta_mayorista', 'Precio de Venta Mayorista', $errors) !!}
        </div>


    </div>
    <div class="row">
        <div class="col-md-4">
            {!! Form::normalInput('stock_inicial', 'Stock inicial', $errors) !!}
        </div>
        <div class="col-md-4">
            {!! Form::normalInput('stock_minimo', 'Stock Minimo', $errors) !!}
        </div>
        <div class="col-md-4" style="display: none;">
            {!! Form::normalInput('fecha_compra', 'Fecha de Compra', $errors, (object)['fecha_compra' => $fecha_hoy]) !!}
        </div>
    </div>
        {!! Form::normalCheckbox('activo', 'Activo', $errors) !!}

        @include('media::admin.fields.new-file-link-single', [
    'zone' => 'archivo'])

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

            $("#stock_inicial").val(0);

            $("#stock_minimo").val(0);

            $("#activo").prop('checked', true);

            $(window).keydown(function(event)
            {
                if(event.keyCode == 13) {
                  event.preventDefault();
                  //$("#fakesubmit").click();
                  return false;
                }
            });

            $("#stock_inicial").number( true , 1, ',', '.' );
            $("#stock_minimo").number( true , 1, ',', '.' );
            $("#precio_venta").number( true , 0, ',', '.' );
            $("#precio_venta_mayorista").number( true , 0, ',', '.' );
            $("#precio_compra_promedio").number( true , 0, ',', '.' );
            $("#fakesubmit").click(function(event)
            {
                if( $("#stock_inicial").val()=='' )
                    $("#stock_inicial").val(0);

                if( $("#stock_minimo").val()=='' )
                    $("#stock_minimo").val(0);


                $("#stock_inicial").number( true , 0, ',', '' );
                $("#stock_minimo").number( true , 0, ',', '' );
                $("#precio_venta").number( true , 0, ',', '' );
                $("#precio_venta_mayorista").number( true , 0, ',', '' );
                $("#precio_compra_promedio").number( true , 0, ',', '' );

                $("#submit").click();

            });

        });

        $("#precio_venta").keyup(function(){
          $("#precio_venta_mayorista").val(
            Math.round(
              $("#precio_venta").val()*{{ $factor_precio_mayorista }}
            )
          );
        });


</script>
