<script type="text/javascript">
    $( document ).ready(function() 
    {
        $('input[type="checkbox"].flat-blue, input[type="radio"].flat-blue').iCheck({checkboxClass: 'icheckbox_flat-blue',radioClass: 'iradio_flat-blue'});
        $(document).keypressAction({actions: [{ key: 'b', route: "{{ route('admin.proveedores.proveedor.index') }}" }]});
    });
</script>