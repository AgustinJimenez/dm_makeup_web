<div class="box-body">
    <p>
        {!! Form::normalInput("fecha", "Fecha", $errors, $visita->fecha?(object)['fecha' => Carbon::createFromFormat("Y-m-d", $visita->fecha)->format("d/m/Y")]:null, array("required" => "required", "size" => "10", "maxlength" => "10")) !!}

        {!! Form::normalInput("lugar", "Lugar", $errors, $visita, array("required" => "required", "size" => "150", "maxlength" => "150")) !!}
		
		@if( $visita->ventas and !$visita->ventas->count() )
            {!! Form::normalSelect("user_id", "Usuario", $errors, $users_lists, $visita ) !!}
        @else
            <div class="row">
                <div class="col-md-12">
                <b>Usuario:</b>   {{ $visita->user_full_name }}   
                </div>
            </div>
		@endif
    </p>
</div>
