package bajie.core.data.socketHandler.register
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.events.BajieDispatcher;
	import bajie.events.ParamEvent;
	import bajie.interfaces.socket.IPackageOut;
	
	/**
	 *注册信息面板数据 
	 * @author liuxinglu
	 * 
	 */	
	public class RegisterPanelSocketHandler extends BaseSocketHandler
	{
		public function RegisterPanelSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.REGISTER_PALNE;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			BajieDispatcher.getInstance().dispatchEvent(new ParamEvent(BajieDispatcher.MODULE_OPEN_REGISTER, o));
			handComplete();
		}
	}
}