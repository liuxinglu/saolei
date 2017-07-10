package bajie.manager.menu 
{
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.events.BajieDispatcher;
	import bajie.events.MenuEvent;
	import bajie.ui.Bag;
	import bajie.ui.att.AttItem;
	import bajie.ui.bag.BagItem;
	import bajie.ui.base.item.BaseItem;
	import bajie.ui.menu.MenuButton;
	import bajie.ui.menu.MenuContent;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class MenuManager
	{
		
		public var menuArr:Array = [];
		
		/**
		 *战斗类 
		 */		
		public var fightPropIdArr:Array = [110001, 110002, 110003, 110004, 110005, 110006, 110007, 110008, 110009, 110010, 110011, 110101, 110102, 110103];
		/**
		 *药品类 
		 */		
		public var medicPropIdArr:Array = [110104, 110105, 110106, 110107, 110108, 110109, 110110, 110111, 110302, 110303, 110304, 110305, 110306, 110307];
		/**
		 *宝石类 
		 */		
		public var gemPropIdArr:Array = [110201,110202, 110203, 110204, 110205, 110301];
		private var _menuXml:XMLList;
		
		public function MenuManager() {
			// constructor code
			setMenu(GlobalAPI.configData.config.menus);
		}
		
		/**
		 * 
		 * @param bb 当前格子
		 * @param arr1 匹配id列表1
		 * @param arr2 匹配id列表2
		 * @param index1 当匹配列表1时所弹出的菜单索引
		 * @param index2 不匹配两个列表时弹出的菜单索引
		 * @param index3 当匹配列表2时所弹出的菜单索引
		 * 
		 */		
		public function giveMenu(bb:BaseItem, arr1:Array = null, arr2:Array = null,index1:int = 0, index2:int = 0, index3:int = 0):MenuContent
		{
			var len:int = 0;
			var temp:int = 0;
			var flag:int = 0;
			var currentMenu:MenuContent = new MenuContent;
			
			if(arr1!= null)
			{
				len = arr1.length;
				for(temp = 0; temp < len; temp++)
				{
					if(GlobalData.bagInfo.bagSp.getChildAt(int(bb.index)) is BagItem)
					{//背包
						if(BaseItem(GlobalData.bagInfo.bagSp.getChildAt(int(bb.index))).info.templateId == arr1[temp])
						{
							currentMenu = menuArr[index1];
							flag = 1;
							break;
						}
					}
				}
			}
			
			if(arr2 != null)
			{
				len = arr2.length;
				for(temp = 0; temp < len; temp++)
				{
					
					if(BaseItem(GlobalData.bagInfo.bagSp.getChildAt(int(bb.index))).info.templateId == arr2[temp])
					{
						currentMenu = menuArr[index3];
						flag = 1;
						break;
					}
				}
			}
			if(flag == 0)
			{
				currentMenu = menuArr[index2];
			}
			return currentMenu;
		}
		
		/**
		设置菜单
		*/
		public function setMenu(xml:XMLList):Boolean
		{
			_menuXml = xml;
			var arr1:Array = [
				_menuXml.props.medic.@menu,
				_menuXml.props.gem.@menu,
				_menuXml.props.fight.@menu,
				_menuXml.fashions.fashion.@menu,
				_menuXml.equips.equip.@menu,
				_menuXml.atts.fashion.@menu,
				_menuXml.atts.equip.@menu];
			var len1:int = arr1.length;//获取菜单个数
			
			for(var index:int = 0; index < len1; index++)
			{
				
				var s:String = arr1[index];
				var arr:Array = s.split(",");
				var len:int = arr.length;
				
				var menuC:MenuContent = new MenuContent;
				//menuC.menuContent.height += 21 * (len-1);
				for(var i:int = 0; i < len; i++)
				{//每个菜单内的菜单内容
					var menuMC:MenuButton = new MenuButton;
					menuMC.x = 0;
					menuMC.y = i*22;
					menuMC.menuText.text = arr[i];
					menuMC.menuText.width = 50;
					menuMC.menuText.height = 23;
					if(index == 0)
					{//药品类道具
						switch(i)
						{
							case 0://使用
								menuMC.addEventListener(MouseEvent.CLICK, useHandler);
								break;
							case 1://出售
								menuMC.addEventListener(MouseEvent.CLICK, saleHandler);
								break;
							case 2://移动 
								menuMC.addEventListener(MouseEvent.CLICK, moveHandler);
								break;
						}
					}
					else if(index == 1)
					{//宝石类
						switch(i)
						{
							case 0://出售
								menuMC.addEventListener(MouseEvent.CLICK, saleHandler);
								break;
							case 1://移动
								menuMC.addEventListener(MouseEvent.CLICK, moveHandler);
								break;
						}
					}
					else if(index == 2)
					{//战斗类
						switch(i)
						{
							case 0://装备
								menuMC.addEventListener(MouseEvent.CLICK, useHandler);
								break;
							case 1://出售
								menuMC.addEventListener(MouseEvent.CLICK, saleHandler);
								break;
							case 2://移动
								menuMC.addEventListener(MouseEvent.CLICK, moveHandler);
								break;
						}
					}
					else if(index == 3)
					{//时装
						switch(i)
						{
							case 0://装备
								menuMC.addEventListener(MouseEvent.CLICK, useHandler);
								break;
							case 1://移动
								menuMC.addEventListener(MouseEvent.CLICK,moveHandler);
								break;
						}
					}
					else if(index == 4)
					{//装备 装备,强化,修理,洗练,出售,移动
						switch(i)
						{
							case 0://装备
								menuMC.addEventListener(MouseEvent.CLICK, useHandler);
								break;
							case 1://强化
								menuMC.addEventListener(MouseEvent.CLICK, enhanceHandler);
								break;
							case 2://修理
								menuMC.addEventListener(MouseEvent.CLICK, repairHandler);
								break;
							case 3://洗练
								menuMC.addEventListener(MouseEvent.CLICK, rebuildHandler);
								break;
							case 4://出售
								menuMC.addEventListener(MouseEvent.CLICK, saleHandler);
								break;
							case 5://移动
								menuMC.addEventListener(MouseEvent.CLICK, moveHandler);
								break;
						}
					}
					else if(index == 5)
					{//属性格子时装
						menuMC.addEventListener(MouseEvent.CLICK,unsnachHandler);
					}
					else if(index == 6)
					{//属性格子装备
						switch(i)
						{
							case 0://卸下
								menuMC.addEventListener(MouseEvent.CLICK, unsnachHandler);
								break;
							case 1://强化
								menuMC.addEventListener(MouseEvent.CLICK, enhanceHandler);
								break;
						}
					}
					menuC.menuContent.addChild(menuMC);
				}
				menuArr.push(menuC);
			}
			return true;
		}
		
		private function useHandler(e:MouseEvent):void
		{
			BajieDispatcher.getInstance().dispatchEvent(new MenuEvent(MenuEvent.MENU_USE));
		}
		
		private function saleHandler(e:MouseEvent):void
		{
			BajieDispatcher.getInstance().dispatchEvent(new MenuEvent(MenuEvent.MENU_SALE));
		}
		
		private function moveHandler(e:MouseEvent):void
		{
			BajieDispatcher.getInstance().dispatchEvent(new MenuEvent(MenuEvent.MENU_MOVE));
		}
		
		private function enhanceHandler(e:MouseEvent):void
		{
			BajieDispatcher.getInstance().dispatchEvent(new MenuEvent(MenuEvent.MENU_ENHANCE));
		}
		
		private function repairHandler(e:MouseEvent):void
		{
			BajieDispatcher.getInstance().dispatchEvent(new MenuEvent(MenuEvent.MENU_REPAIR));
		}
		
		private function rebuildHandler(e:MouseEvent):void
		{
			BajieDispatcher.getInstance().dispatchEvent(new MenuEvent(MenuEvent.MENU_REBUILD));
		}
		
		private function unsnachHandler(e:MouseEvent):void
		{
			BajieDispatcher.getInstance().dispatchEvent(new MenuEvent(MenuEvent.MENU_UNSNACH));
		}

	}
	
}
