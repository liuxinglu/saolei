package bajie.core.data.socketHandler.alert
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalData;
	import bajie.core.data.socket.BaseSocketHandler;
	
	public class AlertSocketHandler extends BaseSocketHandler
	{
		public function AlertSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.ALERT_MESSAGE;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			GlobalData.alertInfo.pureAlert(o);
			handComplete();
		}
	}
}