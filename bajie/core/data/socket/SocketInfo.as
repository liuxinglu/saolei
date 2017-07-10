package bajie.core.data.socket 
{
	import bajie.interfaces.socket.ISocketInfo;
	
	public class SocketInfo implements ISocketInfo
	{
		private var _ip:String;
		private var _port:int;

		public function SocketInfo(ip:String, port:int) 
		{
			// constructor code
			_ip = ip;
			_port = port;
		}
		
		public function get ip():String
		{
			return _ip;
		}
		
		public function set ip(ip:String):void
		{
			this._ip = ip;
		}
		
		public function get port():int
		{
			return _port;
		}
		
		public function set port(port:int):void
		{
			this._port = port;
		}

	}
	
}
