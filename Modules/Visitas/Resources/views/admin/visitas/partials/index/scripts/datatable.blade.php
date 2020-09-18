<script type="text/javascript" charset="utf-8">
	var table = $('.data-table').DataTable
	({
      	dom: "<'row'<'col-xs-12'<'col-xs-6'l><'col-xs-6'p>>r>"+
        "<'row'<'col-xs-12't>>"+
        "<'row'<'col-xs-12'<'col-xs-6'i><'col-xs-6'p>>>",
        "deferRender": true,
        processing: true,
        serverSide: true,
        "order": config.datatable.order,
        "paginate": true,
        "lengthChange": true,
        "iDisplayLength": config.datatable.default_datas_count,
        "filter": true,
        "sort": true,
        "info": true,
        "autoWidth": true,
        "paginate": true,
        //"drawCallback": reordenar_celdas(),
        ajax: 
        {
            url: config.datatable.ajax_source,
            type: "POST",
            headers: {'X-CSRF-TOKEN': '{{ csrf_token() }}'},
            data: config.datatable.send_request,
            "dataSrc": config.datatable.data_source,
        },
        columns: config.datatable.columns,
        language: 
        {
            processing:     "Procesando...",
            search:         "Buscar",
            lengthMenu:     "Mostrar _MENU_ Elementos",
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