package bajie.core.data.socketHandler.clearmines
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.constData.CommonConfig;
	import bajie.core.data.GlobalData;

	public class GameOverFailSocketHandler extends BaseSocketHandler
	{
		public function GameOverFailSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}

		override public function getCode():int
		{
			return ProtocolType.GAME_OVER_FAIL;
		}

		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if (o.code != CommonConfig.SUCCESS)
			{

			}
			else
			{
				GlobalData.fightInfo.gameFail(o);
			}
			handComplete();
		}

		public static function send():void
		{

		}
	}
}