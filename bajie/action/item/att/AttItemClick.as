package bajie.action.item.att {
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.events.ItemEvent;
	import bajie.interfaces.item.IClick;
	import bajie.ui.menu.MenuContent;
	import bajie.utils.module.SetModuleUtils;
	
	public class AttItemClick implements IClick{

		private var _info:BagItemInfo;
		private var menuContent:MenuContent;
		
		public function AttItemClick(info:BagItemInfo) {
			// constructor code
			_info = info;
		}
		
		public function itemClick(e:ItemEvent):void
		{
			e.Param.currentTarget.filters = [];
			if(_info != null)
			{
				var o:Object = e.Param;
				if(o.currentTarget.itemType == ModuleType.ROLE)//卸下 强化
					menuContent = GlobalAPI.menuManager.giveMenu(o.currentTarget, null, null, 0, 6, 0);
				else if(o.currentTarget.itemType == ModuleType.PROP)//卸下
					menuContent = GlobalAPI.menuManager.giveMenu(o.currentTarget, null, null, 0, 5, 0);
				else if(o.currentTarget.itemType == ModuleType.FASHION)//卸下
					menuContent = GlobalAPI.menuManager.giveMenu(o.currentTarget, null, null, 0, 5, 0);
				menuContent.x = o.currentTarget.x - 5;
				menuContent.y = o.currentTarget.y + o.currentTarget.height;
				menuContent.info = _info;
				menuContent.initEvent();
				SetModuleUtils.addModule(menuContent, o.currentTarget.parent, false, true, ModuleType.MENU);
			}
			else
			{
				SetModuleUtils.removeModule(menuContent, ModuleType.MENU);
			}
		}

	}
	
}
