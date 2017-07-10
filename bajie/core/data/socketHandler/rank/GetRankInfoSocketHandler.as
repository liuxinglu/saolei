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
	public class GetRankInfoSocketHandler extends BaseSocketHandler 
	{
		
		public function GetRankInfoSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.GET_RANK_INFO;
		}
		
		override public function handlePackage():void
		{
			//trace("设置步骤3");
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("获取排行榜列表失败");
			}
			else
			{
				GlobalData.rankInfo.showRankInfo(o);
			}
			handComplete();
		}
		
		public static function send(playid:uint,index:int,type:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GET_RANK_INFO);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.index = index;
			oo.type = type;
			jo.setObject(ProtocolType.GET_RANK_INFO, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}