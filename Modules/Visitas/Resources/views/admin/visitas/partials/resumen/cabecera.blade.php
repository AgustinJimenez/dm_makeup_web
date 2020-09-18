<div class="box box-primary">
	<div class="box-body">
		<div class="row">
			<div class="col-md-12">
				<h4>
					<label>Lugar: </label>  {{ $visita->lugar }}
				</h4>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<h4>
					<label>Fecha: </label>  {{ $visita->fecha_formated }}
				</h4>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<h4>
					<label>Usuario:</label>  {{ $visita->user_full_name }}
				</h4>
			</div>
		</div>
		<div class="row">
			<div class="col-md-2">
				<h4>
					<label>Estado:</label>  {{ $visita->estado }}
				</h4>
			</div>
		</div>
	</div>
</div>