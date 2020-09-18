<div class="overflow-x:auto;" id="div_tabla">
                                        <br><br><br><br>
                                        <table id="tabla_detalle_venta" class="table table-bordered table-striped table-highlight table-fixed tabla_detalle_venta">
                                            <thead class="bg-primary">
                                                <tr>
                                                    <th class="col-sm-1 text-center" >Tipo</th>
                                                    <th class="col-sm-3 text-center">Seleccion</th>
                                                    <th class="col-sm-1 text-center" style="width: 1%;">Cantidad</th>
                                                    <th class="col-sm-1 text-center" style="width: 5.5%;">IVA</th>
                                                    <th class="col-sm-1 text-center" style="width: 4%;">Precio Unitario</th>
                                                    <!--<th class="col-sm-1 text-center">Precio</th>-->
                                                    <th class="col-sm-1 text-center" style="width: 5%;">Precio Total</th>
                                                    <th class="col-sm-1 text-center" style="width: 2%;">Accion</th>
                                                </tr>
                                            </thead>

                                            <tbody id="venta_detalle" class="">
    
<!--************************************************************************************************************-->
        @if (count($errors) > 0)
        @foreach(old('cantidad') as $key => $val)
                <tr id="{{ $key }}">

                    <td class="col-sm-1" >
                        <select class="form-control tipo" name="tipo[]" id="tipo" >
                            <option value="producto" @if(old ('tipo.'.$key)=='producto')selected @endif >Producto</option>
                            <option value="servicio" @if(old ('tipo.'.$key)=='servicio')selected @endif >Servicio</option>
                        </select>
                        <input type="text" class="form-control input-sm" name="detalle_venta_id[]" id="detalle_venta_id" value="{{old ('detalle_venta_id.'.$key) }}" readonly style="height:3px;width:45px;{{$debug}};display: none;">
                    </td>

                    <td class="col-sm-3 input-group seleccion {!! $errors->first('producto_id.'.$key, 'has-error') !!} {!! $errors->first('servicio_id.'.$key, 'has-error') !!} {!! $errors->first('cristal_id.'.$key, 'has-error') !!}">
                        
                        <div id="divProductos" class="form-group {!! $errors->first('producto_id.'.$key, 'has-error') !!}" style="<?php if(old ('tipo.'.$key)!='producto')echo 'display:none;'?>">
                            
                                <input type="text" class="form-control input-sm producto {!! $errors->first('producto_id.'.$key, 'has-error') !!}" name="nombre_producto[]" id="nombre_producto" value="{{old ('nombre_producto.'.$key) }}" placeholder="Nombre Produto" <?php if(old ('nombre_producto.'.$key!=null)){echo "required=''";}?>>

                                {!! $errors->first('producto_id.'.$key, '<p style="font-size: 10px; color:red;">:message</p>') !!} 
                        </div>

                        <div id="divServicios" style="<?php if(old ('tipo.'.$key)!='servicio')echo 'display:none;'?>" class="form-group ">
                            <input type="text" class="form-control input-sm servicio" name="nombre_servicio[]" id="nombre_servicio" value="{{old ('nombre_servicio.'.$key) }}" placeholder="Nombre Servicio" <?php if(old ('nombre_servicio.'.$key!=null)){echo "required=''";}?>>

                                {!! $errors->first('servicio_id.'.$key, '<p style="font-size: 10px; color:red;">:message</p>') !!}
                        </div>

                        <div class="seleccionID" id="seleccionID" style="{{$debug}}; margin-top: 0%; float:left;">

                            <input type="text" class="form-control input-sm  seleccion " name="producto_id[]" id="producto_id" value="{{old ('producto_id.'.$key) }}" placeholder="p id" readonly style="height:20px;width:40px;display:none;">
                                

                            <input type="text" class="form-control input-sm  seleccion " name="servicio_id[]" id="servicio_id" value="{{old ('servicio_id.'.$key) }}" placeholder="s id" readonly style="height:20px;width:40px;display:none;">
          
                        </div>
                    </td>                   
                
                    <td class="col-sm-1" >
                        <input type="text" value="{{ old ('cantidad.'.$key)  }}" name="cantidad[]" class="form-control input-md cantidad" id="cantidad" placeholder="Cantidad" autocomplete=off required/>
                    </td>
                    <td class="col-sm-1" style="">
                        <select class="form-control iva" name="iva[]" id="iva" >
                            <option value="0" @if( old('iva.'.$key)==0 )selected @endif>0%</option>
                            <option value="21" @if( old('iva.'.$key)==21 )selected @endif>5%</option>
                            <option value="11" @if( old('iva.'.$key)==11 )selected @endif>10%</option>
                        </select>
                    </td>
                
                    <td class="col-sm-1" >
                        <div class="form-group">
                            <input value="{{ old ('precio_unitario.'.$key)  }}" type="text" name="precio_unitario[]" class="form-control input-md precio_unitario" autocomplete=off placeholder="Precio Unitario" id="precio_unitario" required/>
                        </div>
                    </td>

                    <td class="col-sm-1" >
                        <input value="{{ old ('precio_total.'.$key)  }}" type="text" name="precio_total[]" class="form-control input-md sub_total" placeholder="Precio Total" id="sub_total" readonly="" >
                    </td>


                    <td class="col-sm-1">
                        <i class="glyphicon glyphicon-trash btn btn-danger remove_field"></i>
                    </td>


                </tr>
            @endforeach
    @endif
    <!--************************************************************************************************************-->
                                <!--  FROM DETALLES  -->
    <!--************************************************************************************************************-->
        @if (isset($detalles) && !count($errors) > 0 )
        @foreach($detalles as $key => $detalle)
                <tr id="{{ $key }}">

                    <td class="col-sm-1" >
                        
                        <select class="form-control tipo" name="tipo[]" id="tipo" >
                            <option value="producto" @if($detalle->producto_id)selected @endif >Producto</option>
                            <option value="servicio" @if($detalle->servicio_id)selected @endif >Servicio</option>
                        </select>
                        <input type="text" class="form-control input-sm" name="detalle_venta_id[]" id="detalle_venta_id" value="{{ $detalle->id }}" readonly style="height:3px;width:45px;{{$debug}};display: none;">
                        <input type="text" class="eliminar" name="eliminar[]" id="eliminar" value="0" readonly style="height:30px;width:45px;display:none;">
                    </td>

                    <td class="col-sm-3 input-group seleccion">
                        
                        <div id="divProductos" class="form-group" style="<?php if(!$detalle->producto_id)echo 'display:none;'?>">
                            <input type="text" class="form-control input-sm producto" name="nombre_producto[]" id="nombre_producto" <?php if($detalle->producto_id){ echo "value='".$detalle->descripcion_producto . "' required=''" ;}?>  placeholder="Nombre Produto">
                        </div>

                        <div id="divServicios" style="<?php if(!$detalle->servicio_id)echo 'display:none;'?>" class="form-group ">
                            <input type="text" class="form-control input-sm servicio" name="nombre_servicio[]" id="nombre_servicio" <?php if($detalle->servicio_id){echo "value='".$detalle->servicio->nombre."' required='' " ;}?> placeholder="Nombre Servicio" >
                        </div>

                        <div class="seleccionID" id="seleccionID" style="{{$debug}}; margin-top: 0%; float:left;">

                            <input type="text" class="form-control input-sm  seleccion " name="producto_id[]" id="producto_id" value="<?php if($detalle->producto_id)echo $detalle->producto->id ;?>" placeholder="p id" readonly style="height:20px;width:40px;display:none;">
                                

                            <input type="text" class="form-control input-sm  seleccion " name="servicio_id[]" id="servicio_id" value="<?php if($detalle->servicio_id)echo $detalle->servicio->id ;?>" placeholder="s id" readonly style="height:20px;width:40px;display:none;">
                                        
                        </div>
                    </td>                   
                
                    <td class="col-sm-1" style="width: 1%;">
                        <input type="text" value="{{ $detalle->wformat('cantidad') }}" name="cantidad[]" class="form-control input-md cantidad" id="cantidad" placeholder="Cantidad"  autocomplete=off required/>
                    </td>
                    <td class="col-sm-1" style="width: 5.5%;">
                        <select class="form-control iva" name="iva[]" id="iva" >
                            <option value="0" @if( $detalle->iva==0 )selected @endif>0%</option>
                            <option value="21" @if( $detalle->iva==21 )selected @endif>5%</option>
                            <option value="11" @if( $detalle->iva==11 )selected @endif>10%</option>
                        </select>
                    </td>
                
                    <td class="col-sm-1" style="width: 4%;">
                        <div class="form-group">
                            <input value="{{ $detalle->precio_unitario }}" type="text" name="precio_unitario[]" class="form-control input-md precio_unitario" autocomplete=off placeholder="Precio Unitario" id="precio_unitario" required/>
                        </div>
                    </td>

                    <td class="col-sm-1" style="width: 5%;">
                        <input value="{{ $detalle->precio_total }}" type="text" name="precio_total[]" class="form-control input-md sub_total" placeholder="Precio Total" id="sub_total" readonly="" >
                    </td>


                    <td class="col-sm-1" style="width: 2%;">
                        @if(!$detalle)
                            <i class="glyphicon glyphicon-trash btn btn-danger remove_field_eliminar"></i>
                        @endif
                    </td>


                </tr>
            @endforeach
    @endif
    <!--************************************************************************************************************-->

        

