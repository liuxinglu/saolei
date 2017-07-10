package bajie.core.data.socketHandler.room
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	
	public class SearchRoomSocketHandler extends BaseSocketHandler
	{
		public function SearchRoomSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.USER_SEARCH_ROOM;
		}
		
		override public function handlePackage():void
		{
			
		}
		
		public static function send(roomSearchContent:String = "", password:String = ""):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.USER_SEARCH_ROOM);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object();
			//oo.
		}
		
	}
}