package bajie.constData
{
	import bajie.events.BajieDispatcher;
	import bajie.events.ParamEvent;
	import bajie.events.CommonModuleEvent;

	/**
	公共配置数据
	*/
	public class CommonConfig
	{
		
		public static var GAME_WIDTH:int = 900;
		public static var GAME_HEIGHT:int = 600;
		public static var isFull:Boolean = false;
		
		/**
		 * 协议包头长度
		 */		
		public static const PACKAGE_HEAD_SIZE:int = 5;
		/**
		 * 包压缩长度
		 */		
		public static const PACKAGE_COMRESS_LEN:int = 300;
		
		/**
		 * 协议包加密种子
		 */		
		public static var protocolSeer:int = -1;
		/**
		 * 每帧毫秒数
		 */		
		public static var tick:int = 40;
		/**
		 * 模态透明值
		 */		
		public static const MODE_ALPHA:Number = 0.5;
		/**
		 * 双击间隔
		 */		
		public static const DOUBLE_CLICK_TIME:int = 180;
		
		public static const WALK_STEP_DISTANCE:int = 6;
		/**
		 * 技能效果速度
		 */		
		public static const EFFECT_STEP_DISTANCE:int = 36;
		/**
		 * 公共CD时间
		 */		
		public static const COMMONCD:Number = 1200;
		
		/**
		 * 是否调试版本
		 */		
		public static var ISDEBUG:Boolean;
		public static var DEBUGV:Number;
		/**
		 * 等待框资源
		 */		
		public static var WAITTINGBG:int;
		/**
		 * 使用缓存
		 */		
		public static var CACHELOCAL:Boolean;
		/**
		 * 允许客户端数0为不限制
		 */		
		public static var CLIENTNUM:int;
		/**
		 * 语言版本
		 */		
		public static var LANGUAGE:String = "cn";
		
		/**
		 * 默认字体
		 */		
		public static var DEFAULT_FONT:String;
		
		/**
		数据正确验证
		*/
		public static var SUCCESS:uint = 888;
		
		/**
		 * 背包格子列数
		 */
		public static const BAG_COL_SIZE:int = 7;
		/**
		 * 背包格子行数
		 */		
		public static const BAG_ROW_SIZE:int = 6;
		/**
		 * 默认字体大小
		 */		
		public static var DEFAULT_FONTSIZE:int;
		/**
		 * 背包人物属性格子数
		 */		
		public static const BAG_ATT_ITEM_NUM:int = 11;
		/**
		 * 背包携带道具数
		 */		
		public static const BAG_PROP_ITEM_NUM:int = 4;
				
		/**
		 *道具房 
		 */		
		public static const PROP_ROOM:int = 1;
		/**
		 *非道具房 
		 */		
		public static const NO_PROP_ROOM:int = 2;
		/**
		 *传统房 
		 */		
		public static const CLASSIC_ROOM:int = 3;
		
		/**
		 *初级房 
		 */		
		public static const JUNIOR_LEVEL:int = 1;
		/**
		 *中级房 
		 */		
		public static const NORMAL_LEVEL:int = 2;
		/**
		 *高级房 
		 */		
		public static const HIGH_LEVEL:int = 3;
		/**
		显示
		*/
		public static const ALLOW_SHOW:int = 1;
		/**
		关闭
		*/
		public static const ALLOW_HIDE:int = 0;
		
		/**
		点击延迟时间
		*/
		public static const DELAY_TIME:int = 200;

		
		public static function setGameSize(w:Number, h:Number):void
		{
			GAME_WIDTH = w;
			GAME_HEIGHT = h;
			BajieDispatcher.getInstance().dispatchEvent(new ParamEvent(CommonModuleEvent.GAME_SIZE_CHANGE));
		}
		
		public static function initConfigData(config:XML):void
		{
			//FAVORITENAME = config.config.FAVORITENAME.@value;
			ISDEBUG = String(config.config.DEBUGING.@value) == "true";
			ISDEBUG = false;
			DEBUGV = Number(config.config.DEBUGING.@cv);
			WAITTINGBG = int(config.config.WAITINGBG.@value);
			CACHELOCAL = String(config.config.CACHELOCAL.@value) == "true";
			CLIENTNUM = int(config.config.MULTINUM.@value);
			LANGUAGE = String(config.config.LANGUAGE.@value);
			DEFAULT_FONT = String(config.config.FONT.@value);
			DEFAULT_FONTSIZE = int(config.config.FONT.@size); 
		}
	}
}