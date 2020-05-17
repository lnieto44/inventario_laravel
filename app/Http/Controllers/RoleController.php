<?php

namespace App\Http\Controllers;
use App\Role;

use Illuminate\Http\Request;

class RoleController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        
        if ($buscar==''){
            $roles = Role::orderBy('id', 'desc')->paginate(3);
        }
        else{
            $roles = Role::where($criterio, 'like', '%'. $buscar . '%')->orderBy('id', 'desc')->paginate(3);
        }
        

        return [
            'pagination' => [
                'total'        => $roles->total(),
                'current_page' => $roles->currentPage(),
                'per_page'     => $roles->perPage(),
                'last_page'    => $roles->lastPage(),
                'from'         => $roles->firstItem(),
                'to'           => $roles->lastItem(),
            ],
            'roles' => $roles
        ];
    }

    public function selectRole(Request $request)
    {
        //if (!$request->ajax()) return redirect('/');
        $roles = Role::where('condicion', '=', '1')->select('id','nombre')->orderBy('nombre', 'asc')->get();
        return ['roles' => $roles];
    }

}
