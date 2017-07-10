package bajie.core.data.user.vo
{
	/**
	 *对战玩家信息 
	 * @author liuxinglu
	 * 
	 */	
	public class PlayerVO
	{
		/**
		 *玩家id 
		 */		
		public var playerid:uint = 0;
		/**
		 *玩家昵称 
		 */		
		public var name:String = "";
		/**
		 * 社交头像
		 */
		public var avatar:String = "";
		/**
		玩家性别
		*/
		public var sex:uint = 0;
		/**
		 *玩家等级 
		 */		
		public var level:uint = 0;
		/**
		 *vip buffer 后端返回秒数 
		 */		
		public var vip:uint =0;
		/**
		 * 玩家能量值
		 */		
		public var energy:uint = 0;
		/**
		 *玩家幸运值 
		 * 
		 */
		public var lucky:uint = 0;
		/**
		 *玩家灵巧值 
		 */		
		public var dexterity:uint = 0;
		/**
		 *双倍经验 buffer 后端返回秒数 
		 */		
		public var exp:uint = 0;
		/**
		 *技能buffer 候选返回秒数 
		 */		
		public var skill:uint = 0;
		/**
		 *房间排序顺序 0123
		 */		
		public var index:uint = 0;
		/**
		 *1为准备， 0为未准备 
		 */		
		public var ready:uint = 1;
		/**
		 *1为队长 
		 */		
		public var captain:uint = 1;
		/**
		 *是否为玩家本身 
		 */		
		public var me:uint = 1;
		
		/**
		所携带的武器
		*/
		public var weapon:uint = 0;
		/**
		 *{"playerid":1,"name":"阿秋","sex":2,
		 * "avatar":"http://share.bajiegame.com/dungeon/images/job10.png",
		 * "level":1,"vip":0,"energy":0,"lucky":0,"dexterity":0,"exp":0,
		 * "skill":0,"index":0,"ready":1,"captain":1,"me":1} 
		 * 
		 */		
		public function PlayerVO()
		{
		}
	}
}