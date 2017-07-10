package bajie.core.data.bag 
{
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.socketHandler.bag.BagInfoSocketHandler;
	import bajie.core.data.socketHandler.bag.ChangeEquipSiteSocketHandler;
	import bajie.core.data.socketHandler.bag.ChangeFashionSiteSocketHandler;
	import bajie.core.data.socketHandler.bag.ChangePropSiteSocketHandler;
	import bajie.core.data.socketHandler.bag.EquipEquipSocketHandler;
	import bajie.core.data.socketHandler.bag.EquipFashionSocketHandler;
	import bajie.core.data.socketHandler.bag.EquipPropSocketHandler;
	import bajie.core.data.socketHandler.bag.GetBagEquipSocketHandler;
	import bajie.core.data.socketHandler.bag.GetBagFashionSocketHandler;
	import bajie.core.data.socketHandler.bag.GetBagPropSocketHandler;
	import bajie.core.data.socketHandler.bag.GetEquipDetailInfoSocketHandler;
	import bajie.core.data.socketHandler.bag.GetFashionDetailInfoSocketHandler;
	import bajie.core.data.socketHandler.bag.GetPropDetailInfoSocketHandler;
	import bajie.core.data.socketHandler.bag.SetAttSocketHandler;
	import bajie.core.data.socketHandler.bag.SortBagEquipSocketHandler;
	import bajie.core.data.socketHandler.bag.SortBagFashionSocketHandler;
	import bajie.core.data.socketHandler.bag.SortBagPropSocketHandler;
	import bajie.core.data.socketHandler.bag.UnsnachEquipSocketHandler;
	import bajie.core.data.socketHandler.bag.UnsnachFashionSocketHandler;
	import bajie.core.data.socketHandler.bag.UnsnachPropSocketHandler;
	import bajie.events.BagEvent;
	import bajie.events.ItemEvent;
	import bajie.interfaces.tick.ITick;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	public class BagInfo extends EventDispatcher
	{
	
		public function BagInfo() {
			// constructor code
			
		}
		
		private var _bagSp:Sprite;
		public function get bagSp():Sprite
		{
			return _bagSp;
		}
		
		public function set bagSp(sp:Sprite):void
		{
			_bagSp = sp;
		}
		
		private var _bagPlayerSp:Sprite;

		public function get bagPlayerSp():Sprite
		{
			return _bagPlayerSp;
		}

		public function set bagPlayerSp(value:Sprite):void
		{
			_bagPlayerSp = value;
		}
		
		
		
		
		/**
		 *打开背包 
		 */		
		public function openBag():void
		{
			BagInfoSocketHandler.send();
		}
		
		/**
		 *获得背包人物信息 
		 */		
		public function getBagPlayerInfo(o:Object):void
		{
			//var oo:Object =  JSON.parse(o.body.toString());
			dispatchEvent(new BagEvent(BagEvent.BAG_PLAYER_INFO, o));
		}
		
		/**
		 *获取背包道具 
		 * @param curPage 当前页
		 * 
		 */		
		public function getBagProp(curPage:int):void
		{
			GetBagPropSocketHandler.send(curPage);
		}
		
		/**
		 *获得背包道具信息 
		 */		
		public function getBagPropInfo(o:Object):void
		{
			//var oo:Object = JSON.parse(o.body.toString());
			dispatchEvent(new BagEvent(BagEvent.BAG_PROP_INFO, o));
		}
		
		/**
		 *获取背包装备 
		 * @param curPage 当前页
		 */		
		public function getBagEquip(curPage:int):void
		{
			GetBagEquipSocketHandler.send(curPage);
		}
		
		/**
		 *获得背包装备信息 
		 */		
		public function getBagEquipInfo(o:Object):void
		{
			//var oo:Object = JSON.parse(o.body.toString());
			dispatchEvent(new BagEvent(BagEvent.BAG_EQUIP_INFO, o));
		}
		
		/**
		 *获取背包时装 
		 * @param curPage 当前页
		 * 
		 */		
		public function getBagFashion(curPage:int):void
		{
			GetBagFashionSocketHandler.send(curPage);
		}
		
		/**
		 *获得背包时装信息 
		 */		
		public function getBagFashionInfo(o:Object):void
		{
			//var oo:Object = JSON.parse(o.body.toString());
			dispatchEvent(new BagEvent(BagEvent.BAG_FASHION_INFO, o));
		}
		
		/**
		 *获取单个装备详细信息 
		 * @param itemid 装备id
		 * 
		 */		
		public function getEquipDetail(itemid:int):void
		{
			GetEquipDetailInfoSocketHandler.send(itemid);
		}
		
		/**
		 *获得单个装备详细信息 
		 * @param o
		 */		
		public function getEquipDetailInfo(o:Object):void
		{
			dispatchEvent(new ItemEvent(ItemEvent.ITEM_INFO, o));
		}
		
		
		/**
		 *获取单个道具详细信息 
		 * @param itemid 道具id
		 */		
		public function getPropDetail(itemid:int):void
		{
			GetPropDetailInfoSocketHandler.send(itemid);
		}
		
		/**
		 *获得单个道具详细信息 
		 * @param o
		 */		
		public function getPropDetailInfo(o:Object):void
		{
			dispatchEvent(new ItemEvent(ItemEvent.ITEM_INFO, o));
		}
		
		/**
		 *获取单个时装的详细信息 
		 * @param itemid 时装id
		 */		
		public function getFashionDetail(itemid:int):void
		{
			GetFashionDetailInfoSocketHandler.send(itemid);
		}
		
		/**
		 *获得单个时装的详细信息 
		 * @param o
		 */		
		public function getFashionDetailInfo(o:Object):void
		{
			dispatchEvent(new ItemEvent(ItemEvent.ITEM_INFO, o));
		}
		
		/**
		 * 背包道具交换位置 
		 * @param fromIndex 起始索引
		 * @param toIndex 终止索引
		 */		
		public function changePropSite(fromIndex:int, toIndex:int):void
		{
			ChangePropSiteSocketHandler.send(fromIndex, toIndex);
		}
		
		/**
		 *装备道具 
		 * @param itemid 道具id
		 * @param index 所要装备的格子索引（1-4）
		 */		
		public function equipProp(itemid:int, index:int = 0):void
		{
			EquipPropSocketHandler.send(itemid, index);
		}
		
		/**
		 *卸下道具 
		 * @param itemid 道具id
		 */		
		public function unsnachProp(itemid:int, index:int = 0):void
		{
			UnsnachPropSocketHandler.send(itemid, index);
		}
		
		/**
		 *整理背包道具 
		 */		
		public function sortBagProp():void
		{
			SortBagPropSocketHandler.send();
		}
		
		/**
		 *装配装备 
		 * @param itemid 装备id
		 * @param index 要装配的格子索引
		 */		
		public function equipEquip(itemid:int, index:int = 0):void
		{
			EquipEquipSocketHandler.send(itemid, index);
		}
		
		/**
		 *卸下装备 
		 * @param itemid 装备id
		 * 
		 */		
		public function unsnachEquip(itemid:int, index:int = 0):void
		{
			UnsnachEquipSocketHandler.send(itemid, index);
		}
		
		/**
		 *整理背包装备 
		 */		
		public function sortBagEquip():void
		{
			SortBagEquipSocketHandler.send();
		}
		
		/**
		 *交换背包内装备位置 
		 * @param fromIndex 起始索引
		 * @param toIndex 结束索引
		 */		
		public function changeEquipSite(fromIndex:int, toIndex:int):void
		{
			ChangeEquipSiteSocketHandler.send(fromIndex, toIndex);
		}
		
		/**
		 *装配时装 
		 * @param itemid 时装id
		 * @param index 要装配的格子索引
		 */		
		public function equipFashion(itemid:int, index:int = 0):void
		{
			EquipFashionSocketHandler.send(itemid, index);
		}
		
		/**
		 *卸下时装 
		 * @param itemid 时装id
		 */		
		public function unsnachFashion(itemid:int, index:int = 0):void
		{
			UnsnachFashionSocketHandler.send(itemid, index);
		}
		
		/**
		 *整理背包时装 
		 */		
		public function sortBagFashion():void
		{
			SortBagFashionSocketHandler.send();
		}
		
		/**
		 *交换背包内时装位置 
		 * @param fromIndex 起始位置
		 * @param toIndex 终止位置
		 */		
		public function changeFashionSite(fromIndex:int, toIndex:int):void
		{
			ChangeFashionSiteSocketHandler.send(fromIndex, toIndex);
		}
		
		/**
		 *分配人物点数 
		 * @param energy 能量
		 * @param lucky 幸运
		 * @param dex 灵巧
		 * 
		 */		
		public function setAtt(energy:int, lucky:int, dex:int, lastPoint:int):void
		{
			SetAttSocketHandler.send(energy, lucky, dex, lastPoint);
		}
	}
	
}
