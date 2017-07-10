package bajie.core.data.sign 
{
	import flash.events.EventDispatcher;
	import bajie.core.data.socketHandler.sign.*;
	import bajie.events.ParamEvent;
	import bajie.core.data.GlobalData;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class SignInfo extends EventDispatcher 
	{
		
		public function SignInfo() 
		{
			
		}
		/**
		 * 获取签到数据
		 * @param	year
		 * @param	month
		 */
		public function getSignDate(year:int,month:int):void {
			SignGetInfoSocketHandler.send(GlobalData.playerid, year, month);
		}
		/**
		 * 更新签到数据
		 * @param	o
		 */
		public function updateDate(o:Object):void {
			this.dispatchEvent(new ParamEvent(ParamEvent.GET_SIGN_INFO,o));
		}
		/**
		 * 签到
		 */
		public function signOn():void {
			SignSureDaySocketHandler.send(GlobalData.playerid);
		}
		/**
		 * 获取累计签到奖励
		 */
		public function getSignItem(year:int,month:int,type:int):void {
			SignGetAwardSocketHandler.send(GlobalData.playerid, year, month, type);
		}
		
		/**
		 * 用户补签
		 * @param	year
		 * @param	month
		 * @param	day
		 */
		public function reSignOn(year:int,month:int,day:int):void {
			SignSupplementDaySocketHandler.send(GlobalData.playerid, year, month, day);
		}
	}

}