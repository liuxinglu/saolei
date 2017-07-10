package bajie.core.data.fight
{
	import bajie.core.data.GlobalData;
	import bajie.core.data.socketHandler.clearmines.ClearMinesSocketHandler;
	import bajie.events.AlertEvent;
	import bajie.events.ParamEvent;
	
	import flash.events.EventDispatcher;
	import bajie.core.data.socketHandler.clearmines.GameOverRankSocketHandler;
	import flash.events.Event;
	import bajie.core.data.socketHandler.clearmines.GamePrizeResultSocketHandler;
	import bajie.core.data.socketHandler.clearmines.GameOverPrizeSocketHandler;
	
	public class FightInfo extends EventDispatcher
	{
		public function FightInfo()
		{
		}
		
		/**
		 *进入战斗界面 
		 * @param playerid
		 * 
		 */		
		public function enterBattleField(o:Object):void
		{
			
			this.dispatchEvent(new ParamEvent(ParamEvent.GET_BATTLE_FIELD_INFO, o));
		}
		
		/**
		 *重绘雷盘 
		 * @param o
		 * 
		 */		
		public function reDrawBattleField(o:Object):void
		{
			this.dispatchEvent(new ParamEvent(ParamEvent.RE_DRAW_BATTLE_FIELD, o));
		}
		
		/**
		 *排雷 
		 * @param o
		 * 
		 */		
		public function clearMine(o:Object):void
		{
			ClearMinesSocketHandler.send(o.roomId, o.key, o.index);
		}
		
		/**
		 *游戏胜利 
		 */		
		public function gameSuccess(o:Object):void
		{
			/*var o:Object = new Object;
			o.message = "游戏胜利";
			GlobalData.alertInfo.addEventListener(AlertEvent.CLOSE, gameSuccessCloseHandler);
			GlobalData.alertInfo.pureAlert(o);*/
			this.dispatchEvent(new Event("GAMESUCCESS"));
		}
		
		/**
		 *游戏失败 
		 */		
		public function gameFail(o:Object):void
		{
			/*var o:Object = new Object;
			o.message = "游戏失败";
			GlobalData.alertInfo.addEventListener(AlertEvent.CLOSE, gameCloseHandler);
			GlobalData.alertInfo.pureAlert(o);*/
			this.dispatchEvent(new Event("GAMEFAIL"));
		}
		
		/*private function gameSuccessCloseHandler(e:AlertEvent):void
		{
			this.dispatchEvent(new AlertEvent(AlertEvent.NORMAL_CLOSE));
		}
		
		private function gameCloseHandler(e:AlertEvent):void
		{
			this.dispatchEvent(new AlertEvent(AlertEvent.FAIL_CLOSE));
		}*/
		
		/**
		 * 更新排雷显示数量
		 * */
		public function updateMineNum(o:Object):void
		{
			this.dispatchEvent(new ParamEvent(ParamEvent.UPDATE_MINE_NUM, o));
		}
		
		/**
		获取排行
		*/
		public var rankO:Object;
		//收到消息后开始抽奖
		public function getRankList(o:Object):void
		{
			rankO = o;
			this.dispatchEvent(new ParamEvent(ParamEvent.GET_RANK));
		}
		
		/**
		发送抽奖结果
		*/
		public function sendPrizeRequest(roomid:String, key:String, index:String):void
		{
			GameOverPrizeSocketHandler.send(roomid, key, index);
		}
		
		//获得抽奖结果
		public function getPrizeResult(o:Object):void
		{
			this.dispatchEvent(new ParamEvent("GAMERESULT", o));
		}
		
		/**
		游戏倒计时
		*/
		public function gameInvertTime(o:Object):void
		{
			this.dispatchEvent(new ParamEvent("INVERT_TIME"));
		}
		
	}
}