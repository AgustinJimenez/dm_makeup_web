<div class="box-body">
    <p>
        {!! Form::normalInput('codigo', 'Codigo', $errors, $categoriaproducto) !!}
        {!! Form::normalInput('nombre', 'Nombre', $errors, $categoriaproducto, array('required' => 'required')) !!}
		{!! Form::normalTextarea('descripcion', 'Descripcion', $errors, $categoriaproducto) !!}
    </p>
</div>
<script type="text/javascript">
	$("#codigo").focus();
</script>