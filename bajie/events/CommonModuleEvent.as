package bajie.events
{
	import flash.events.Event;
	
	/**
	共用模块事件
	*/
	public class CommonModuleEvent extends Event
	{
		/**
		事件日期更新（新一天）
		*/
		public static const DATETIME_UPDATE:String = "dateTimeUpdate";
		/**
		 * 显示物品tip
		 */		
		public static const SHOW_ITEMTIP:String = "showItemTip";
		/**
		 * 获取物品信息成功
		 */		
		public static const LOAD_ITEMINFO_COMPLETE:String = "loadItemInfoComplete";
		/**
		 * 更新物品冷却时间
		 * 1HP
		 * 2MP
		 */		
		public static const UPDATE_ITEM_CD:String = "updateItemCD";
		/**
		 * 获得焦点
		 */		
		public static const ACTIVATE:String = "activate";
		/**
		 * 失去焦点
		 */		
		public static const DEACTIVATE:String = "deactivate";
		/**
		 * 设置引导tip
		 */		
		public static const SET_GUIDETIP:String = "setGuideTip"; 
		/**
		 * 拖动结束
		 */		
		public static const DRAG_COMPLETE:String = "dragComplete";
		/**
		 *音效开关 
		 */
		public static const VOICE_CHANGE:String = "voiceChange";
		
		/**
		接受战斗邀请开关
		*/
		public static const FRIGHT_INVITE_CHANGE:String = "fright_invite_change";
		
		/**
		好友上线提示
		*/
		public static const FRIEND_ONLINE:String = "friend_online";
		
		/**
		
		*/
		/**
		 * 升级
		 */		
		public static const UPGRADE:String = "upgrade";

		/**
		游戏场景大小更新
		*/
		public static const GAME_SIZE_CHANGE:String = "gameSizeChange";
		public var data:Object;
		
		public function CommonModuleEvent(type:String, obj:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			data = obj;
			super(type, bubbles, cancelable);
		}
	}
}