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
		<div class="form-group ">
			<label for="fecha">Fecha</label>
			<div class="inner-addon right-addon">
				<input class="form-control" placeholder="Fecha" name="fecha" type="text" id="fecha">
				<i class="glyphicon glyphicon-trash" style="color: #337ab7;"></i>
			</div>
		</div>
	</div>
	
	<div class="col-md-3">
		{!! Form::normalSelect("usuario_id", "Usuarios", $errors, $users_lists, null) !!}
	</div>

	<div class="col-md-2">
		{!! Form::normalSelect("estado", "Estado", $errors, ['abierta' => 'Abierta', 'cerrada' => "Cerrada"], null) !!}
	</div>

</div>