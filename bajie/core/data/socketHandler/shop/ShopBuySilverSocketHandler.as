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
	public class ShopBuySilverSocketHandler extends BaseSocketHandler 
	{
		
		public function ShopBuySilverSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.MALL_BUY_SILVER;
		}
		
		override public function handlePackage():void
		{
			//trace("设置步骤3");
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("银币购买道具失败");
			}
			else
			{
				//
			}
			handComplete();
		}
		
		public static function send(playid:uint,idx:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.MALL_BUY_SILVER);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.idx = idx;
			jo.setObject(ProtocolType.MALL_BUY_SILVER, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}