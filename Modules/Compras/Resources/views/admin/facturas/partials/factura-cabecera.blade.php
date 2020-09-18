    <?php                                   $debug = true;              if($debug) $debug = ''; else $debug = 'display:none;'; ?>
<style type="text/css">
    label[for=monto_total]{display: none;}
    label[for=monto_sub_total]{display: none;}
    label[for="cantidad"]{display: none;}
    label[for="descripcion"]{display: none;}{display: none;}
    label[for="precio_unitario"]{display: none;}
    .input_white
    {
        border:0px;
        font-size:14pt;
        background-color:white;
    }

</style>


    <br>
    <br>
<div class="box-body cabecera">

	<div class="row">

        <div class="form-group col-md-2">
            {!! Form::normalInput('tipo_comprobante', 'Tipo de Comprobante', $errors, $compra, ['disabled' => 'true', 'readonly'=>''])!!}
        </div>


        <div class="form-group col-md-2">
            {!! Form::normalInput('nro_factura', 'Nro de Comprobante', $errors, $compra, ['disabled' => 'true', 'readonly'=>''])!!}
        </div>

        <div class="form-group col-md-2">
                {!! Form::normalInput('tipo_factura', 'Condicion compra', $errors, $compra , ['disabled' => 'true'])!!}
        </div>


        <div class="form-group col-md-2">
            {!! Form::normalInput('fecha', 'Fecha', $errors, (object)['fecha'=>$fecha] , ['disabled' => 'true'])!!}
        </div>




	</div>

	<div class="row">
    <div class="form-group col-md-2">
            {!! Form::normalInput('proveedor', 'Proveedor', $errors, (object)['proveedor' => $compra->proveedor->razon_social], ['disabled' => 'true']) !!}
    </div>

    <div class="form-group col-md-2">

            {!! Form::normalInput('ruc', 'RUC', $errors, (object)['ruc' => $compra->proveedor->ruc] , ['disabled' => 'true'])!!}

    </div>


        <div class="form-group col-md-2">
            {!! Form::normalInput('moneda', 'Moneda', $errors, $compra , ['disabled' => 'true'])!!}
        </div>

        <div class="form-group col-md-2">
            {!! Form::normalInput('cambio', 'Cambio', $errors, $compra , ['disabled' => 'true'])!!}
        </div>

    </div>

</div>

@include('compras::admin.facturas.partials.factura-detalles')

<div class="box-body footer">

    {!! Form::normalInput('monto_total_letras', 'Total a Pagar', $errors, $compra , ['disabled' => 'true'])!!}

    <br>

    <div class="row ">

        <div class="col-sm-4 text-center">
            {!! Form::normalInput('total_iva_5', 'IVA 5%', $errors, $compra ,['style' => 'text-align:center','disabled' => 'true'])!!}
        </div>

        <div class="col-sm-4 text-center">
            {!! Form::normalInput('total_iva_10', 'IVA 10%', $errors, $compra ,['style' => 'text-align:center','disabled' => 'true'])!!}
        </div>

        <div class="col-sm-4 text-center">
            {!! Form::normalInput('total_iva', 'IVA Total', $errors, $compra ,['style' => 'text-align:center','disabled' => 'true'])!!}
        </div>

    </div>

    <br>

    {!! Form::normalInput('observacion', 'Observacion', $errors, $compra , ['disabled' => 'true'])!!}


    {{-- {!! Form:: normalCheckbox('comprobante', 'Comprobante Valido', $errors, $compra, ['disabled' => 'true', 'readonly' => '']) !!} --}}

    <br>


    <br><br>
    @include('compras::admin.facturas.partials.pagos')
    <br>


</div>
