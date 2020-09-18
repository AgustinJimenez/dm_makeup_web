<?php

namespace Modules\Clientes\Http\Requests;

use App\Http\Requests\Request;
use Modules\Clientes\Entities\Cliente;
use Illuminate\Support\Facades\Validator;
use Input;
class ClienteRequest extends Request
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



        foreach ($this->all() as $key => $value)
        {

            if($value == '')
                $this[$key] = null;

        }

        if( $this->method()=='PUT' )//update
        {
            $uniquesRules=
            [
                'cedula' => 'max:255|unique:clientes__clientes,cedula,'.$this->cliente->id,
                'ruc' => 'max:255|unique:clientes__clientes,ruc,'.$this->cliente->id,
            ];
        }
        else
        {
            $uniquesRules=
            [
                'cedula' => 'max:255|unique:clientes__clientes',
                'ruc' => 'max:255|unique:clientes__clientes',
            ];
        }

        $normalRules = [
                        'razon_social' => 'required|max:255',
                        'telefono' => 'max:255',
                        'celular' => 'max:255',
                        'direccion' => 'max:255'
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
        return $messages = [
            'razon_social.required' => 'Este campo es requerido',
            'cedula.numeric' => 'La cedula debe ser numerica',
            'cedula.unique' => 'La cedula ya existe en el sistema',
            'ruc.unique' => 'El ruc ya existe en el sistema',
        ];
    }
}
