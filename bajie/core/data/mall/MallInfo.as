package bajie.core.data.mall
{
	import flash.events.EventDispatcher;
	import bajie.core.data.socketHandler.bag.GetBagPlayerInfoSocketHandler;
	import bajie.core.data.socketHandler.shop.*
	import bajie.core.data.GlobalData;
	import bajie.events.BagEvent;

	public class MallInfo extends EventDispatcher
	{
		public function MallInfo()
		{
			
		}
		public function getPlayerInfo():void {
			GetBagPlayerInfoSocketHandler.send();
		}
		public function shopBuyGold(idx:int):void {
			ShopBuyGoldSocketHandler.send(GlobalData.playerid, idx);
		}
		public function shopBuySilver(idx:int):void {
			ShopBuySilverSocketHandler.send(GlobalData.playerid, idx);
		}
	}
}