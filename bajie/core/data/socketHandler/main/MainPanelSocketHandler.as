package bajie.core.data.socketHandler.main
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.events.BajieDispatcher;
	import bajie.events.ParamEvent;
	import bajie.core.data.socketHandler.login.LoginHeartDanceSocketHandler;
	
	/**
	 *主界面数据 
	 * @author liuxinglu
	 * 
	 */	
	public class MainPanelSocketHandler extends BaseSocketHandler
	{
		public function MainPanelSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		override public function getCode():int
		{
			return ProtocolType.MAIN_INFO;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			BajieDispatcher.getInstance().dispatchEvent(new ParamEvent(BajieDispatcher.LOGIN_INTO_SCENE_SUCCESS, o));
			LoginHeartDanceSocketHandler.startToDance();
			handComplete();
		}
		
		public static function enter(sessionKey:String):void
		{
			
		}
	}
}