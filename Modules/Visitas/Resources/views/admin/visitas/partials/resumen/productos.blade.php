<style type="text/css">
	td, th
	{
		text-align: center;
	}	
</style>
<div class="box box-primary">
	<div class="box-body">
		
		<div class="table-responsive">
			<table class="data-table table table-bordered table-striped table-hover dataTable">
				<thead>
					<tr class="bg-primary">
						<th>Producto</th>
						<th>Retiradas</th>
						<th>Vendidas</th>
						<th>Restantes</th>
					</tr>
				</thead>
				<tbody>
					@foreach ($productos_resumenes as $producto_resumen)
						<tr>
							<td>{{ $producto_resumen['producto'] }}</td>
							<td>{{ $producto_resumen['retiradas'] }}</td>
							<td>{{ $producto_resumen['vendidas'] }}</td>
							<td>{{ $producto_resumen['restantes'] }}</td>
						</tr>
					@endforeach
				</tbody>
			</table>
		</div>

	</div>
</div>


@if($visita->estado == "abierta")
	<div class="box box-primary">
		<div class="box-body">
			<div class="row">
				<div class="col-md-4 col-md-offset-4">
					<div class="text-center">
						<h2>Cerrar Visita</h2>
						<hr>
						{!! Form::Button("Cerrar", array("class" => 'btn btn-danger open-modal', 'link' => $visita->link_update)) !!}
					</div>
				</div>
				
			</div>
		</div>
	</div>
	
@endif