<script type="text/javascript" charset="utf-8">
	
	var config = 
	{
		datatable:
        {
            order: [[ 0, "desc" ]],
            ajax_source: '{!! route('admin.visitas.comisiones.index_ajax') !!}',
            send_request: function ( request ) 
            {
                request.fecha_desde = INPUT_FECHA_DESDE.val();
                request.fecha_hasta = INPUT_FECHA_HASTA.val();
                request.estado = SELECT_ESTADO.val();
                request.user_id = SELECT_USER_ID.val();
            },
            data_source: function ( response ) 
            {
                var monto_total_general = response.monto_total_general;
                THEAD_TH_LAST_MONTO_TOTAL_GENERAL.text( "TOTAL: "+monto_total_general );
                TFOOT_TH_LAST_MONTO_TOTAL_GENERAL.text( "TOTAL: "+monto_total_general );
                TEXT_MONTO_TOTAL.text(monto_total_general);
                if( response.recordsTotal && SELECT_ESTADO.val() == '0')
                    BUTTON_MARCAR_COMISIONES.show();
                else
                    BUTTON_MARCAR_COMISIONES.hide();

                return response.data;
            },
            columns: 
            [
                { data: "fecha_venta", name: 'fecha_venta'},
                { data: "visita.lugar", name: 'visita.lugar'},
                { data: "cliente.razon_social", name: 'cliente.razon_social'},
                { data: "monto_total", name: 'monto_total'}
            ],
            default_datas_count: 25




		}//end datatable
	}
    $('input[type="checkbox"].flat-blue, input[type="radio"].flat-blue').iCheck({checkboxClass: 'icheckbox_flat-blue',radioClass: 'iradio_flat-blue'});
</script>