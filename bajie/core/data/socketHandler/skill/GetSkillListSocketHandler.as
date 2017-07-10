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
	public class GetSkillListSocketHandler extends BaseSocketHandler
	{
		
		public function GetSkillListSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.GET_SKILL_LIST;
		}
		
		override public function handlePackage():void
		{
			//trace("设置步骤3");
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("获取技能列表失败");
			}
			else
			{
				GlobalData.skillInfo.showSkillList(o);
			}
			handComplete();
		}
		
		public static function send(playid:uint,index:int,idx = 0,fromindex = 0,toindex = 0):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GET_SKILL_LIST);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.index = index;
			oo.idx = idx;
			oo.fromindex = fromindex;
			oo.toindex = toindex;
			jo.setObject(ProtocolType.GET_SKILL_LIST, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}