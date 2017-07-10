package bajie.core.data.fight.regard.vo
{
	//{no， name-玩家名称, title--军衔, bomCount--排雷个数, timer--耗时，exp--获取经验, silver--获取银币, vip--是否vip， vipsilver}
	public class RankVO
	{
		/**
		 *排名 
		 */		
		public var no:uint = 0;
		/**
		 *玩家名称 
		 */		
		public var name:String = "";
		/**
		 *军衔 
		 */		
		public var title:String = "";
		/**
		 *排雷个数 
		 */		
		public var bomCount:int = 0;
		/**
		 *耗时 
		 */		
		public var timer:uint = 0;
		/**
		 *获取经验 
		 */		
		public var exp:uint = 0;
		/**
		 *获取银币 
		 */		
		public var silver:uint = 0;
		/**
		 *是否vip 
		 */		
		public var vip:uint = 0;
		/**
		 *vip银币数量 
		 */		
		public var vipSilver:uint = 0;
		
		public function RankVO()
		{
		}
	}
}