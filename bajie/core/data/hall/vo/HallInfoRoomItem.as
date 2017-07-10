package bajie.core.data.hall.vo
{
	/**
	 *房间列表元素 
	 * 
	 */
	public class HallInfoRoomItem
	{
		/**
		 *后端需要 前端可以保存或抛弃 
		 */		
		public var guid:String = "";
		/**
		 * 创建房间的玩家id
		 */		
		public var playerid:String = "";
		/**
		 *房间id 
		 */		
		public var roomid:uint = 0;
		/**
		 *房间名称 
		 */		
		public var name:String = "";
		/**
		 *房间等级 目前没有用到
		 */		
		public var level:uint = 0;
		/**
		 *冗余数据 
		 */		
		public var captain:uint = 1;
		/**
		 *冗余数据 
		 */		
		public var password:String = "";
		/**
		 *选择的地图 
		 */		
		public var map:uint = 0;
		/**
		 *房间内有几个位子 
		 */		
		public var number:uint = 0;
		/**
		 *房间内目前有几个人加入
		 */		
		public var count:uint = 0;
		/**
		 *是否关闭聊天。 0为关闭， 1为打开 
		 */		
		public var shut:uint = 0;
		/**
		 *是否在游戏中。0为没有在游戏中，1为在游戏中 
		 */		
		public var doing:uint = 0;
		/**
		 *房间模式 
		 */		
		public var mode:uint = 0:
		/**
		 *扫雷难度 1为初级，2为中级， 3为高级 
		 */		
		public var grade:uint = 0;
		/**
		 *{"guid":"00000000-0000-0000-0000-000000000000","playerid":0,
		 * "teamid":6966,"name":"测试房间","level":1,"captain":1,"password":"",
		 * "map":2,"number":3,"count":1,"shut":0,"doing":0,"mode":1,"grade":3} 
		 * 
		 */		
		public function HallInfoRoomItem()
		{
		}
	}
}