<?php /*----------------------------------------------------------------------------------------------------------------------------*/
    $columnTipo = '<td class="col-sm-1" >
                        <select class="form-control tipo" name="tipo[]" id="tipo" >
                            <option value="producto" checked>Producto</option>
                            <option value="servicio" >Servicio</option>
                            
                        </select>
                        <input type="text" class="form-control input-sm" name="detalle_venta_id[]" id="detalle_venta_id" value="" readonly style="height:3px;width:45px;display:nne;">
                    </td>';
    ?>

<?php  /*----------------------------------------------------------------------------------------------------------------------------*/
$columnSeleccion = '<td class="col-sm-3 input-group">
                        
                        <div id="divProductos" class="form-group" >

                            <input type="text" class="form-control input-sm producto" name="nombre_producto[]" id="nombre_producto" value="" placeholder="Nombre Produto" required="">
                        </div>

                        <div id="divServicios" style="display:none;" class="form-group">

                            <input type="text" class="form-control input-sm servicio" name="nombre_servicio[]" id="nombre_servicio" value="" placeholder="Nombre Servicio" >
                        </div>

                    <div class="seleccionID" id="seleccionID" style="display:noe; margin-top: 0%; float:left;">

                        <input type="text" class="form-control input-sm  seleccion" name="producto_id[]" id="producto_id" value="" placeholder="p id" readonly style="height:20px;width:40px;display:noe;">

                        <input type="text" class="form-control input-sm  seleccion" name="servicio_id[]" id="servicio_id" value="" placeholder="s id" readonly style="height:20px;width:40px;display:noe;">

                    </div>
                </td>';?>                    


                                                
