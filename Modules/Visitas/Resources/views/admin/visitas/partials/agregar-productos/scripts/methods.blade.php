<script type="text/javascript">
	function log( data ){return console.log(data);}

	function set_autocomplete(element)
	{
		element.autocomplete(
        {
            source: function(request, response) 
            {
                $.ajax
                ({
                    url: '{!! route('admin.productos.producto.search_producto') !!}',
                    dataType: "json",
                    data: 
                    {
                        term: INPUT_PRODUCTO.val(),
                        visita_id: '{{ $visita->id }}'
                    },
                    success: function(data) 
                    {
                        response(data);
                    }
                });
            },
            minLength: 1,
            select: function(event, ui)
            {
                set_producto_datas( ui.item.id, ui.item.value );
            }

        });
	}

    function set_producto_datas( producto_id, label, producto_descripcion = null )
    {
        INPUT_PRODUCTO_ID.val( producto_id );
        LABEL_PRODUCTO_SELECCIONADO.html( label );
        if( producto_descripcion )
            INPUT_PRODUCTO.val(producto_descripcion);
    }

    function save()
    {
        var errors = validate();
        if(!errors)
            submit();
            //submit();
        else
            show_alert_modal(errors);
    }

    function serialize_fieldset( fieldset_element )
    {
        var element = "#" + fieldset_element.attr("id") + " :input";
        var token = "&_token="+'{{ csrf_token() }}';
        var flag = "&store_visita_producto";
        var visita_id = "&visita_id="+'{{ $visita->id }}';
        return $(element).serialize()+token+flag+visita_id;
    }

    function data_was_not_saved( response )
    {
        show_alert_modal( "Ocurrio un error al intentar guardar." );
    }

    function refresh_table()
    {
        table.draw();
    }

    function data_was_saved( response )
    {
        reset_inputs();
        refresh_table();
        INPUT_PRODUCTO.focus();
    }

    function submit()
    {
        $.post(
        "{{ route('admin.visitas.visita.visita_productos_ajax') }}",
        serialize_fieldset( FIELDSET_STOCK_RETIRADO ),
        function( response )
        {
            if( response.status == "OK" )
                data_was_saved( response );
            else
                data_was_not_saved( response );
        });
    }

    function reset_inputs()
    {
        FIELDSET_STOCK_RETIRADO.find("input").val('');
        LABEL_PRODUCTO_SELECCIONADO.html("");
    }
    
    function button_modal_alert_yes_was_clicked()
    {
        var method = BUTTON_MODAL_ALERT_YES.attr("method");
        var link = BUTTON_MODAL_ALERT_YES.attr("link");

        if(method == 'delete')
            delete_item( BUTTON_MODAL_ALERT_YES.attr("url") );

        BUTTON_MODAL_ALERT_YES.attr("link", '').attr("method", '');
    } 

    function key_was_presed(event)
    {
        if(event.keyCode == 13) 
            key_enter_was_presed(event);
    }

    function key_enter_was_presed(event)
    {
        if( event.target.id == INPUT_PRODUCTO.attr("id") )
        {
            event.preventDefault();
            enter_was_presed_on_input_producto( $(event.target) );
        }
        else if( event.target.id == INPUT_CANTIDAD.attr("id") )
            BUTTON_GUARDAR.click();
        else if( event.target.id == MODAL_ALERT.attr("id") )
            hide_alert_modal();
    }

    function enter_was_presed_on_input_producto( element )
    {
        get_produto_by_codigo( element );
    }

    function get_produto_by_codigo( element )
    {
        var codigo = element.val();
        if( codigo != '' )
        {
            var params = "?codigo="+codigo+"&visita_id="+{{ $visita->id }}+"&from_lector";
            var url = '{{ url('backend/productos/productos/search_producto') }}'+params;
            $.get
            ( 
                url, 
                function( data )
                {
                    var response = data[0];
                    if( response.status == "OK" )
                        lector_has_producto( response );
                    else
                        show_alert_modal( response.message );
                }
            );
        }
    }

    function lector_has_producto(response)
    {
        set_producto_datas( response.id, "seleccionado: "+response.value, response.value );
        INPUT_CANTIDAD.focus();
    }

    function delete_item( url )
    {
        $.post( url,
        {
            _token: '{{ csrf_token() }}',
            _method: "delete"
        },
        function( response )
        {
            if( response.status == "OK" )
            {
                refresh_table();
                MODAL_ALERT.modal("hide");
            }
            else
            {
                show_alert_modal(response.message);
            }
        });
    }

    function button_open_modal( button_open_modal )
    {
        if( button_open_modal.attr('method') == "delete" )
            show_alert_modal( "Seguro que desea eliminar el registro?", { yes_button:true, link:button_open_modal.attr("link"), method:button_open_modal.attr("method") } );

    }
    function hide_alert_modal()
    {
        MODAL_ALERT.modal("hide");
    }

    function show_alert_modal( message, extra_bag = { yes_button: false, link:"#", method:"none" } )
    {
        var modal_body_element = "#"+MODAL_ALERT.attr("id")+" .modal-body";

        $( modal_body_element ).html( message );

        if( extra_bag.yes_button )
            BUTTON_MODAL_ALERT_YES.show().attr("url", extra_bag.link ).attr("method", extra_bag.method );
        else
            BUTTON_MODAL_ALERT_YES.hide().attr("url", extra_bag.link ).attr("method", extra_bag.method );

        MODAL_ALERT.modal("show");
    } 

    function validate()
    {
        var errors = null;
        if( INPUT_PRODUCTO_ID.val() == "" )
            errors = "\n-No se selecciono correctamente el producto.";

        return errors;
    }
</script>