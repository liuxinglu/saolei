package bajie.core.data.room.vo
{
	/**
	 *{"protocol":1013,"version":1,"number":"20121211153707","
	 * body":"{\"guid\":\"00000000-0000-0000-0000-000000000000\",\"
	 * playerid\":1,\"teamid\":0,\"name\":\"测试房间\",\"level\":1,\"captain\":0,\"
	 * password\":\"\",\"map\":2,\"number\":3,\"count\":1,\"shut\":0,\"doing\":0,\"mode\":1,\"grade\":3}"} 
	 * @author liuxinglu
	 * 房间对象
	 */	
	public class RoomVO
	{
		/**
		 *不用 
		 */		
		public var guid:String = "";
		/**
		 *玩家id 不用 
		 */		
		public var playerid:uint = 0;
		/**
		 * 房间id
		 */		
		public var roomId:uint = 0;
		/**
		 *房间名称 
		 */		
		public var name:String = "";
		/**
		 *不用 
		 */		
		public var level:uint = 0;
		/**
		 * 不用
		 */		
		public var captain:uint = 0;
		public var password:String = "";
		/**
		 *地图id 
		 */		
		public var map:uint = 0;
		/**
		 *房间内有几个位子 不用 
		 */		
		public var number:uint = 0;
		/**
		 *不用 
		 */		
		public var count:uint = 0;
		/**
		 *是否聊天 不用 
		 */		
		public var shut:uint = 0;
		/**
		 *是否在游戏 
		 */		
		public var doing:uint = 0;
		/**
		 *房间类型 
		 */		
		public var mode:uint = 0;
		/**
		 *难度级别 
		 */		
		public var grade:uint = 0;
		public function RoomVO()
		{
		}
	}
}