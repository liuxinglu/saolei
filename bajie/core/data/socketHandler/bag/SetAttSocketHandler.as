package bajie.core.data.socketHandler.bag {
	import bajie.constData.CommonConfig;
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.core.data.socketHandler.alert.AlertSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	
	public class SetAttSocketHandler extends BaseSocketHandler{

		public function SetAttSocketHandler(handData:Object = null) {
			// constructor code
			super(handData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.SET_ATT;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				
			}
			
			handComplete();	
		}
		
		//"playerid\":1,\"energy\":1,\"lucky\":1,\"dexterity\":1,
		public static function send(energy:int, luck:int, dex:int, lastPoint:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.SET_ATT);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object;
			oo.playerid = GlobalData.playerid;
			oo.energy = energy;
			oo.lucky = luck;
			oo.dexterity = dex;
			oo.total = lastPoint;
			jo.setObject(ProtocolType.SET_ATT, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}

	}
	
}
