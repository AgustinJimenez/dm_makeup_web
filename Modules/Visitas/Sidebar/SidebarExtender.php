<?php namespace Modules\Visitas\Sidebar;

use Maatwebsite\Sidebar\Group;
use Maatwebsite\Sidebar\Item;
use Maatwebsite\Sidebar\Menu;
use Modules\Core\Contracts\Authentication;

class SidebarExtender implements \Maatwebsite\Sidebar\SidebarExtender
{
    /**
     * @var Authentication
     */
    protected $auth;

    /**
     * @param Authentication $auth
     *
     * @internal param Guard $guard
     */
    public function __construct(Authentication $auth)
    {
        $this->auth = $auth;
    }

    /**
     * @param Menu $menu
     *
     * @return Menu
     */
    public function extendWith(Menu $menu)
    {
        $menu->group(trans('core::sidebar.content'), function (Group $group)
        {
            $group->item(trans('visitas::visitas.title.visitas'), function (Item $item)
            {
                $item->icon('fa fa-copy');
                $item->weight(2);
                $item->append('admin.visitas.visita.create');
                $item->route('admin.visitas.visita.index');
                $item->authorize(
                     /* append */
                );
                /*
                $item->item(trans('visitas::visitas.title.visitas'), function (Item $item)
                {
                    $item->icon('fa fa-copy');
                    $item->weight(0);
                    $item->append('admin.visitas.visita.create');
                    $item->route('admin.visitas.visita.index');
                    $item->authorize(
                        $this->auth->hasAccess('visitas.visitas.index')
                    );
                });

                $item->item(trans('visitas::stockretirados.title.stockretirados'), function (Item $item)
                {
                    $item->icon('fa fa-copy');
                    $item->weight(0);
                    $item->append('admin.visitas.stockretirado.create');
                    $item->route('admin.visitas.stockretirado.index');
                    $item->authorize(
                        $this->auth->hasAccess('visitas.stockretirados.index')
                    );
                });
                */


            });

            $group->item( "Comisiones", function (Item $item)
            {
                $item->icon('fa fa-copy');
                $item->weight(10);
                $item->route('admin.visitas.comisiones.index');
                $item->authorize(
                     /* append */
                );
            });



        });

        return $menu;
    }
}
