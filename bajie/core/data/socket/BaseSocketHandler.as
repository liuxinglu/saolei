package bajie.core.data.socket
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import bajie.interfaces.socket.ISocketHandler;
	import flash.utils.ByteArray;
	import bajie.interfaces.socket.IPackageIn;
	
	public class BaseSocketHandler extends EventDispatcher implements ISocketHandler
	{
		protected var _data:IPackageIn
		protected var _handlerData:Object;
		
		public function BaseSocketHandler(handlerData:Object = null)
		{
			_handlerData = handlerData;
		}
		
		public function getCode():int
		{
			return 0;
		}
		
		public function configure(param:Object):void
		{
			var t:IPackageIn = param as IPackageIn;
			_data = t;
		}
		
		public function handlePackage():void
		{
			
		}
		
		public function handComplete():void
		{
			_data = null;
		}
		
		public function dispose():void
		{
			_handlerData = null;
			_data = null;
		}
	}

}