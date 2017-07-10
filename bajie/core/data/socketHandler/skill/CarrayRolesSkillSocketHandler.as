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
	public class CarrayRolesSkillSocketHandler extends BaseSocketHandler 
	{
		
		public function CarrayRolesSkillSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.CARRAY_ROLES_SKILL;
		}
		
		override public function handlePackage():void
		{
			//trace("设置步骤3");
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("装配技能失败");
			}
			else
			{
				//GlobalData.skillInfo.updateEquipSkill(o);
			}
			handComplete();
		}
		
		public static function send(playid:uint,bigidx:Number):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.CARRAY_ROLES_SKILL);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.bigidx = bigidx;
			jo.setObject(ProtocolType.CARRAY_ROLES_SKILL, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}