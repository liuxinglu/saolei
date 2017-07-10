package bajie.core.data.socketHandler.clearmines
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.constData.CommonConfig;
	import bajie.core.data.GlobalData;
	
	/**
	 *游戏倒计时，有人完成后，接收到30秒倒计时
	 * @author liuxinglu
	 * 
	 */	
	public class GameInvertTimeSocketHandler extends BaseSocketHandler
	{
		public function GameInvertTimeSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.GAME_INVERT_TIME;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				
			}
			else
			{
				trace("----------------------------gameInverTime");
				GlobalData.fightInfo.gameInvertTime(o);
				trace("----------------------------gameInverTime-end");
			}
			handComplete();
		}
	}
}