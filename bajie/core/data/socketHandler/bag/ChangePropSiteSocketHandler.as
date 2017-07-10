package bajie.core.data.socketHandler.bag
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	
	public class ChangePropSiteSocketHandler extends BaseSocketHandler
	{
		public function ChangePropSiteSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.CHANGE_PROP_SITE;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			handComplete();
		}
		
		/**
		 * @param fromindex 背包内开始拖动索引位置从0开始
		 * @param toIndex 背包内结束拖动索引位置从0开始
		 * 
		 */		
		public static function send(fromindex:int, toIndex:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.CHANGE_PROP_SITE);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object;
			oo.playerid = GlobalData.playerid;
			oo.fromindex = fromindex;
			oo.toindex = toIndex;
			jo.setObject(ProtocolType.CHANGE_PROP_SITE, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}