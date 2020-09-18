<script type="text/javascript">
	function calculate_all_agregar_item()
	{
		var cantidad = parseFloat( INPUT_CANTIDAD.val() );
		var precio_unitario = parseFloat( INPUT_PRECIO_UNITARIO.val() );
		var precio_total = parseInt( cantidad*precio_unitario );
		//console.log("cantidad = "+cantidad+" precio_unitario = "+precio_unitario+" precio_total = "+precio_total);
		INPUT_PRECIO_TOTAL.val( precio_total );
	}

	function actualizar()
	{
		var error_message = errors();
		if( error_message == "" )
			FORMULARIO_AGREGAR_ITEM.submit();
		else
			show_aviso_modal( error_message );
	}

	function errors()
	{
		mensaje = "";

		if( SELECT_TIPO.val() == "producto" && INPUT_PRODUCTO_ID.val() == "" )
			mensaje += "-No se selecciono ningun producto.";
		else if( SELECT_TIPO.val() == "servicio" && INPUT_SERVICIO_ID.val() == "" )
			mensaje += "-No se selecciono ningun servicio.";

		if( INPUT_CANTIDAD.val() == "" )
			mensaje += "<br>-La cantidad es requerida.";

		if( INPUT_PRECIO_UNITARIO.val() == "" )
			mensaje += "<br>-El Precio Unitario es requerido.";

		return mensaje;
	}

	function button_agregar_item_was_clicked()
	{
		MODAL_AGREGAR_ITEM.modal("show");
	}

	function select_tipo_was_changed( select_tipo_value )
	{
		GROUP_HIDDENS_ID.find('input').val('');
		GROUP_DESCRIPTION.show().find('input').val('');

		if( select_tipo_value == 'producto' )
			set_producto_autocomplete( INPUT_DESCRIPCION );
		else
			set_servicio_autocomplete( INPUT_DESCRIPCION );

		TEXT_ITEM_SELECTED.text('');
	}

	function set_producto_autocomplete( element )
	{
        set_autocomplete( element, '{!! route('admin.productos.producto.search_producto') !!}', INPUT_PRODUCTO_ID )
	}

	function set_servicio_autocomplete( element )
	{
        set_autocomplete( element, '{!! route('admin.servicios.servicio.search_servicio') !!}', INPUT_SERVICIO_ID )
	}

	function set_autocomplete( element, any_source, input_target_id )
	{
		element = remove_autocomplete( element );
		element.autocomplete
		({
            source: any_source,
            minLength: 1,
            select: function(event, ui)
            {
            	TEXT_ITEM_SELECTED.text( "seleccionado: "+ui.item.value );
                INPUT_PRECIO_UNITARIO.val(ui.item.precio);
                input_target_id.val(ui.item.id);
                calculate_all_agregar_item();
            }
        });
	}

	function remove_autocomplete( element )
	{

		if ( element.data('uiAutocomplete') )
		  	element.autocomplete("destroy");
		return element;
	}

	function show_aviso_modal( mensaje )
	{
		MODAL_AVISO_MENSAJE.html( mensaje );
		MODAL_AVISO.modal("show");
	}
	function hide_aviso_modal()
	{
		MODAL_AVISO.modal("hide");
		INPUT_DESCRIPCION.focus();
	}

	function select_set_first_option( select_element )
	{
		select_element.prop('selectedIndex',0);
	}

	function key_was_presed(event)
	{
		if(event.keyCode == 13) 
			key_enter_was_presed(event);
	}
	function key_enter_was_presed(event)
	{
		if( event.target.id == INPUT_DESCRIPCION.attr("id") && SELECT_TIPO.val() == "producto" )
	    {
	        event.preventDefault();
	        enter_was_presed_on_descripcion( $(event.target) );
	    }
	    else if( event.target.id == INPUT_PRECIO_UNITARIO.attr("id") )
	    	actualizar();
	    else if( event.target.id == MODAL_AVISO.attr("id") )
	        hide_aviso_modal()
	}

    function enter_was_presed_on_descripcion( element )
    {
        get_produto_by_codigo( element );
    }

    function lector_has_producto(response)
    {
        TEXT_ITEM_SELECTED.text( "seleccionado: "+response.value );
        INPUT_PRECIO_UNITARIO.val( response.precio );
        INPUT_PRODUCTO_ID.val( response.id) ;
        INPUT_DESCRIPCION.val( response.value )
        INPUT_CANTIDAD.focus( );
        calculate_all_agregar_item();
    }

    function get_produto_by_codigo( element )
    {
        var codigo = element.val();
        if( codigo != '' )
        {
            var params = "?codigo="+codigo+"&from_lector";
            var url = '{{ url('backend/productos/productos/search_producto') }}'+params;
            $.get
            ( 
                url, 
                function( data )
                {
                    var response = data[0];
                    if( response.status == "OK" )
                        lector_has_producto(response);
                    else
                        show_aviso_modal( response.message );
                }
            );
        }
    }
</script>
