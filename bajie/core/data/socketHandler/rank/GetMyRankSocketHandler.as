package bajie.core.data.socketHandler.rank 
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
	public class GetMyRankSocketHandler extends BaseSocketHandler 
	{
		
		public function GetMyRankSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.GET_MYRANK;
		}
		
		override public function handlePackage():void
		{
			//trace("设置步骤3");
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("获取我的排行失败");
			}
			else
			{
				GlobalData.rankInfo.showMyRank(o);
			}
			handComplete();
		}
		
		public static function send(playid:uint,type:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GET_MYRANK);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.type = type;
			jo.setObject(ProtocolType.GET_MYRANK, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}