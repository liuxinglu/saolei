package bajie.interfaces.socket
{
	import bajie.interfaces.dispose.IDispose;
	import flash.events.IEventDispatcher;
	
	public interface ISocketHandler extends IEventDispatcher,IDispose
	{
		/**
		 * 获得协议值
		 * @return 
		 * 
		 */		
		function getCode():int;
		/**
		 * 更新协议数据
		 * @param param
		 * 
		 */		
		function configure(param:Object):void;
		/**
		 * 处理协议
		 * 
		 */		
		function handlePackage():void;
	}
}