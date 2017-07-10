package bajie.core.data.socketHandler.shop 
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
	public class ShopBuyGoldSocketHandler extends BaseSocketHandler 
	{
		
		public function ShopBuyGoldSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.MALL_BUY_GOLD;
		}
		
		override public function handlePackage():void
		{
			//trace("设置步骤3");
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("金币购买道具失败");
			}
			else
			{
				//
			}
			handComplete();
		}
		
		public static function send(playid:uint,idx:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.MALL_BUY_GOLD);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.idx = idx;
			jo.setObject(ProtocolType.MALL_BUY_GOLD, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}