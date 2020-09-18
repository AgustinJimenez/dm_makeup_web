{!! Theme::script('js/moment.js') !!}
{!! Theme::script('js/moment.es.js') !!}
{!! Theme::script('js/bootstrap-datetimepicker.min.js') !!}
{!! Theme::script('js/bootstrap-datetimepicker.es.js') !!}
{!! Theme::style('css/bootstrap-datetimepicker.min.css') !!}
<script type="text/javascript">
	$(document).keypressAction({actions: [{ key: 'b', route: "{{ route('admin.visitas.visita.index') }}" }]});
    $('#fecha').datetimepicker(
    {
        format: 'DD/MM/YYYY',
        locale: 'es'
    });
</script>