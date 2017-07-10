package bajie.manager.socket 
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import bajie.interfaces.socket.*;
	import bajie.utils.socket.NetSocket;
	import bajie.events.SocketEvent;
	import bajie.utils.socket.PackageIn;
	import bajie.utils.socket.PackageOut;

	public class SocketManager extends EventDispatcher implements ISocketManager
    {
        private var _connectSuccessHandler:Function
        private var _socket:NetSocket;
        private var _socketHandlers:Dictionary;
        private var _connectErrorHandler:Function;

        public function SocketManager()
        {
            _socketHandlers = new Dictionary();
            return;
        }// end function

        public function addSocketHandler(handler:ISocketHandler) : void
        {
			
            if (_socketHandlers[handler.getCode()] != null)
            {
            }
            if (_socketHandlers[handler.getCode()] == undefined)
            {
                _socketHandlers[handler.getCode()] = handler;
            }
            return;
        }// end function

        public function handleSecuityError() : void
        {
            if (_connectErrorHandler != null)
            {
                _connectErrorHandler();
            }
            dispatchEvent(new SocketEvent(SocketEvent.SECURITY_ERROR));
            return;
        }// end function

        public function send(pkg:IPackageOut) : Boolean
        {
            if (_socket == null)
            {
                return false;
            }
            //var sdata:String = JSON.stringify(ByteArray(pkg).toString());
			//trace("socketmanager-send");
            return _socket.send(pkg);
        }// end function

        public function isSameSocket(info:ISocketInfo) : Boolean
        {
            if (!_socket)
            {
                return false;
            }
            return _socket.isSameSocket(info);
        }// end function

        public function disConnect() : void
        {
            if (_socket)
            {
                _socket.dispose();
                _socket = null;
            }
            return;
        }// end function

        public function isConnect() : Boolean
        {
            if (_socket)
            {
            }
            return _socket.isConnect();
        }// end function

        public function handleConnect() : void
        {
            if (_connectSuccessHandler != null)
            {
                _connectSuccessHandler();
            }
            dispatchEvent(new SocketEvent(SocketEvent.CONNECT_SUCCESS));
            return;
        }// end function

        public function handleConnectFail() : void
        {
            if (_connectErrorHandler != null)
            {
                _connectErrorHandler();
            }
            dispatchEvent(new SocketEvent(SocketEvent.CONNECT_FAIL));
            return;
        }// end function

        public function handleClose() : void
        {
            dispatchEvent(new SocketEvent(SocketEvent.SOCKET_CLOSE));
            return;
        }// end function

        public function removeSocketHandler(code:int) : void
        {
            if (_socketHandlers[code] != null)
            {
                _socketHandlers[code].dispose();
                _socketHandlers[code] = null;
                delete _socketHandlers[code];
            }
            return;
        }// end function

        public function setSocket(info:ISocketInfo, successHandler:Function = null, errorHandler:Function = null) : void
        {
            if (_socket == null)
            {
                _socket = new NetSocket(this);
            }
			/*try
			{
			_socket.close();
			}
			catch(e:Error)
			{}*/
			_connectSuccessHandler = successHandler;
            _connectErrorHandler = errorHandler;
            _socket.connect(info);
            return;
        }// end function

        public function close() : void
        {
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
            return;
        }// end function

        public function getPackageIn(src:ByteArray, len:int, autoDecode:Boolean = true) : IPackageIn
        {
            return new PackageIn(src, len, autoDecode);
        }// end function

        public function getPackageOut(code:int) : IPackageOut
        {
            return new PackageOut(code);
        }// end function
		
        public function handlePackage(pkg:IPackageIn) : void
        {
			var sock:ISocketHandler = _socketHandlers[pkg.code] as ISocketHandler;
			trace("1");
			if(sock != null)
			{
				trace("2");
				pkg.position = 0;
				sock.configure(pkg);
				sock.handlePackage();
			}
			pkg.position = 0;
            dispatchEvent(new SocketEvent(SocketEvent.SOCKET_DATA, pkg));
            return;
        }// end function

    }

	
}
