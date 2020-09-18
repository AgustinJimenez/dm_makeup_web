<div class="box-body">
	<div class="col col-lg-12 col-md-12">
		{!! Form::normalInput('razon_social', 'Nombre o Razon Social', $errors, $cliente, array('required' => 'required')) !!}
	</div>
	<div class="col col-lg-6 col-md-6">
		<div class="form-group {!! $errors->first('cedula',  'has-error') !!}">
			{!! Form::label('cedula', 'Cedula', array('class' => 'mylabel')) !!}
			{!! Form::number('cedula', $cliente->cedula, array('id' => 'cedula', 'class' => 'form-control', 'placeholder' => 'Cedula', 'min' => '1', 'max' => '15000000')) !!}
			{!! $errors->first('cedula', '<p class="help-block">:message</p>') !!}
		</div>
	</div>
	<div class="col col-lg-6 col-md-6">
		{!! Form::normalInput('ruc', 'RUC', $errors, $cliente) !!}
	</div>
	<div class="col col-lg-6 col-md-6">
		{!! Form::normalInput('telefono', 'Teléfono', $errors, $cliente) !!}
	</div>
	<div class="col col-lg-6 col-md-6">
		{!! Form::normalInput('celular', 'Celular', $errors, $cliente) !!}
	</div>
	<div class="col col-lg-12 col-md-12">
		{!! Form::normalInput('direccion', 'Localidad', $errors, $cliente) !!}
	</div>
	<div class="col col-lg-12 col-md-12">
		<div class="form-group {!! $errors->first('email',  'has-error') !!}">
			{!! Form::label('email', 'Email', array('class' => 'mylabel')) !!}
			{!! Form::email('email', $cliente->email, array('id' => 'email', 'class' => 'form-control', 'placeholder' => 'Email')) !!}
			{!! $errors->first('email', '<p class="help-block">:message</p>') !!}
		</div>
	</div>
	<div class="col col-lg-12 col-md-12">
		{!! Form::normalCheckbox('activo', 'Activo', $errors, $cliente) !!}
	</div>
</div>