package bajie.core.data.socketHandler.skill 
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
	public class UpgradeSkillLevelSocketHandler extends BaseSocketHandler 
	{
		
		public function UpgradeSkillLevelSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.UPGRADE_SKILL_LEVEL;
		}
		
		override public function handlePackage():void
		{
			//trace("设置步骤3");
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("升级技能失败");
			}
			else
			{
				//GlobalData.skillInfo.updateEquipSkill();
			}
			handComplete();
		}
		
		public static function send(playid:uint, ID:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.UPGRADE_SKILL_LEVEL);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.openid = ID;
			jo.setObject(ProtocolType.UPGRADE_SKILL_LEVEL, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}