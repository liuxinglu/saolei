package bajie.core.data.socketHandler.register
{
	import bajie.constData.CommonConfig;
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	
	/**
	 *创建角色 
	 * @author liuxinglu
	 * 
	 */	
	public class RegisterPlayerSocketHandler extends BaseSocketHandler
	{
		public function RegisterPlayerSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.CREATE_PLAYER;
		}
		
		override public function handlePackage():void
		{
			handComplete();
		}
		//{"protocol":1008,"version":1,"number":"20121210163514","
		//body":"{\"playerid\":1,\"name\":\"阿秋\",\"sex\":2,\"energy\":0,\"lucky\":0,\"dexterity\":0,\"ip\":\"\"}"}
		public static function send(playerid:int, name:String, sex:int, energy:int, lucky:int, dexterity:int, ip:String):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.CREATE_PLAYER);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playerid;
			oo.name = name;
			oo.sex = sex;
			oo.energy = energy;
			oo.lucky = lucky;
			oo.dexterity = dexterity;
			oo.ip = ip;
			jo.setObject(ProtocolType.CREATE_PLAYER, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}