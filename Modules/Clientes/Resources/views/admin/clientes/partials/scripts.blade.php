<script type="text/javascript">
    $( document ).ready(function() 
    {    
    	$("#razon_social").focus();
        $('input[type="checkbox"].flat-blue, input[type="radio"].flat-blue').iCheck({checkboxClass: 'icheckbox_flat-blue',radioClass: 'iradio_flat-blue'});
        $(document).keypressAction({actions: [{ key: 'b', route: "{{ route('admin.clientes.cliente.index') }}" }]});
    });
</script>