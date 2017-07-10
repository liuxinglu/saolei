package bajie.core.data.navigation 
{
	import flash.events.EventDispatcher;
	import bajie.events.ParamEvent;
	import bajie.core.data.socketHandler.main.*;
	import bajie.core.data.GlobalData;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class Navigation extends EventDispatcher 
	{
		
		public function Navigation() 
		{
			
		}
		public function updateTime(o:Object):void {
			this.dispatchEvent(new ParamEvent(ParamEvent.UPDATE_ONLINE_TIME,o));
		}
		public function getOnlineTime():void {
			GetOnlineTimeSocketHandler.send(GlobalData.playerid);
		}
		public function updateOnlineTime():void {
			UpdateOnlineTimeSocketHandler.send(GlobalData.playerid);
		}
		public function getOnlineAward():void {
			GetOnlineAwardSocketHandler.send(GlobalData.playerid);
		}
	}

}