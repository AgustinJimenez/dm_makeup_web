<script type="text/javascript">
	$(document).ready(function()
	{
        $("#"+INPUT_FECHA_DESDE.attr("id")+" ,#"+INPUT_FECHA_HASTA.attr("id")).datetimepicker(
	    {
	        format: 'DD/MM/YYYY',
	        locale: 'es'
	    });
	});
</script>