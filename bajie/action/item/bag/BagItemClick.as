package bajie.action.item.bag
{
	import bajie.constData.GoodsType;
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.bag.BagInfo;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.events.ItemEvent;
	import bajie.interfaces.item.IClick;
	import bajie.ui.menu.MenuContent;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.events.MouseEvent;

	public class BagItemClick implements IClick
	{
		private var _info:BagItemInfo;
		private var menuContent:MenuContent;

		public function BagItemClick(info:BagItemInfo)
		{
			// constructor code
			_info = info;
		}

		public function itemClick(e:ItemEvent):void
		{
			e.Param.currentTarget.filters = [];
			var o:Object = e.Param;
			if (_info != null)
			{
				if (_info.type == GoodsType.EQUIP || _info.type == GoodsType.WEAPON)
				{
					menuContent = GlobalAPI.menuManager.menuArr[4];
				}
				else if (_info.type == GoodsType.FLASHION)
				{
					menuContent = GlobalAPI.menuManager.menuArr[3];
				}
				else if (_info.type == GoodsType.GEMSTONE)
				{
					menuContent = GlobalAPI.menuManager.menuArr[1];
				}
				else if (_info.type == GoodsType.PROP)
				{
					menuContent = GlobalAPI.menuManager.giveMenu(o.currentTarget,GlobalAPI.menuManager.medicPropIdArr,GlobalAPI.menuManager.fightPropIdArr,0,1,2);
				}

				menuContent.x = o.currentTarget.x - 5;
				menuContent.y = o.currentTarget.y + o.currentTarget.height;
				menuContent.initEvent();
				menuContent.info = _info;
				SetModuleUtils.addModule(menuContent, o.currentTarget.parent.parent, false, true, ModuleType.MENU);
			}

		}

	}

}