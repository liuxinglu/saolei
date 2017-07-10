package bajie.core.data.socketHandler.clearmines
{
	import bajie.constData.CommonConfig;
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalData;
	import bajie.core.data.socket.BaseSocketHandler;
	
	public class GetPlateDetailsInfoSocketHandler extends BaseSocketHandler
	{
		public function GetPlateDetailsInfoSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		
		override public function getCode():int
		{
			return ProtocolType.GET_PLATE_DETAILS_INFO;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("~~~~~~~~~~~"+o.message);
			}
			else
			{
				GlobalData.fightInfo.reDrawBattleField(o);
			}
			handComplete();
		}
		
		public static function send():void
		{
			
		}
	}
}