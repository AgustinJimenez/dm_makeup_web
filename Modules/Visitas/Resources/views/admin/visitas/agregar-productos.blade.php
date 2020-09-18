@extends('layouts.master')

@section('content-header')
    <h1>
        {{ trans('visitas::visitas.agregar-productos.titulo') }}
    </h1>
    <ol class="breadcrumb">
        <li><a href="{{ route('dashboard.index') }}"><i class="fa fa-dashboard"></i> {{ trans('core::core.breadcrumb.home') }}</a></li>
        <li><a href="{{ route('admin.visitas.visita.index') }}">{{ trans('visitas::visitas.title.visitas') }}</a></li>
        <li class="active">Productos</li>
    </ol>
@stop

@section('styles')
    {!! Theme::script('js/vendor/ckeditor/ckeditor.js') !!}
@stop

@section('content')
    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary container-fluid">

                <div class="row">
                    <div class="col-md-4">
                        <h4><b>Fecha: </b>{{ \Carbon::createFromFormat("Y-m-d", $visita->fecha)->format("d/m/Y") }}</h4>
                    </div>
                    <div class="col-md-4">
                        <h4><b>Usuario: </b>{{ $visita->user_full_name }}</h4>
                    </div>
                    <div class="col-md-2">
                        <br>
                        <a href="{{ $visita->link_edit }}" class="btn btn-primary"><i class="fa fa-pencil"></i>  <b>EDITAR</b></a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <h4><b>Lugar: </b>{{ $visita->lugar }}</h4>
                    </div>
                </div>


            </div>
            <div class="box box-primary">
                <div class="box-header">
                    @include('visitas::admin.visitas.partials.agregar-productos.stock-retirado-fields')
                </div>
            </div>
            <div class="box box-primary">
                <!-- /.box-header -->
                <div class="box-body">
                    @include('visitas::admin.visitas.partials.agregar-productos.table')
                </div>
                <!-- /.box -->
            </div>
        </div>
    </div>
    @include("visitas::admin.visitas.partials.modal-alert")
@stop

@section('footer')
    <a data-toggle="modal" data-target="#keyboardShortcutsModal"><i class="fa fa-keyboard-o"></i></a> &nbsp;
@stop
@section('shortcuts')
    <dl class="dl-horizontal">
        <dt><code>b</code></dt>
        <dd>{{ trans('core::core.back to index') }}</dd>
    </dl>
@stop

@section('scripts')
    @include('visitas::admin.visitas.partials.agregar-productos.scripts.main')
@stop
