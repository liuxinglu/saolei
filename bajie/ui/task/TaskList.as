package bajie.ui.task 
{
	import bajie.core.data.socketHandler.alert.ConfirmWindowSocketHandler;
	import bajie.core.data.task.TaskTemplateInfo;
	import flash.display.MovieClip;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author azjune
	 */
	public class TaskList extends MovieClip 
	{
		public var mc:*;
		public var id:int;
		private var _openid:int;
		private var _state:int;
		private var _diff:int;
		
		private var _name:String;
		private var _items:Array;
		private var _description:String;
		private var _gold:String;
		private var _silver:String;
		private var _exp:String;
		private var _sequence:String;
		
		private var _fun:Function;
		
		private var _btnEnabled:Boolean = false;
		public function TaskList() 
		{
			mc = GlobalAPI.loaderAPI.getObjectByClassPath("taskList");
			addChild(mc);
			mc.buttonMode = true;
			mc.mouseChildren = false;
			mc.addEventListener(MouseEvent.CLICK, listClick);
		}
		public function clickCallBack(fun:Function):void {
			_fun = fun;
		}
		private function listClick(e:MouseEvent):void {
			_fun(id);
		}
		/**
		 * 更新任务信息
		 * @param	o
		 */
		public function updateState(o:Object = null):void {
			if (o == null) {
				_btnEnabled = false;
				mc.mouseEnabled = false;
				mc.pic_complete.visible = false;
				mc.txt_name.visible = false;
				return;
			}else {
				_btnEnabled = true;
				this.mouseEnabled = true;
				mc.mouseEnabled = true;
				mc.txt_name.visible = true;
			}
			var info:TaskTemplateInfo = GlobalData.taskTempleteList.getTemplate(o.openid);
			mc.txt_name.text = info.name;
			_name = info.name;
			_items = info.itemArr;
			_description = info.description;
			_gold = info.gold;
			_silver = info.silver;
			_exp = info.exp;
			_sequence = info.sequence;
			
			if (o.state == 1) {
				mc.txt_name.textColor = 0x000000;
				mc.pic_complete.visible = false;
			}else if (o.state == 2) {
				mc.txt_name.textColor = 0x000000;
				mc.pic_complete.visible = true;
			}else {
				mc.txt_name.textColor = 0x666666;
				mc.pic_complete.visible = false;
			}
			o.diff = _diff;
			o.state = _state;
		}
		/**
		 * 按钮状态 true为选中不可点 false未选中可以点击
		 */
		public function set btnState(value:Boolean):void {
			if (_btnEnabled == false) {
				mc.gotoAndStop("_up");
				return;
			}
			mc.buttonMode = !value;
			mc.mouseEnabled = !value;
			if (value) {
				mc.gotoAndStop("onclick");
			}else {
				mc.gotoAndStop("_up");
			}
		}
		public function removeMC():void {
			mc.removeEventListener(MouseEvent.CLICK, listClick);
			_fun = null;
			mc = null;
		}
		/**
		 * 任务id
		 */
		public function get openid():int {
			return _openid;
		}
		/**
		 * 任务完成状态
		 */
		public function get state():int {
			return _state;
		}
		/**
		 * 任务完成情况
		 */
		public function get diff():int {
			return _diff;
		}
		/**
		 * 任务名称
		 */
		public function get taskName():String {
			return _name;
		}
		/**
		 * 任务奖励物品
		 */
		public function get items():Array {
			return _items;
		}
		/**
		 * 任务说明
		 */
		public function get description():String {
			return _description;
		}
		/**
		 * 完成状态
		 */
		public function get sequence():String {
			return _sequence;
		}
		/**
		 * 奖励金币
		 */
		public function get gold():String {
			return _gold;
		}
		/**
		 * 奖励银币
		 */
		public function get silver():String {
			return _silver;
		}
		/**
		 * 奖励经验
		 */
		public function get exp():String {
			return _exp;
		}
	}

}