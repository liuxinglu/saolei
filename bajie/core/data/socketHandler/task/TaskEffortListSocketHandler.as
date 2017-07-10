package bajie.core.data.socketHandler.task 
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
	public class TaskEffortListSocketHandler extends BaseSocketHandler 
	{
		
		public function TaskEffortListSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.TASK_EFFORT_LIST;
		}
		
		override public function handlePackage():void
		{
			//trace("设置步骤3");
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("获取成就任务列表失败");
			}
			else
			{
				GlobalData.taskItemsInfo.getTaskInfo(o);
			}
			handComplete();
		}
		
		public static function send(playid:uint,index:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.TASK_EFFORT_LIST);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.index = index;
			jo.setObject(ProtocolType.TASK_EFFORT_LIST, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}