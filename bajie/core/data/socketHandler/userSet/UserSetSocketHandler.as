package  bajie.core.data.socketHandler.userSet 
{
	import bajie.constData.CommonConfig;
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	public class UserSetSocketHandler extends BaseSocketHandler{

		private static var _o:Object = new Object;
		public function UserSetSocketHandler(handlerData:Object=null) {
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.MODIFY_USER_SETTING;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("修改用户信息失败");
			}
			else
			{
				GlobalData.userSetInfo.completeUserSet(_o);
			}
			handComplete();
		}
		public static function send(playid:uint,music:int,sound:int,invite:int,guide:int,prompt:int,whisper:int,friends:int,fashion:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.MODIFY_USER_SETTING);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.music = music;
			oo.sound = sound;
			oo.invite = invite;
			oo.guide = guide;
			oo.prompt = prompt;
			oo.whisper = whisper;
			oo.friends = friends;
			oo.fashion = fashion;
			//oo.rapid = rapid;
			//oo.autoprops = autoprops;
			_o = oo;
			jo.setObject(ProtocolType.MODIFY_USER_SETTING, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
	
}
