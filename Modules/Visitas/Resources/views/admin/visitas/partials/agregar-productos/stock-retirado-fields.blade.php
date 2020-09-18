<?php 
												$debug = false ;
$debug = $debug?"text":"hidden";
?>
<fieldset id="stock-retirado-fieldset">
	<div class="row">
		<div class="col-md-3">
			{!! Form::normalInput('producto', 'Producto', $errors, null) !!}
			<span class="label label-success" id="label-producto-seleccionado"></span>
		</div>

		<div class="col-md-2">
		{!! Form::normalInput('cantidad', 'Cantidad', $errors, null, array("maxlength" => "3", "size" => "3")) !!}
		</div>
		
		<div class="col-md-2">
			<div class="form-group">
				<br>
				{!! Form::Button("Guardar", array("class" => "btn btn-success", "id" => "button-guardar")) !!}
				{!! Form::Button("Reset", array("class" => "btn btn-primary", "id" => "button-reset")) !!}
			</div>
		</div>
	</div>




	{!! Form::$debug("producto_id", null ,array("id" => "producto_id", "class" => "bg-success", "placeholder" => "p id")) !!}
</fieldset>
