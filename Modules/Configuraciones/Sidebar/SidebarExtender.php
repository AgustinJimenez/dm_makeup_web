<?php namespace Modules\Configuraciones\Sidebar;

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
        $menu->group(trans('Sistema'), function (Group $group) {
            $group->weight(100);
            $group->item(trans('Configuraciones'), function (Item $item) {
                $item->icon('fa fa-cog');
                $item->weight(10);
                $item->route('admin.configuraciones.configuracion.index');
                $item->authorize(
                    $this->auth->hasAccess('configuraciones.configuracions.index')
                );

            });
        });

        return $menu;
    }
}
