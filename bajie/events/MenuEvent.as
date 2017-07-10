package bajie.events 
{
	import flash.events.Event;
	
	public class MenuEvent extends ParamEvent
	{
		/**
		使用
		*/
		public static const MENU_USE:String = "MENU_USE";
		/**
		出售
		*/
		public static const MENU_SALE:String = "MENU_SALE";
		/**
		移动
		*/
		public static const MENU_MOVE:String = "MENU_MOVE";
		/**
		强化
		*/
		public static const MENU_ENHANCE:String = "MENU_ENHANCE";
		/**
		修理
		*/
		public static const MENU_REPAIR:String = "MENU_REPAIR";
		/**
		卸载
		*/
		public static const MENU_UNSNACH:String = "MENU_UNSNACH";
		/**
		洗练
		*/
		public static const MENU_REBUILD:String = "MENU_REBUILD";
		
		public function MenuEvent(type:String, param:Object = null, bubbles:Boolean = false, cancelEnable:Boolean = false) {
			// constructor code
			super(type, param, 0, bubbles, cancelEnable);
		}

	}
	
}
