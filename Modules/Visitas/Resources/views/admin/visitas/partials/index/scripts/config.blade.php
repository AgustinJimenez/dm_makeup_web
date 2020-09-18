<script type="text/javascript" charset="utf-8">
	
	var config = 
	{
		datatable:
        {
            order: [[ 0, "desc" ]],
            ajax_source: '{!! route('admin.visitas.visita.index_ajax') !!}',
            send_request: function (request) 
            {
                request.fecha = $("#fecha").val();
                request.user_id = $("select[name=usuario_id]").val();
                request.estado = $("select[name=estado]").val();
            },
            data_source: function ( json ) 
            {
                //$("label[for=saldo_acumulado]").text('Saldo Acumulado hasta el '+json.fecha_inicio);
                //$("input[name=saldo_acumulado]").val(json.saldo_acumulado);
                return json.data;
            },
            columns: 
            [
                { data: "fecha", name: 'fecha'},
                { data: "lugar", name: 'lugar'},
                { data: "user.last_name_first_name", name: 'user.last_name_first_name'},
                { data: "estado", name: 'estado'},
                { data: "actions", name: 'actions', orderable: false, searchable: false}
            ],
            default_datas_count: 25




		}//end datatable
	}
    $(document).keypressAction({actions: [{ key: 'b', route: "{{ route('admin.visitas.visita.index') }}" }]});
    $('input[type="checkbox"].flat-blue, input[type="radio"].flat-blue').iCheck({checkboxClass: 'icheckbox_flat-blue',radioClass: 'iradio_flat-blue'});
</script>