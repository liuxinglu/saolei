package bajie.interfaces.module
{
	import flash.events.IEventDispatcher;
	import bajie.interfaces.dispose.IDispose;
	
	public interface IModule extends IEventDispatcher, IDispose
	{
		function get moduleId():int;
		
		function setup(prev:IModule, data:Object = null):void;
		
		function free(next:IModule):void;
		/**
		进入相同模块
		*/
		function configure(data:Object):void;
		
		function getBackTo():int;
		
		function getBackToParm():Object;
	}
}