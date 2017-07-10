package bajie.module
{
	import flash.events.EventDispatcher;
	import bajie.events.ModuleEvent;
	import bajie.events.CommonModuleEvent;

	public class ModuleEventDispatcher
	{
		/**
		模块事件
		*/
		private static const _moduleDispatch:EventDispatcher = new EventDispatcher();
		public static function addModuleEventListener(type:String, listener:Function, useCaptrue:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_moduleDispatch.addEventListener(type, listener, useCaptrue, priority, useWeakReference);
		}
		
		public static function removeModuleEventListener(type:String, listener:Function, useCaptrue:Boolean = false):void
		{
			_moduleDispatch.removeEventListener(type, listener, useCaptrue);
		}
		
		public static function dispatchModuleEvent(event:ModuleEvent):void
		{
			_moduleDispatch.dispatchEvent(event);
		}
		
		
		/**
		共用模块事件
		*/
		private static const _commonModuleDispatch:EventDispatcher = new EventDispatcher();
		public static function addCommonModuleEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_commonModuleDispatch.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public static function removeCommonModuleEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_commonModuleDispatch.removeEventListener(type, listener, useCapture);
		}
		
		public static function dispatchCommonModuleEvent(e:CommonModuleEvent):void
		{
			_commonModuleDispatch.dispatchEvent(e);
		}
		
		
		/**
		
		*/
	}
}