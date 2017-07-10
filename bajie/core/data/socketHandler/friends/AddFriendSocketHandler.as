package bajie.core.data.socketHandler.friends 
{
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalData;
	import bajie.core.data.GlobalAPI;
	import bajie.utils.SaoLeiTool;
	import bajie.constData.CommonConfig;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.core.data.dataFormat.JSONObject;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class AddFriendSocketHandler extends BaseSocketHandler 
	{
		
		public function AddFriendSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.ADD_FRIEND_LIST;
		}
		
		override public function handlePackage():void
		{
			//trace("设置步骤3");
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("添加好友失败");
			}
			else
			{
				//
			}
			handComplete();
		}
		
		public static function send(playid:uint,idx:int,name:String):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.ADD_FRIEND_LIST);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.idx = idx;
			oo.name = name;
			jo.setObject(ProtocolType.ADD_FRIEND_LIST, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}