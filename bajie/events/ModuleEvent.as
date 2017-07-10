package bajie.events
{
	import flash.events.Event;

	public class ModuleEvent extends Event
	{
		/**
		模块切换
		*/
		public static const MODULE_CHANGE:String = "MODULE_CHANGE";
		
		/**
		模块删除
		*/
		public static const MODULE_DISPOSE:String = "MODULE_DISPOSE";
		
		
		
		public var data:Object;
		
		public function ModuleEvent(type:String, obj:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			data = obj;
			super(type, bubbles, cancelable);
		}
	}
}