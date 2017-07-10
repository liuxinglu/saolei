package bajie.core.data.task 
{
	import bajie.core.data.socketHandler.task.*;
	import bajie.core.data.GlobalData;
	import bajie.events.ParamEvent;
	import flash.events.EventDispatcher;
	/**
	任务数据管理类
	*/
	public class TaskItemInfo extends EventDispatcher{

		public function TaskItemInfo() {
			// constructor code
		}
		/**
		 * 显示任务列表信息
		 */
		public function getTaskInfo(o:Object):void {
			this.dispatchEvent(new ParamEvent(ParamEvent.GET_TASK_LIST, o));
		}
		/**
		 * 获取普通任务列表
		 * @param	index
		 */
		public function getNormalTask(index:int):void {
			TaskDailyListSocketHandler.send(GlobalData.playerid, index);
		}
		/**
		 * 获取成就任务列表
		 * @param	index
		 */
		public function getEffortTask(index:int):void {
			TaskEffortListSocketHandler.send(GlobalData.playerid,index);
		}
		/**
		 * 领取任务奖励
		 * @param	openid
		 */
		public function getTaskAward(openid:int,index:int):void {
			TaskReceiveSocketHandler.send(GlobalData.playerid, openid, index);
		}
	}
	
}
