<script type="text/javascript">
	function log( data ){return console.log(data);}

    function refresh_table()
    {
        table.draw();
    }
    function button_marcar_comision_was_clicked()
    {
        show_alert_modal( "Seguro que desea marcar las comisiones listadas como pagadas?", extra_bag = { yes_button: true, link: '{{ route('admin.visitas.comisiones.marcar_comisiones') }}', method: "marcar-comisiones" } )
    }

    function marcar_comisiones( url )
    {
        $.post( url,
        {
            _token: '{{ csrf_token() }}',
            fecha_desde: INPUT_FECHA_DESDE.val(),
            fecha_hasta: INPUT_FECHA_HASTA.val(),
            estado: SELECT_ESTADO.val(),
            user_id: SELECT_USER_ID.val()
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
    
    function button_modal_alert_yes_was_clicked()
    {
        var method = BUTTON_MODAL_ALERT_YES.attr("method");
        var link = BUTTON_MODAL_ALERT_YES.attr("link");

        if(method == 'marcar-comisiones')
            marcar_comisiones( BUTTON_MODAL_ALERT_YES.attr("url") );

        BUTTON_MODAL_ALERT_YES.attr("link", '').attr("method", '');
    }
    function button_open_modal( button_open_modal )
    {
        if( button_open_modal.attr('method') == "delete" )
            show_alert_modal( "Seguro que desea eliminar el registro?", { yes_button:true, link:button_open_modal.attr("link"), method:button_open_modal.attr("method") } );
        else
            show_alert_modal( "Seguro que desea cerrar la visita?", { yes_button:true, link:button_open_modal.attr("link"), method:button_open_modal.attr("method") } );
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
</script>