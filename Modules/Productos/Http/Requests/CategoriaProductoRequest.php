<?php

namespace Modules\Productos\Http\Requests;

use App\Http\Requests\Request;

class CategoriaProductoRequest extends Request
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {

        if( $this->method()=='PUT' )//update
        {
            $uniquesRules = 
            [
                'codigo' => 'unique:productos__categoriaproductos,codigo,'.$this->categoriaproducto->id
            ];
        }
        else
        {
            $uniquesRules = 
            [
                'codigo' => 'unique:productos__categoriaproductos'
            ];
        }

        $normalRules = 
        [
            'nombre' => 'required'
        ];

        $rules = array_merge( $normalRules, $uniquesRules );

        return $rules;
    }

    /**
    * Get the error messages for the defined validation rules.
    *
    * @return array
    */
    public function messages()
    {
        return [
            'nombre.required' => 'El nombre es requerido',
            'codigo.unique' => 'El codigo ya existe en el sistema'
        ];
    }
}