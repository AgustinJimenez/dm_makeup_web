<style type="text/css">
.inner-addon 
{
   position: relative;
}
.inner-addon .glyphicon 
{
   color:#007f4f ;
   position: absolute;
   padding: 10px;
   cursor: pointer;
}
.left-addon .glyphicon  { left:  0px;}
.right-addon .glyphicon { right: 0px;}
.left-addon input  { padding-left:  30px; }
.right-addon input { padding-right: 30px; }
</style>
<div class="row">
	<div class="col-md-2">
		{!! Form::normalSelect("user_id", "Usuario", $errors, $users_lists) !!}
	</div>

	<div class="col-md-2">
		<div class="form-group ">
			<label for="fecha_desde">Fecha Desde</label>
			<div class="inner-addon right-addon">
				<input class="form-control" placeholder="Fecha Desde" name="fecha_desde" value="{{ $fecha_inicio_mes }}" type="text" id="fecha_desde">
				<i class="glyphicon glyphicon-trash" style="color: #337ab7;"></i>
			</div>
		</div>
	</div>
	<div class="col-md-2">
		<div class="form-group ">
			<label for="fecha_hasta">Fecha Hasta</label>
			<div class="inner-addon right-addon">
				<input class="form-control" placeholder="Fecha Hasta" name="fecha_hasta" value="{{ date("d/m/Y") }}" type="text" id="fecha_hasta">
				<i class="glyphicon glyphicon-trash" style="color: #337ab7;"></i>
			</div>
		</div>
	</div>
	<div class="col-md-2">
		{!! Form::normalSelect("estado", "Estado", $errors, ['0' => "No Pagado", "1" => "Pagado"]) !!}
	</div>
	<div class="col-md-3 text-center">	
		<b>Monto Total</b><p id="text-monto-total"></p>
	</div>
</div>
<div class="row">
	<div class="col-md-offset-8 col-md-2 marcar-comisiones">
		{!! Form::Button("Marcar comisiones como pagadas", array("class" => "btn btn-danger", "id" => "marcar-comisiones")) !!}
	</div>


</div>