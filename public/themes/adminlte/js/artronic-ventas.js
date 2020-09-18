    $( document ).ready(function() 
        {
            localStorage.clear();

            $('#entrega').number(true, 0, '', '.');

            $('.total_pagado').number(true, 0, '', '.');

            $('.total_pagar').number(true, 0, '', '.');

            $('#vuelto').number(true, 0, '', '.');

            $('#nro_seguimiento').number(true, 0, '', '');
            
            $('.nro_seguimiento_preventa').number(true, 0, '', '');
            
            $('.nro_seguimiento_preventa').number(true, 0, '', '');

            $('.cantidad').number(true, 0, '', '.');

            $('.precio_unitario').number(true, 0, '', '.');

            $(".select_cristal").chained(".select_categoria_cristal");

            $(".select_tipo_cristal").chained(".select_cristal");

            $('#ojo_izq').attr("required","");

            $('#ojo_der').attr("required","");

            $('#entrega').attr("required","");

            $('#distancia_interpupilar').attr("required","");

            $('#monto_total').prop('readonly', true);

            $('#monto_total_letra').prop('readonly', true);

            $('#total_iva_5').prop('readonly', true);

            $('#total_iva_10').prop('readonly', true);

            $('#total_iva').prop('readonly', true);

            $("#activo").prop('checked',true);

           

            $(window).keydown(function(event)
            {
                if(event.keyCode == 13) 
                {
                  event.preventDefault();
                  $("#agregar").click();
                  
                  return false;
                }
            });

            $('#fecha_venta').datetimepicker(
            {
                format: 'DD/MM/YYYY',
                //format: 'YYYY-MM-DD',
                locale: 'es'
            });
/*---------------------------------------------------------*/
            /*$("#nro_seguimiento").validate({
                    rules: {
                        username: {
                            required: true,
                            minlength: 3,
                            remote: "check-username.php"
                            }
                        },
                    messages: {
                        username:{
                            remote: "This username is already taken! Try another."
                        }
                    }
              });
              */

/*---------------------------------------------------------*/


            $( "#cliente" ).on('change', function(event) 
            {
                if((typeof(id_cliente) == "undefined"))
                {
                    alert('Seleccione correctamente al cliente en la lista desplegable.');
                    //$("#cliente").addClass("invalido");
                    //$("#cliente").removeClass("valido");
                }
                else if( id_cliente )
                {
                    alert('correcto.');
                    //$("#cliente").removeClass("invalido");
                    //$("#cliente").addClass("valido");
                }



                $('#cliente_id').val( id_cliente );
            }); 

            

            $(".total_pagado").on('keyup', function()
            {
                var pago_cliente = $(this).val();

                var total_pagar = $("#total_pagar").val();

                var diferencia = total_pagar-pago_cliente;

                console.log('total a pagar: '+total_pagar+' el cliente pago: '+pago_cliente+' la diferencia es: '+diferencia);

                if( diferencia<0 )
                {
                    $("#vuelto").val( diferencia*-1 );
                }
                else
                {
                    $("#vuelto").val( 0 );
                }

            });

            $('#div_tabla').on('change','.select_tipo_cristal', function () 
            {
                var search_id = $(this).val();
                
                var place = $(this);

                $.ajaxSetup(
                {
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    }
                });
                
                $.get('{!! route('admin.ventas.venta.search_venta_cristal') !!}',
                {
                    id: search_id
                },
                function(precio_unitario, status)
                {
                    place.closest('td').closest('tr').find('input[id=precio_unitario]').val(precio_unitario);
                    place.closest('td').closest('tr').find('input[id=cristal_id]').val(search_id);

                });
            });

            $(".seguimiento").on('keyup', function()
            {
                $("#nro_seguimiento_preventa").val( $(this).val() );

                $("#nro_seguimiento_factura").val( $(this).val() );

            });

            $( "#cliente" ).autocomplete(
            {
                source: '{!! route('admin.ventas.venta.search_venta_cliente') !!}',

                minLength: 1,

                select: function(event, ui) 
                {
                    $( "#cliente_id" ).val( ui.item.id );
                }

            });

            $( ".producto" ).autocomplete(
            {
                source: '{!! route('admin.ventas.venta.search_venta_producto') !!}',

                minLength: 1,

                select: function(event, ui) 
                {
                    $(this).closest('td').closest('tr').find('input[id=precio_unitario]').val(ui.item.precio);
                    $(this).closest('td').closest('tr').find('input[id=producto_id]').val(ui.item.id);
                }

            });

            $( ".servicio" ).autocomplete(
            {
                source: '{!! route('admin.ventas.venta.search_venta_servicio') !!}',

                minLength: 1,

                select: function(event, ui) 
                {
                    $(this).closest('td').closest('tr').find('input[id=precio_unitario]').val(ui.item.precio);
                    $(this).closest('td').closest('tr').find('input[id=servicio_id]').val(ui.item.id);
                }

            });

            

            var x = 0;

            console.log('x ready: '+x);

            $('#agregar').click(function (e) 
            {

                e.preventDefault();
                x++;

                console.log('agregar clicked, '+'x is: '+x);
    
                column_seleccion=column_seleccion.replace('select_cristal[indexAgregado]','select_cristal'+x);
                column_seleccion=column_seleccion.replace('select_categoria_cristal[indexAgregado]','select_categoria_cristal'+x);
                column_seleccion=column_seleccion.replace('select_tipo_cristal[indexAgregado]','select_tipo_cristal'+x);
                
                $('#tabla_detalle_venta').append(
                '<tr id="'+x+'">'+column_tipo+''+column_seleccion+''+column_detalleCristal+''+column_cantidad+''+column_iva+''+column_precioUnitario+''+column_precio+''+column_subtotalMasIva+''+column_accion+'</tr>');

                column_seleccion=column_seleccion.replace('select_cristal'+x,'select_cristal[indexAgregado]');
                column_seleccion=column_seleccion.replace('select_categoria_cristal'+x,'select_categoria_cristal[indexAgregado]');
                column_seleccion=column_seleccion.replace('select_tipo_cristal'+x,'select_tipo_cristal[indexAgregado]');



                $('.precio_unitario').number(true, 0, '', '.');

                $('.cantidad').number(true, 0, '', '.');
/*--------*/
                $(".select_cristal"+x).chained(".select_categoria_cristal"+x);
                $(".select_tipo_cristal"+x).chained(".select_cristal"+x);





                $(this).closest('td').closest('tr').find('div[id=divProductos]').hide().find('input').val('').removeAttr("required");
/*-----*/

                if(x<0)
                {
                    x=0;
                    console.log('x fixed to: '+x);
                }

                $( ".producto" ).autocomplete(
                {
                    source: '{!! route('admin.ventas.venta.search_venta_producto') !!}',

                    minLength: 1,

                    select: function(event, ui) 
                    {
                        $(this).closest('td').closest('tr').find('input[id=precio_unitario]').val(ui.item.precio);
                        $(this).closest('td').closest('tr').find('input[id=producto_id]').val(ui.item.id);
                    }

                });

                $( ".servicio" ).autocomplete(
                {
                    source: '{!! route('admin.ventas.venta.search_venta_servicio') !!}',

                    minLength: 1,

                    select: function(event, ui) 
                    {
                        $(this).closest('td').closest('tr').find('input[id=precio_unitario]').val(ui.item.precio);
                        $(this).closest('td').closest('tr').find('input[id=servicio_id]').val(ui.item.id);
                    }

                });

            });
            
            var column_tipo = '<?php echo trim(preg_replace('/\s\s+/', ' ', htmlspecialchars_decode($columnTipo))) ;?>;'           
            var column_seleccion = '<?php echo trim(preg_replace('/\s\s+/', ' ', htmlspecialchars_decode($columnSeleccion)))  ;?>';       
            var column_detalleCristal = '<?php echo trim(preg_replace('/\s\s+/', ' ', htmlspecialchars_decode($columnDetalleCristal)))  ;?>';
            var column_cantidad =  '<?php echo trim(preg_replace('/\s\s+/', ' ', htmlspecialchars_decode($columnCantidad))) ;?>';
            var column_iva = '<?php echo trim(preg_replace('/\s\s+/', ' ', htmlspecialchars_decode($columnIva))) ;?>';
            var column_precioUnitario = '<?php echo trim(preg_replace('/\s\s+/', ' ', htmlspecialchars_decode($columnPrecioUnitario))) ;?>';
            var column_precio = '<?php echo trim(preg_replace('/\s\s+/', ' ', htmlspecialchars_decode($columnPrecioTotal))) ;?>';
            var column_subtotalMasIva = '<?php echo trim(preg_replace('/\s\s+/', ' ', htmlspecialchars_decode($columnSubTotal) ));?>';
            var column_accion = '<?php echo trim(preg_replace('/\s\s+/', ' ', htmlspecialchars_decode($columnAccion))) ;?>';

    

            $("#div_tabla").on('change','.tipo',function()
            {

                if($(this).val()=='cristal')
                {
                    console.log('cristal selected, now hide servicios and productos')

                    $(this).closest('td').closest('tr').find('div[id=divProductos]').hide().find('input').val('').removeAttr("required");
                    $(this).closest('td').closest('tr').find('div[id=divServicios]').hide().find('input').val('').removeAttr("required");
                    $(this).closest('td').closest('tr').find('div[id=divCristales]').show();

                    $(this).closest('td').closest('tr').find('select[id=categoria_cristal]').attr("required","").val('');
                    $(this).closest('td').closest('tr').find('select[id=cristal]').attr("required","").val('');
                    $(this).closest('td').closest('tr').find('select[id=tipo_cristal]').attr("required","").val('');


                    $(this).closest('td').closest('tr').find('input[id=precio_unitario]').val('');
                    $(this).closest('td').closest('tr').find('input[id=sub_total]').val('0');
                    $(this).closest('td').closest('tr').find('input[id=producto_id]').val('');
                    $(this).closest('td').closest('tr').find('input[id=servicio_id]').val('');
                    $(this).closest('td').closest('tr').find('input[id=cantidad]').val('');
                    sumarSubTotales();
                    sumarIvas();
                    sumarSubTotalesIVA();
                }   
                else
                {
                    $(this).closest('td').closest('tr').find('div[id=columnDetalleCristal]').hide();
   
                }

                if($(this).val()=='servicio')
                {
                    //console.log('servicios selected, now hide productos and cristales')
                    $(this).closest('td').closest('tr').find('div[id=divProductos]').hide().find('input').removeAttr("required").val('');
                    $(this).closest('td').closest('tr').find('div[id=divServicios]').show().find('input').attr("required","");
                    $(this).closest('td').closest('tr').find('div[id=divCristales]').hide();
                    $(this).closest('td').closest('tr').find('select[id=categoria_cristal]').removeAttr("required").val('');
                    $(this).closest('td').closest('tr').find('select[id=cristal]').removeAttr("required").val('');
                    $(this).closest('td').closest('tr').find('select[id=tipo_cristal]').removeAttr("required").val('');
                    $(this).closest('td').closest('tr').find('input[id=producto_id]').val('');
                    $(this).closest('td').closest('tr').find('input[id=cristal_id]').val('');
                    $(this).closest('td').closest('tr').find('input[id=precio_unitario]').val('');
                    $(this).closest('td').closest('tr').find('input[id=cantidad]').val('');
                    $(this).closest('td').closest('tr').find('input[id=sub_total]').val('0');
                    sumarSubTotales();
                    sumarIvas();
                    sumarSubTotalesIVA();

                }

                if($(this).val()=='producto')
                {
                    //console.log('productos selected, now hide servicios and cristales')
                    $(this).closest('td').closest('tr').find('div[id=divProductos]').show().find('input').attr("required","");
                    $(this).closest('td').closest('tr').find('div[id=divServicios]').hide().find('input').val('').removeAttr("required");
                    $(this).closest('td').closest('tr').find('div[id=divCristales]').hide().find('input').val('').removeAttr("required");
                    $(this).closest('td').closest('tr').find('input[id=servicio_id]').val('');
                    $(this).closest('td').closest('tr').find('input[id=cristal_id]').val('');
                    $(this).closest('td').closest('tr').find('input[id=precio_unitario]').val('');
                    $(this).closest('td').closest('tr').find('input[id=cantidad]').val('');
                    $(this).closest('td').closest('tr').find('input[id=sub_total]').val('0');
                    sumarSubTotales();
                    sumarIvas();
                    sumarSubTotalesIVA();
                }
            });



            $("#div_tabla").on("click",'.remove_field', function(e)
            {
                e.preventDefault();
                $(this).parent().parent('tr').remove();
                x--;
                
                if(x<0)
                {
                    x=0;
                    
                }
                console.log('function remove row ,x es: ');
                sumarSubTotales();
                sumarIvas();
                sumarSubTotalesIVA();
            });

            

            $('#div_tabla').on('keyup','.cantidad', function () //si se escribe en cantidad
            {
                var cantidad = $(this).val();

                var precio = 0;

                var iva = 0;    


                $(this).closest('td').closest('tr').find("input[id=precio_unitario]").each(function() 
                {          //precio_unitario
                    precio = $(this).val() * cantidad || 0;//multiplica precio_unitario * cantidad y guarda en precio
                });

                $(this).closest('td').closest('tr').find("select[id=iva]").each(function() 
                {                   //iva
                    console.log('IVA IS '+$(this).val());

                    if(!parseInt($(this).val())==0)
                    {
                        iva = parseInt( precio / $(this).val() );//el (precio_unitario*cantidad) se divide por el iva 0% 5% 10%(1/21/11)
                    }
                    else
                    {
                        iva = 0;
                    }
                    

                    
                });

                $(this).closest('td').closest('tr').find("input[id=precio]").each(function() 
                {
                    this.value = $.number(precio, 0, '', '.');//se formatea el precio(precio_unitario*cantidad)
                });
                $(this).closest('td').closest('tr').find("input[id=sub_total]").each(function() 
                {
                    var sub_total = iva + precio;//calcula subtotales
                    console.log("precio: "+precio+' iva: '+iva+' sub total: '+sub_total);

                    this.value = $.number(sub_total, 0, '', '.');

                });
                sumarSubTotales();
                sumarIvas();
                sumarSubTotalesIVA();

            });

            $('#div_tabla').on('keyup','.precio_unitario', function () //si se escribe en precio unitario
            {
                var precio_unitario = $(this).val();

                var precio = 0;
                
                var iva = 0
                
                $(this).closest('td').closest('tr').find("input[id=cantidad]").each(function() 
                {
                              //cantidad
                    precio = $(this).val() * precio_unitario || 0;
                
                });

                $(this).closest('td').closest('tr').find("select[id=iva]").each(function() 
                {
                    console.log('IVA IS '+$(this).val());
                                             //iva

                    if(!parseInt($(this).val())==0)
                    {
                        iva = parseInt( precio / $(this).val() );
                    }
                    else
                    {
                        iva = 0;
                    }

                });
                
                $(this).closest('td').closest('tr').find("input[id=precio]").each(function() 
                {

                    this.value= $.number(precio, 0, '', '.');

                });

                $(this).closest('td').closest('tr').find("input[id=sub_total]").each(function() 
                {
                    var sub_total = iva + precio;
                    console.log("precio: "+precio+' iva: '+iva+' sub total: '+sub_total);

                    this.value= $.number(sub_total, 0, '', '.');
                    
                });


                sumarSubTotales();
                sumarIvas();
                sumarSubTotalesIVA();

            })

            $('#div_tabla').on('change','.iva', function () 
            {
                console.log('iva cambio');

                var iva_seleccionado = $(this).val();

                var cantidad = 0;

                var precio = 0;

                var precio_unitario = 0;

                var iva = 0;

                $(this).closest('td').closest('tr').find("input[id=cantidad]").each(function() 
                {
                              //cantidad
                    cantidad = $(this).val();
                
                });

                $(this).closest('td').closest('tr').find("input[id=precio_unitario]").each(function() 
                {

                    precio = $(this).val() * cantidad || 0;


                    console.log('IVA IS '+iva_seleccionado);

                    iva_seleccionado = parseInt(iva_seleccionado);

                    if(!iva_seleccionado==0)
                    {
                        iva = parseInt( precio / iva_seleccionado );
                    }
                    else
                    {
                        iva = 0;
                    }


                });

                
                $(this).closest('td').closest('tr').find("input[id=precio]").each(function() 
                {

                    this.value= $.number(precio, 0, '', '.');

                });

                $(this).closest('td').closest('tr').find("input[id=sub_total]").each(function() 
                {
                    var sub_total = iva + precio;

                    this.value= $.number(sub_total, 0, '', '.');
                    
                });
               
                sumarSubTotales();
                sumarIvas();
                sumarSubTotalesIVA();
            })





            function sumarSubTotales()
            {
                var total = 0;

                console.log('entro sumar sub');

                $(".iva").each(function() 
                {
                    console.log('entro each');
                    var iva_seleccionado = $(this).val();
                    var iva = 0;
                    var cantidad = 0;
                    var precio = 0;
                    $(this).closest('td').closest('tr').find("input[id=cantidad]").each(function() 
                    {
                        cantidad = $(this).val();

                    });
                    $(this).closest('td').closest('tr').find("input[id=precio_unitario]").each(function() 
                    {
                        precio = $(this).val() * cantidad;
                        iva = (precio / iva_seleccionado);
                        total += parseInt(precio);
                    });
                });
                console.log('El monto total es: '+total);
                $('#monto_total_table').val($.number(total, 0, '', '.'));     
            }

            function sumarSubTotalesIVA()
            {
                var total = 0;

                console.log('entro sumar sub+IVA');

                $(".iva").each(function() 
                {
                    console.log('entro each');
                    var iva_seleccionado = $(this).val();
                    if(iva_seleccionado==0)
                    {

                        iva_seleccionado=1;
                    }

                    var iva = 0;
                    var cantidad = 0;
                    var precio = 0;
                    $(this).closest('td').closest('tr').find("input[id=cantidad]").each(function() 
                    {
                        cantidad = $(this).val();

                    });
                    $(this).closest('td').closest('tr').find("input[id=precio_unitario]").each(function() 
                    {
                        subTotal = $(this).val() * cantidad;
                        iva = (subTotal / iva_seleccionado);
                        if( iva==subTotal )
                            iva=0;

                        total += parseInt(subTotal+iva);
                    });
                });
                $('#monto_total').val( $.number(total, 0, '', '.') );
                $('#monto_total_iva').val($.number(total, 0, '', '.'));
                $('#total_pagar').val($.number(total, 0, '', '.'));
                $('#monto_total_letra').val(NumeroALetras(total));  
            }

            function sumarIvas()
            {
                var iva_5_total = 0;

                var iva_10_total = 0;

                var iva_total = 0;

                $(".iva").each(function() 
                {
                    var iva_seleccionado = $(this).val();
                    var cantidad = 0;
                    var precio = 0
                    $(this).closest('td').closest('tr').find("input[id=cantidad]").each(function() 
                    {
                        cantidad = $(this).val();
                    });
                    $(this).closest('td').closest('tr').find("input[id=precio_unitario]").each(function() 
                    {
                        precio = $(this).val() * cantidad;
                        if(iva_seleccionado == 21)
                        {
                            iva_5_total += parseInt(precio/iva_seleccionado);
                            
                        }
                        else if(iva_seleccionado == 11)
                        {
                            iva_10_total += parseInt(precio/iva_seleccionado);
                            console.log('precio: '+precio+' iva: '+iva_seleccionado);
                        }
                    });
                });
                iva_total = iva_5_total + iva_10_total;
                $('#total_iva_5').val($.number(iva_5_total, 0, '', '.'));
                $('#total_iva_10').val($.number(iva_10_total, 0, '', '.'));
                $('#total_iva').val($.number(iva_total, 0, '', '.'));
            }


             $('input[type="checkbox"].flat-blue, input[type="radio"].flat-blue').iCheck(
            {
                checkboxClass: 'icheckbox_flat-blue',
                radioClass: 'iradio_flat-blue'
            });
      
        });   