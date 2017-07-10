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
	public class TaskReceiveSocketHandler extends BaseSocketHandler 
	{
		
		public function TaskReceiveSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.TASK_RECEIVE_PRIZE;
		}
		
		override public function handlePackage():void
		{
			//trace("设置步骤3");
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("任务领取奖励失败");
			}
			else
			{
				
			}
			handComplete();
		}
		
		public static function send(playid:uint,openid:int,index:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.TASK_RECEIVE_PRIZE);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.openid = openid;
			oo.index = index;
			jo.setObject(ProtocolType.TASK_RECEIVE_PRIZE, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}