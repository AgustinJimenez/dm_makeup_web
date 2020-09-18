<div class="modal fade modal-danger" id="alert-modal" tabindex="-1" role="dialog" aria-labelledby="alert-title" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="delete-confirmation-title">Confirmación</h4>
            </div>

            <div class="modal-body" id="modal-alert-body">
                
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-outline btn-flat" data-dismiss="modal" id="modal-alert-atras">Atras</button>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript">
    $(window).keydown(function(event)
    {
        if(event.keyCode == 13) 
        {
            if( event.target.id == 'nombre_producto' )
            {
                event.preventDefault();
                enter_was_presed_on_descripcion( $(event.target) );
            }
            else if( event.target.id == 'alert-modal' )
            {
                $("#alert-modal").modal("hide");
            }
            else
            {
                event.preventDefault();
                $("#agregar").click();
            }
        }
    });

    function enter_was_presed_on_descripcion( element )
    {
        get_produto_by_codigo( element );
    }

    function mostrar_modal_alerta( message, extra_bag )
    {
        $("#modal-alert-body").html(message);
        $("#alert-modal").modal("show");
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
                        element.val( response.value )
                        .closest('tr').find('.precio_unitario').val( response.precio )
                        .closest('tr').find('#producto_id').val(response.id)
                        .closest('tr').find(".cantidad").focus();
                    else
                        mostrar_modal_alerta( response.message, {element:element} );
                }
            );
        }
    }

</script>