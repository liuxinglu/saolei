package bajie.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class BajieDispatcher
	{
		//---------------模块操作-------------------
		public static const MODULE_OPEN_HALL:String = "MODULE_OPEN_HALL"; //打开大厅
		public static const MODULE_OPEN_FRIEND:String = "MODULE_OPEN_FRIEND"; //打开好友
		public static const MODULE_OPEN_VSROOM:String  = "MODULE_OPEN_VSROOM"; //打开对战战房间
		public static const MODULE_OPEN_ROOM:String = "MODULE_OPEN_ROOM";  //房间界面
		public static const MODULE_OPEN_REGISTER:String = "MODULE_OPEN_REGISTER";//打开注册面板
		
		//---------------登录-----------------------
		public static const LOGIN_START:String = "LOGIN_START";			//登录开始
		public static const LOGIN_SUCCESS:String = "LOGIN_SUCCESS";		//登录成功
		public static const LOGIN_ENTER_GAME_SUCCESS:String = "LOGIN_ENTER_GAME_SUCCESS";	//进入场景
		public static const LOGIN_FAILED:String = "LOGIN_FAILED";		//登录失效
		public static const LOGIN_INTO_SCENE_SUCCESS:String = "LOGIN_INTO_SCENE_SUCCESS"; 	//进入场景成功
		public static const LOGIN_INTO_SCENE_FAILED:String = "LOGIN_INTO_SCENE_FAILED";		//进入场景失败
		
		
		//---------------场景------------------------
		public static const SCENE_LOADING_INTO:String = "SCENE_LOADING_INTO";		//场景加载
		public static const SCENE_LOADING_EXIT:String = "SCENE_LOADING_EXIT";		//场景退出
		public static const SCENE_START_TO_SETUP:String = "SCENE_START_TO_SETUP";	//场景构建
		public static const SCENE_CHANGE:String = "SCENE_CHANGE";					//场景切换
		public static const SCENE_FOCUS:String = "SCENE_FOCUS";						//场景激活
		
		
		public static const SCENE_SELECT_PLAYER:String = "SCENE_SELECT_PLAYER";		//选择人物
		public static const BAG_OPEN:String = "BAG_OPEN";							//打开背包
		public static const BAG_CLOSE:String = "BAG_CLOSE";							//关闭背包
		
		public static const GET_ATT_SUCCESS:String = "GET_ATT_SUCCESS";				//	获取属性成功
		public static const RISK_MESSAGE:String = "RISK_MESSAGE";					//	浮动提示
		public static const ALERT_MESSAGE:String = "ALERT_MESSAGE";				//弹框提示
		public static const CONFIRM_MESSAGE:String = "CONFIRM_MESSAGE";									//确认弹框提示
		private static var _instance:BajieDispatcher;
		private var _eventDispatcher:IEventDispatcher;
		
		public static function getInstance():BajieDispatcher
		{
			if(_instance == null)
			{
				_instance = new BajieDispatcher();
			}
			return _instance;
		}
		
		public function BajieDispatcher(target:IEventDispatcher = null)
		{
			_eventDispatcher = new EventDispatcher(target);
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:ParamEvent):Boolean
		{
			return _eventDispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return _eventDispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return _eventDispatcher.willTrigger(type);
		}
	}
}