<?php /*----------------------------------------------------------------------------------------------------------------------------*/
     $columnDetalleCristal='';?>
                                                
<?php /*----------------------------------------------------------------------------------------------------------------------------*/
    $columnCantidad = '<td class="col-sm-1" style="width: 1%;">
                            <input type="text" name="cantidad[]" class="form-control input-md cantidad" id="cantidad" placeholder="Cantidad" autocomplete=off required/>
                        </td>';
?>
                                                
<?php /*----------------------------------------------------------------------------------------------------------------------------*/
    $columnIva = '<td class="col-sm-1" style="width: 5.5%;">
                            <select class="form-control iva" name="iva[]" id="iva" >
                                <option value="0" >0%</option>
                                <option value="21" >5%</option>
                                <option value="11" selected>10%</option>
                            </select>
                        </td>';
?>
                                                
<?php /*----------------------------------------------------------------------------------------------------------------------------*/
     $columnPrecioUnitario = '<td class="col-sm-1" style="width: 4%;">
                                <div class="form-group">
                                    <input type="text" name="precio_unitario[]" class="form-control input-md precio_unitario" autocomplete=off placeholder="Precio Unitario" id="precio_unitario" required/>
                                </div>
                            </td>';
?>
             
<?php /*----------------------------------------------------------------------------------------------------------------------------*/
 $columnPrecioTotal = '';?>
                                                
<?php /*----------------------------------------------------------------------------------------------------------------------------*/
 $columnSubTotal = '<td class="col-sm-1" style="width: 5%;">
                            <input type="text" name="precio_total[]" class="form-control input-md sub_total" placeholder="Precio Total" id="sub_total" readonly="">
                        </td>';
?>

<?php /*----------------------------------------------------------------------------------------------------------------------------*/
$columnAccion = '<td class="col-sm-1" style="width: 2%;">
                            <i class="glyphicon glyphicon-trash btn btn-danger remove_field"></i>
                        </td>';?>
                            

                                            </tbody>
         
                                            <tfoot>
                                                <tr>
                                                    <th colspan="4">
                                                        <td colspan="0">
                                                            <strong>Descuento</strong>
                                                        </td>
                                                        <td colspan="1">
                                                            <input type="text" name="descuento_total" value="{{ old('descuento_total', $venta->descuento_total) }}"  autocomplete=off class="form-control input-md descuento_total" id="descuento_total" >
                                                            
                                                        </td>
                                                    </th>
                                                </tr>
                                                <tr>
                                                    <th colspan="4">
                                                        <td colspan="0">
                                                            <strong>Monto total</strong>
                                                        </td>
                                                        <!--
                                                        <td colspan="1">
                                                            <input type="text" name="monto_total_table" autocomplete=off class="form-control input-md monto_total" id="monto_total_table" readonly/>
                                                        </td>
                                                        -->
                                                        <td colspan="1">
                                                            <input type="text" name="monto_total_tabla" value="{{ old('monto_total_tabla') }}"  autocomplete=off class="form-control input-md monto_total_iva" id="monto_total_iva" readonly/>
                                                        </td>
                                                    </th>
                                                    
                                                </tr>
                                            </tfoot>
                                        </table>
                                        @if(!isset($venta))
                                        <div class="form-group" style="margin-left:1%;" >
                                            <a href="#" id="agregar" class="btn btn-primary btn-flat">Agregar Detalle</a>
                                        </div>
                                        @endif
                                    </div>
                @include('ventas::admin.ventas.venta_script')