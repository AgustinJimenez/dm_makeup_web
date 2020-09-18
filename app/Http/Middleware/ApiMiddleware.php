<?php namespace App\Http\Middleware;

use Closure;
use Modules\User\Entities\Sentinel\User;

class ApiMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        if ($request->has('token'))
        {
            if (User::where('token', $request->get('token'))->exists())
                return $next($request);
            else
                return response()->json(['status' => 'Error','message' => '498 Invalid Token']);
        }
        else
        {
            return response()->json(['status' => 'Error','message' => '499 Token Required']);
        }
    }
}
