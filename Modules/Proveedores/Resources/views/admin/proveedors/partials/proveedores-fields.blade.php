<div class="box-body">
  <div class="col col-lg-12 col-md-12">
    {!! Form::normalInput('razon_social', 'Nombre o Razon Social', $errors, $proveedor, array('required' => 'required')) !!}
  </div>
  <div class="col col-lg-12 col-md-12">
    {!! Form::normalInput('ruc', 'RUC', $errors, $proveedor) !!}
  </div>
  <div class="col col-lg-6 col-md-6">
    {!! Form::normalInput('telefono', 'Teléfono', $errors, $proveedor) !!}
  </div>
  <div class="col col-lg-6 col-md-6">
    {!! Form::normalInput('celular', 'Celular', $errors, $proveedor) !!}
  </div>
  <div class="col col-lg-12 col-md-12">
    {!! Form::normalInput('direccion', 'Dirección', $errors, $proveedor) !!}
  </div>
  <div class="col col-lg-12 col-md-12">
    <div class="form-group {!! $errors->first('email',  'has-error') !!}">
      {!! Form::label('email', 'Email', array('class' => 'mylabel')) !!}
      {!! Form::email('email', $proveedor->email, array('id' => 'email', 'class' => 'form-control', 'placeholder' => 'Email')) !!}
      {!! $errors->first('email', '<p class="help-block">:message</p>') !!}
    </div>
  </div>
  <div class="col col-lg-12 col-md-12">
    {!! Form::normalInput('contacto', 'Contacto', $errors, $proveedor) !!}    
  </div>
</div>