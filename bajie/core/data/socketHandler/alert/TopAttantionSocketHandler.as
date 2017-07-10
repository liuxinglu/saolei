package bajie.core.data.socketHandler.alert {
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalData;
	import bajie.core.data.socket.BaseSocketHandler;
	
	public class TopAttantionSocketHandler extends BaseSocketHandler{

		public function TopAttantionSocketHandler(handlerData:Object = null) {
			// constructor code
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.RISK_MESSAGE;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			GlobalData.alertInfo.topAttantionShow(o);
			handComplete();
		}

	}
	
}
