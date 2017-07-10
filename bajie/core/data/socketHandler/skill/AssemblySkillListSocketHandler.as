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
	public class AssemblySkillListSocketHandler extends BaseSocketHandler 
	{
		
		public function AssemblySkillListSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.ASSEMBLY_SKILL_LIST;
		}
		
		override public function handlePackage():void
		{
			//trace("设置步骤3");
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("获取已经装备的技能失败");
			}
			else
			{
				GlobalData.skillInfo.updateEquipSkill(o);
			}
			handComplete();
		}
		
		public static function send(playid:uint):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.ASSEMBLY_SKILL_LIST);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			jo.setObject(ProtocolType.ASSEMBLY_SKILL_LIST, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}