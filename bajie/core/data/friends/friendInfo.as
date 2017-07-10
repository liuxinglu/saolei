package bajie.core.data.friends 
{
	import flash.events.EventDispatcher;
	import bajie.core.data.socketHandler.friends.*;
	import bajie.core.data.GlobalData;
	import bajie.events.ParamEvent;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class friendInfo extends EventDispatcher 
	{
		
		public function friendInfo() 
		{
			
		}
		/**
		 * 获取好友列表
		 */
		public function getFriendList(index:int):void {
			GetFriendsListSocketHandler.send(GlobalData.playerid,index);
		}
		/**
		 * 获取黑名单
		 */
		public function getBlackList(index:int):void {
			GetBlackListSocketHandler.send(GlobalData.playerid,index);
		}
		/**
		 * 显示好友列表
		 */
		public function showFriendList(o:Object):void {
			this.dispatchEvent(new ParamEvent(ParamEvent.GET_FRIENDS_LIST,o));
		}
		public function showBlackList(o:Object):void {
			this.dispatchEvent(new ParamEvent(ParamEvent.GET_BLACK_LIST,o));
		}
		/**
		 * 添加好友
		 */
		public function addFriend(idx:int,name:String):void {
			AddFriendSocketHandler.send(GlobalData.playerid,idx,name);
		}
		/**
		 * 加入黑名单
		 */
		public function addBlack(idx:int):void {
			AddBlackSocketHandler.send(GlobalData.playerid,idx);
		}
		/**
		 * 邀请好友
		 */
		private function inviteFriend():void {
			
		}
	}

}