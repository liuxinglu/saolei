package bajie.core.data.rank 
{
	import flash.events.EventDispatcher;
	import bajie.events.ParamEvent;
	import bajie.core.data.socketHandler.rank.*;
	import bajie.core.data.GlobalData;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class RankInfo extends EventDispatcher 
	{
		
		public function RankInfo() 
		{
			
		}
		public function getRankInfo(index:int,type:int):void {
			GetRankInfoSocketHandler.send(GlobalData.playerid, index,type);
		}
		public function showRankInfo(o:Object):void {
			this.dispatchEvent(new ParamEvent(ParamEvent.UPDATE_RANK_INFO, o));
		}
		public function getMyRank(type:int):void {
			GetMyRankSocketHandler.send(GlobalData.playerid,type);
		}
		public function showMyRank(o:Object):void {
			this.dispatchEvent(new ParamEvent(ParamEvent.UPDATE_MYRANK, o));
		}
	}

}