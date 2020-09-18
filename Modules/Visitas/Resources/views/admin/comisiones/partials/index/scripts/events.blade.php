<script type="text/javascript" charset="utf-8">
	$("select").change(function()
    {
    	refresh_table();
    });
    $(".glyphicon.glyphicon-trash").click(function()
    {
    	$(this).prev('input').val('');
    	table.draw();
    });
    $("body").on("click", ".open-modal", function(event)
    {
    	button_open_modal( $(this) );
    	event.preventDefault();
    });
    
    BUTTON_MODAL_ALERT_YES.click(function()
    {
    	button_modal_alert_yes_was_clicked();
    });
    BUTTON_MARCAR_COMISIONES.click(function()
    {
        button_marcar_comision_was_clicked();
    });
    $("#"+INPUT_FECHA_DESDE.attr("id")+" ,#"+INPUT_FECHA_HASTA.attr("id")).on("dp.change", function (e) 
    {
        refresh_table();
    });
</script>