<script type="text/javascript" charset="utf-8">
	BUTTON_GUARDAR.click(function()
	{
		save();
	});
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
	$(window).keydown(function(event)
    {
    	key_was_presed(event);
	});
	BUTTON_RESET.click(function()
	{
		reset_inputs();
	});
</script>