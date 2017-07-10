package bajie.events
{
	import flash.events.Event;
	
	public class ParamEvent extends Event
	{
		/**
		获取大厅数据
		*/
		public static const GET_HALL_INFO:String = "GET_HALL_INFO";
		
		/**
		 *获取房间信息 
		 */		
		public static const GET_ROOM_INFO:String = "GET_ROOM_INFO";
		
		/**
		 *获取战斗界面信息 
		 */		
		public static const GET_BATTLE_FIELD_INFO:String = "GET_BATTLE_FIELD_INFO"; 
		
		/**
		 *重绘战斗界面 
		 */		
		public static const RE_DRAW_BATTLE_FIELD:String = "RE_DRAW_BATTLE_FIELD";
		
		/**
		 *获取邮件列表
		 */		
		public static const GET_MAIL_LIST:String = "GET_MAIL_LIST";
		/**
		 *显示邮件装备详细信息
		 */		
		public static const SHOW_EMAIL_DETAILS:String = "SHOW_EMAIL_DETAILS";
		
		/**
		 *获取用户设置信息
		 */		
		public static const GET_USER_SET:String = "GET_USER_SET";
		
		/**
		 *获取用户技能信息
		 */		
		public static const GET_SKILL_LIST:String = "GET_SKILL_LIST";
		/**
		 * 更新在线奖励时间
		 */
		public static const UPDATE_ONLINE_TIME:String = "UPDATE_ONLINE_TIME";
		/**
		 * 获取签到信息
		 */
		public static const GET_SIGN_INFO:String = "GET_SIGN_INFO";
		/**
		 *获取用户已装备技能信息
		 */		
		public static const GET_EQUIP_SKILL:String = "GET_EQUIP_SKILL";
		/**
		 * 获取强化界面道具信息
		 */ 
		public static const GET_UPDATE_MATERIAL:String = "GET_UPDATE_MATERIAL";
		/**
		 * 获取强化界面基础信息
		 */ 
		public static const GET_UPDATE_INFO:String = "GET_UPDATE_INFO";
		/**
		 * 获取好友界面列表
		 */
		public static const GET_FRIENDS_LIST:String = "GET_FRIENDS_LIST";
		/**
		 * 获取黑名单列表
		 */
		public static const GET_BLACK_LIST:String = "GET_BLACK_LIST";
		/**
		获取用户简单信息
		*/
		public static const GET_SIMPLE_PLAYER_INFO:String = "GET_SIMPLE_PLAYER_INFO";
		
		/**
		 * 获取任务列表
		 */
		public static const GET_TASK_LIST:String = "GET_TASK_LIST";
		/**
		 *成功退出 
		 */		
		public static const EXIT_SUCCESS:String = "EXIT_SUCCESS";
		/**
		 *更新排雷数量信息 
		 */		
		public static const UPDATE_MINE_NUM:String = "UPDATE_MINE_NUM";
		/**
		 * 更新排行榜信息
		 */
		public static const UPDATE_RANK_INFO:String = "UPDATE_RANK_INFO";
		/**
		 * 更新我的排行信息
		 */
		public static const UPDATE_MYRANK:String = "UPDATE_MYRANK";
		/**
		 *获得排行 
		 */		
		public static const GET_RANK:String = "GET_RANK";

		private var _param:Object;
		private var _timespan:Number;
		
		public function ParamEvent(type:String, param:Object = null, timeSpan:Number = 0, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			_param = param;
			_timespan = timeSpan;
			super(type, bubbles, cancelable);
		}
		
		public function get Param():Object
		{
			return _param;
		}
		
		public function get Timespan():Number
		{
			return _timespan;
		}
	}
}