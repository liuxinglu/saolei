package bajie.ui 
{
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.events.ParamEvent;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * 游戏设置面板ui
	 * @author azjune
	 */
	public class UserSetPanel extends MovieClip
	{
		private const setNumber:int = 8;
		/**
		 * 设置的数据 0背景音乐1游戏音效2接受邀请3引导功能4上线提示5屏蔽私聊6允许加为好友7隐藏时装
		 */
		private var valueArr:Array = [0, 0, 0, 0, 0, 0, 0, 0];
		private var btnArr:Array = [];
		
		private var ui:*;
		public function UserSetPanel() 
		{
			ui = GlobalAPI.loaderAPI.getObjectByClassPath("userSetPan");
			addChild(ui);
			GlobalData.userSetInfo.enterUserSetInfo();
			initEvent();
			
			ui.btn_submit.btnTxt.mouseEnabled = false;
			ui.btn_submit.buttonMode = true;
			ui.btn_submit.btnTxt.gotoAndStop(1);
			ui.btn_cancel.btnTxt.mouseEnabled = false;
			ui.btn_cancel.buttonMode = true;
			ui.btn_cancel.btnTxt.gotoAndStop(2);
		}
		private function updateState(e:ParamEvent):void {
			SetModuleUtils.removeLoading();
			var o:Object = e.Param;
			valueArr[0] = o.music;
			valueArr[1] = o.sound;
			valueArr[2] = o.invite;
			valueArr[3] = o.guide;
			valueArr[4] = o.prompt;
			valueArr[5] = o.whisper;
			valueArr[6] = o.friends;
			valueArr[7] = o.fashion;
			
			for (var i:int = 0; i < setNumber; i++) {
				if (valueArr[i] == 0) {
					btnArr[i].right.visible = false;
				}else {
					btnArr[i].right.visible = true;
				}
				
			}
		}
		
		private function initEvent():void {
			GlobalData.userSetInfo.addEventListener(ParamEvent.GET_USER_SET, updateState);
			
			for (var i:int = 0; i < setNumber; i++ ) {
				btnArr.push(ui["checkBox_" + (i + 1)]);
				btnArr[i].addEventListener(MouseEvent.CLICK, setInfo);
			}
			ui.btn_close.addEventListener(MouseEvent.CLICK, removeMC);
			ui.btn_cancel.addEventListener(MouseEvent.CLICK, removeMC);
			ui.btn_submit.addEventListener(MouseEvent.CLICK, submitHandler);
		}
		private function setInfo(e:MouseEvent):void {
			var curIndex:int = btnArr.indexOf(e.currentTarget);
			if (valueArr[curIndex] == 0) {
				e.currentTarget.right.visible = true;
				valueArr[curIndex] = 1;
			}else {
				e.currentTarget.right.visible = false;
				valueArr[curIndex] = 0;
			}
			
		}

		private function submitHandler(e:MouseEvent):void {
			GlobalData.userSetInfo.sendUserSet(valueArr[0], valueArr[1], valueArr[2], valueArr[3], valueArr[4], valueArr[5], valueArr[6],valueArr[7]);
			removeMC();
		}
		private function removeMC(e:MouseEvent = null):void
		{
			GlobalData.userSetInfo.removeEventListener(ParamEvent.GET_USER_SET, updateState);
			for (var i:int = 0; i < setNumber;i++ ) {
				btnArr[i].removeEventListener(MouseEvent.CLICK, setInfo);
			}
			ui.btn_close.removeEventListener(MouseEvent.CLICK, removeMC);
			ui.btn_cancel.removeEventListener(MouseEvent.CLICK, removeMC);
			ui.btn_submit.removeEventListener(MouseEvent.CLICK, submitHandler);
			
			ui = null;
			SetModuleUtils.removeModule(this, ModuleType.SETTING);
		}
	}

}