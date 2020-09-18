@extends('layouts.master')

@section('content-header')
    <h1>
        {{ trans('visitas::visitas.resumen.titulo') }}
    </h1>
    <ol class="breadcrumb">
        <li><a href="{{ route('dashboard.index') }}"><i class="fa fa-dashboard"></i> {{ trans('core::core.breadcrumb.home') }}</a></li>
        <li class="active">{{ trans('visitas::visitas.resumen.titulo') }}</li>
    </ol>
@stop

@section('content')
    <div class="row">
        <div class="col-xs-12">
            <div class="row">
                <div class="btn-group pull-right" style="margin: 0 15px 15px 0;">
                
                </div>
            </div>
            @include("visitas::admin.visitas.partials.resumen.cabecera")
            @include("visitas::admin.visitas.partials.resumen.productos")
        </div>
    </div>
    @include("visitas::admin.visitas.partials.modal-alert")
@stop

@section('footer')
    <a data-toggle="modal" data-target="#keyboardShortcutsModal"><i class="fa fa-keyboard-o"></i></a> &nbsp;
@stop
@section('shortcuts')
    <dl class="dl-horizontal">
        <dt><code>c</code></dt>
        <dd>{{ trans('visitas::visitas.title.create visita') }}</dd>
    </dl>
@stop

@section('scripts')
    @include("visitas::admin.visitas.partials.resumen.scripts")
@stop