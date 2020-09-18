<script type="text/javascript" charset="utf-8">
	
	var config = 
	{
		datatable:
		{
			order: [[ 0, "desc" ]],
			ajax_source: '{!! route('admin.visitas.visita.visita_productos_ajax') !!}',
			send_request: function (request) 
            {
                request.visita_id = "{{ $visita->id }}";
            },
            data_source: function ( json ) 
            {
                //$("label[for=saldo_acumulado]").text('Saldo Acumulado hasta el '+json.fecha_inicio);
                //$("input[name=saldo_acumulado]").val(json.saldo_acumulado);
                return json.data;
            },
            columns: 
            [
                { data: "producto.nombre", name: 'producto.nombre'},
                { data: "cantidad", name: 'cantidad'},
                { data: "actions", name: 'actions', orderable: false, searchable: false}
            ],
            default_datas_count: 25




		}//end datatable
	}
    $(document).keypressAction({actions: [{ key: 'b', route: "{{ route('admin.visitas.visita.index') }}" }]});
    $('input[type="checkbox"].flat-blue, input[type="radio"].flat-blue').iCheck({checkboxClass: 'icheckbox_flat-blue',radioClass: 'iradio_flat-blue'});
</script>