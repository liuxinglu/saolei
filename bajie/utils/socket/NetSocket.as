package bajie.utils.socket
{
	import bajie.interfaces.socket.ISocketInfo;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import bajie.manager.socket.SocketManager;
	import flash.events.SecurityErrorEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.core.data.GlobalData;
	import bajie.interfaces.socket.IPackageIn;
	import bajie.utils.socket.PackageIn;
	import flash.net.XMLSocket;
	import flash.events.DataEvent;

	public class NetSocket extends Object
	{
		private var _info:ISocketInfo;
		private var _socket:XMLSocket;
		private var _readBuffer:ByteArray;
		private var _socketManager:SocketManager;
		private var _changingConnet:Boolean;
		private var msgLenMax:int;//收到的消息最大长度
		private var msgLen:int;//消息长度
		private var headLen:int;//消息头长度
		private var isReadHead:Boolean;//是否已经读了消息头
		private var _messageString:String = "";
		private var _messageBuffer:String = "";//消息缓冲

		public function NetSocket(socketManager:SocketManager)
		{
			// constructor code
			_socketManager = socketManager;
			_readBuffer = new ByteArray  ;
			_socket = new XMLSocket();
			_changingConnet = false;
			initEvent();
			isReadHead = true;
			headLen = 4;
			msgLenMax = 8000;
		}

		private function initEvent():void
		{
			_socket.addEventListener(DataEvent.DATA, onSocketData);
			_socket.addEventListener(Event.CONNECT, handleConnect);
			_socket.addEventListener(Event.CLOSE, handleClose);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, handleIoError);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleSecuityError);
		}

		public function send(pkg:IPackageOut):Boolean
		{
			if (_socket != null)
			{
			}
			if (! _socket.connected)
			{
				return false;
			}
			
			_socket.send(pkg as ByteArray);
			GlobalData.chatInfo.showProtocolMessage("发送：" + pkg.toString());
			trace(pkg.toString());
			return true;
		}

		public function dispose():void
		{
			removeEvent();
			if (_socket)
			{
				if (_socket.connected)
				{
					_socket.close();
				}
			}
			_socket = null;
		}

		public function isConnect():Boolean
		{
			if (_socket)
			{
			}
			return _socket.connected;
		}



		public function close():void
		{
			if (_socket)
			{
				_socket.close();
			}
		}

		public function connect(info:ISocketInfo):void
		{
			var info:ISocketInfo = info;
			try
			{
				if (isSameSocket(info))
				{
					handleConnect(null);
					return;
				}
				_info = info;
				if (_socket)
				{
					if (_socket.connected)
					{
						_changingConnet = true;
						_socket.close();
					}
				}
				//_readBuffer = "";
				_socket.connect(_info.ip, _info.port);
			}
			catch (e:Error)
			{
				trace("socket connect error:" + e.message);
			}
		}

		public function isSameSocket(info:ISocketInfo):Boolean
		{
			if (! _info)
			{
				return false;
			}
			if (_info.ip == info.ip)
			{
			}
			if (_info.port == info.port)
			{
			}
			if (_socket)
			{
			}
			return _socket.connected;
		}

		private function handleSecuityError(e:SecurityErrorEvent):void
		{
			var evt:SecurityErrorEvent = e;
			//if(evt)
			//{
			trace(evt.text);
			//}
			if (_socket)
			{
				try
				{
					_socket.close();
				}
				catch (e:Error)
				{
				}
			}
			_socketManager.handleSecuityError();
		}



		private function handleConnect(event:Event):void
		{
			_changingConnet = false;
			_socketManager.handleConnect();
		}
		
		private function readPackage():void
		{
			
		}
		
		private function onSocketData(event:DataEvent):void
		{
			var s:String = event.data;
			var subStr:String;
			var byteArr2:ByteArray;
			_messageString = _messageBuffer + s;
			
			GlobalData.chatInfo.showProtocolMessage("接收----：" + _messageString);
			if(_messageString.indexOf("$") == -1)
			{
				_messageBuffer += _messageString;
			}
			else
			{
				do{
					subStr = _messageString.substring(0, _messageString.indexOf("$"));
					byteArr2 = new ByteArray;
					byteArr2.clear();
					byteArr2.writeMultiByte(subStr, "utf-8");
					byteArr2.position = 0;
					var pin:PackageIn = new PackageIn(byteArr2, byteArr2.bytesAvailable);
					_socketManager.handlePackage(pin);
					_messageString = _messageString.substr(_messageString.indexOf("$"));
				}while(_messageString.indexOf("$") > 0)
			}
		}

		private function listeners(len:int, byte:ByteArray):void
		{
			var pin:PackageIn = new PackageIn(byte,len,true);
			_socketManager.handlePackage(pin);
		}

		private function handleClose(event:Event):void
		{
			trace(event.currentTarget.toString());
			if (! _changingConnet)
			{
				_socketManager.handleClose();
			}
			_changingConnet = false;
		}



		private function handleIoError(e:IOErrorEvent):void
		{
			var evt:IOErrorEvent = e;
			if (evt)
			{
				trace(evt.text);
			}
			if (_socket)
			{
				try
				{
					_socket.close();
				}
				catch (e:Error)
				{
				}
			}
			_socketManager.handleConnectFail();
		}

		private function removeEvent():void
		{
			_socket.removeEventListener(DataEvent.DATA, onSocketData);
			_socket.removeEventListener(Event.CONNECT, handleConnect);
			_socket.removeEventListener(Event.CLOSE, handleClose);
			_socket.removeEventListener(IOErrorEvent.IO_ERROR, handleIoError);
			_socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleSecuityError);
		}
	}

}