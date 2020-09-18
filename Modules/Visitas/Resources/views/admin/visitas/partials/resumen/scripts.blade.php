<script type="text/javascript">
	var MODAL_ALERT = $("#modal-alert");
	var BUTTON_MODAL_ALERT_YES = $("#button-modal-alert-yes");
	$("body").on("click", ".open-modal", function( event )
	{
		button_open_modal( $(this) );
		event.preventDefault();
	});
	BUTTON_MODAL_ALERT_YES.click(function(event)
	{
		button_modal_alert_yes_was_clicked();
		event.preventDefault();
	});
	function button_open_modal( button_open_modal )
    {
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
	function button_modal_alert_yes_was_clicked()
    {
        var method = BUTTON_MODAL_ALERT_YES.attr("method");
        var link = BUTTON_MODAL_ALERT_YES.attr("link");

        update_item( BUTTON_MODAL_ALERT_YES.attr("url") );

        BUTTON_MODAL_ALERT_YES.attr("link", '').attr("method", '');
    }

    function update_item( url )
    {
        $.post( url,
        {
            _token: '{{ csrf_token() }}',
            _method: "put",
            estado: "cerrada"
        },
        function( response )
        {
        	MODAL_ALERT.modal("hide");
        	window.location.replace( '{!! route('admin.visitas.visita.index') !!}' );
        });
    }

    $('.data-table').dataTable
    ({
        "paginate": true,
        "lengthChange": true,
        "filter": true,
        "sort": true,
        "info": true,
        "autoWidth": true,
				"pageLength": 50,
        "order": [[ 0, "asc" ]],
        language:
    	{
            processing:     "Procesando...",
            search:         "Buscar",
            lengthMenu:     "Mostrando _MENU_ Elementos",
            info:           "Mostrando de _START_ a _END_ registros de un total de _TOTAL_ registros",
            //infoEmpty:      "Affichage de l'&eacute;lement 0 &agrave; 0 sur 0 &eacute;l&eacute;ments",
            infoFiltered:   ".",
            infoPostFix:    "",
            loadingRecords: "Cargando Registros...",
            zeroRecords:    "No existen registros disponibles",
            emptyTable:     "No existen registros disponibles",
            paginate:
            {
                first:      "Primera",
                previous:   "Anterior",
                next:       "Siguiente",
                last:       "Ultima"
            }
   	 	}
    });
</script>
