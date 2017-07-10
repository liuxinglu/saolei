package bajie.ui.task 
{
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.events.ParamEvent;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * ...
	 * @author azjune
	 */
	public class Task extends MovieClip 
	{
		private var ui:*;
		private const listNumber:int = 11;
		private const itemNumber:int = 4;
		
		private var taskList:Array = [];
		private var curList:int = 0;
		
		private var curLable:int = 1;
		private var lableState:Boolean = false;
		
		private var curIndex:int = 1;
		private var total:int = 1;
		public function Task() 
		{
			ui = GlobalAPI.loaderAPI.getObjectByClassPath("taskPan");
			addChild(ui);
			initMC();
		}
		private function initMC():void {
			ui.btn_close.buttonMode = true;
			ui.btn_close.addEventListener(MouseEvent.CLICK, removeMC);
			ui.btn_pageDown.addEventListener(MouseEvent.CLICK, flipPage);
			ui.btn_pageUp.addEventListener(MouseEvent.CLICK, flipPage);
			ui.btn_lable1.addEventListener(MouseEvent.CLICK, flipPage);
			ui.btn_lable2.addEventListener(MouseEvent.CLICK, flipPage);
			
			GlobalData.taskItemsInfo.addEventListener(ParamEvent.GET_TASK_LIST, updateTaskList);
			
			for (var i:int = 0; i < listNumber;i++ ) {
				var _list:TaskList = new TaskList();
				ui.addChild(_list);
				taskList.push(_list);
				_list.x = 27;
				_list.y = 79 + 26 * i;
				_list.id = i;
				_list.clickCallBack(listClick);
			}
			GlobalData.taskItemsInfo.getNormalTask(1);
			setLableState(curLable);
		}
		/**
		 * 设置标签页的状态
		 * @param	num
		 */
		private function setLableState(num:int):void {
			if (num == 1) {
				ui.btn_lable1.mouseEnabled = false;
				ui.btn_lable2.mouseEnabled = true;
				ui.lable.gotoAndStop(1);
			}
			if(num == 2) {
				ui.btn_lable1.mouseEnabled = true;
				ui.btn_lable2.mouseEnabled = false;
				ui.lable.gotoAndStop(2);
			}
			lableState = false;
		}
		/**
		 * 任务列表点击事件
		 * @param	e
		 */
		private function listClick(num:int):void {
			taskList[curList].btnState = false;
			taskList[num].btnState = true;
			curList = num;
			updateTaskInfo(curList);
			//发送消息
		}
		/**
		 * 翻页按钮点击事件
		 * @param	e
		 */
		private function flipPage(e:MouseEvent):void {
			
			switch(e.currentTarget.name) {
				case "btn_pageDown":
					if (curIndex < total) {
						if (curLable == 1) {	
							GlobalData.taskItemsInfo.getNormalTask(curIndex+1);
						}else {
							GlobalData.taskItemsInfo.getEffortTask(curIndex+1);
						}
						//SetModuleUtils.addLoading();
					}
				break;
				case "btn_pageUp":
					if (curIndex>1) {
						if (curLable == 1) {	
							GlobalData.taskItemsInfo.getNormalTask(curIndex-1);
						}else {
							GlobalData.taskItemsInfo.getEffortTask(curIndex-1);
						}
						//SetModuleUtils.addLoading();
					}
				break;
				case "btn_lable1":
					GlobalData.taskItemsInfo.getNormalTask(1);
					//SetModuleUtils.addLoading();
					lableState = true;
				break;
				case "btn_lable2":
					GlobalData.taskItemsInfo.getEffortTask(1);
					//SetModuleUtils.addLoading();
					lableState = true;
				break;
				default:break;
			}
		}
		/**
		 * 更新任务列表
		 */
		private function updateTaskList(e:ParamEvent):void {
			SetModuleUtils.removeLoading();
			var o:Object = e.Param;
			curIndex = o.index;
			total = o.total;
			ui.txt_page.text = curIndex + "/" + total;
			var list:Array = o.items as Array;
			for (var i:int = 0; i < listNumber;i++ ) {
				if (list[i]) {
					taskList[i].updateState(list[i]);
				}else {
					taskList[i].updateState(null);
				}
			}
			
			if (lableState) {
				curLable = (curLable == 1)?2:1;
				setLableState(curLable);
			}
			
			updateTaskInfo(0);
			listClick(0);
		}
		/**
		 * 更新任务具体信息
		 */
		private function updateTaskInfo(num:int):void {
			if (!taskList[num]) {
				return;
			}
			try {
				ui.txt_name.text = taskList[num].taskName;
				ui.txt_description.text = taskList[num].description;
				ui.txt_state.text = taskList[num].diff + "/" + taskList[num].sequence;
				
				var strArr:Array = [];
				var str1:String = taskList[num].exp > 0?("经验:" + taskList[num].exp):"";
				if (str1 != "") strArr.push(str1);
				var str2:String = taskList[num].gold > 0?("金币:" + taskList[num].gold):"";
				if (str2 != "") strArr.push(str2);
				var str3:String = taskList[num].silver > 0?("银币:" + taskList[num].silver):"";
				if (str3 != "") strArr.push(str3);
				for (var w:int = 1; w <= 3; w++ ) {
					ui["txt_reward" + w].text = "";
					var len:int = strArr.length;
					if (len > 0) {
						for (var j:int = 0; j < len;j++ ) {
							if (strArr[j] != "") {
								ui["txt_reward" + w].text = strArr[j];
								strArr.splice(j, 1);
								break;
							}
						}
					}
				}
				
				if (taskList[num].state != 2) {
					ui.btn_receive.mouseEnabled = false;
					ui.btn_receive.gotoAndStop("non");
				}else {
					ui.btn_receive.mouseEnabled = true;
					ui.btn_receive.gotoAndStop("_up");
				}
				
				var items:Array = taskList[num].items;
				for (var i:int = 0; i < itemNumber; i++ ) {
					if (items[i]) {
						ui["item_" + (i + 1)].visible = true;
						var _item:TaskItem = new TaskItem();
						ui["item_" + (i + 1)].addChild(_item);
						var _info:BagItemInfo = new BagItemInfo();
						_info.templateId = items[i].openid;
						_info.type = items[i].type;
						_info.style = items[i].style;
						_info.number = items[i].quantity;
						_item.info = _info;
						_item.initBagCell();
					}else {
						ui["item_" + (i + 1)].visible = false;
						if (ui["item_" + (i + 1)].numChildren>0) {
							ui["item_" + (i + 1)].removeChildAt(0);
						}
						
					}
				}
			}catch (err:Error) {
				trace(err);
			}
			
		}
		private function removeMC(e:MouseEvent):void {
			ui.btn_close.removeEventListener(MouseEvent.CLICK, removeMC);
			ui.btn_pageDown.removeEventListener(MouseEvent.CLICK, flipPage);
			ui.btn_pageUp.removeEventListener(MouseEvent.CLICK, flipPage);
			ui.btn_lable1.removeEventListener(MouseEvent.CLICK, flipPage);
			ui.btn_lable2.removeEventListener(MouseEvent.CLICK, flipPage);
			for (var i:int = 0; i < listNumber;i++ ) {
				taskList[i].removeMC();
			}
			for (var j:int = 0; j < itemNumber; j++ ) {
				if (ui["item_" + (j + 1)].numChildren>0) {
					ui["item_" + (j + 1)].getChildAt(0).removeEvent();
				}
			}
			taskList = null;
			GlobalData.taskItemsInfo.removeEventListener(ParamEvent.GET_TASK_LIST, updateTaskList);
			ui = null;
			SetModuleUtils.removeModule(this, ModuleType.TASK);
		}
	}

}