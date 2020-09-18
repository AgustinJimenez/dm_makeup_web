<script type="text/javascript">
	$(document).ready(function()
	{
		INPUT_CANTIDAD.number(true, 1, ',', '.');
		INPUT_PRECIO_UNITARIO.number(true, 0, '', '.');
		INPUT_PRECIO_TOTAL.number(true, 0, '', '.');
		@if( \Config::$productos ) 
			set_producto_autocomplete( INPUT_DESCRIPCION );
		@else
			@if( \Config::$servicios )
				set_servicio_autocomplete( INPUT_DESCRIPCION );
			@endif
		@endif
		
	});
</script>
