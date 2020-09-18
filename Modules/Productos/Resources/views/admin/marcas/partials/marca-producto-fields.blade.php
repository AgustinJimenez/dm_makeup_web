<div class="box-body">
    <p>
        {!! Form::normalInput('codigo', 'Codigo', $errors, $marca) !!}
        {!! Form::normalInput('nombre', 'Nombre', $errors, $marca, array('required' => 'required')) !!}
		{!! Form::normalTextarea('descripcion', 'Descripcion', $errors, $marca) !!}
    </p>
</div>
<script type="text/javascript">
	$("#codigo").focus();
</script>