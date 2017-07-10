package bajie.core.data.socketHandler.clearmines {
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.constData.ProtocolType;
	import bajie.constData.CommonConfig;
	import bajie.core.data.GlobalData;
	
	public class GameUserStateSocketHandler extends BaseSocketHandler{

		public function GameUserStateSocketHandler(handData:Object = null) {
			// constructor code
			super(handData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.GAME_USER_STATE;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				GlobalData.alertInfo.pureAlert(o);
			}
			else
			{
				GlobalData.fightInfo.updateMineNum(o);
			}
			handComplete();
		}

	}
	
}
