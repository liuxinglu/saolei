package bajie.events
{
	import flash.events.Event;

	public class ItemEvent extends ParamEvent
	{
		public static const ITEM_CLICK:String = "ITEM_CLICK";//格子点击
		public static const ITEM_OVER:String = "ITEM_OVER";//鼠标放上格子
		public static const ITEM_OUT:String = "ITEM_OUT";//鼠标移出格子
		public static const ITEM_DOWN:String = "ITEM_DOWN";//鼠标按下
		public static const ITEM_INFO:String = "ITEM_INFO";//格子基础信息
		
		public static const UPDATE:String = "update";
		public static const LOCK_UPDATE:String = "lock_update";
		public static const COOLDOWN_UPDATE:String = "COOLDOWN_UPDATE";
		
		public function ItemEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, 0, bubbles, cancelable);
		}
	}
}