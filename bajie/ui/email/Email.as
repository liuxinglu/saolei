package bajie.ui.email 
{
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.events.ParamEvent;
	import bajie.utils.LayMines;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * ...
	 * @author azjune
	 */
	public class Email extends MovieClip 
	{
		
		private var pageIndex:int = 1;
		private var _total:int = 1;
		private var _type:int = 1;
		
		private var ui:*;
		private var emailNum:int = 5;
		private var emailList:Array = new Array();
		public function Email() 
		{
			ui = GlobalAPI.loaderAPI.getObjectByClassPath("emailPan");
			addChild(ui);
			initEvent();
			initMC();
			GlobalData.emailInfo.getEmailList(pageIndex, _type);
			
		}
		private function initMC():void {
			for (var i:int = 0; i < emailNum; i++ ) {
				var email:EmailList = new EmailList();
				email.visible = false;
				ui.addChild(email);
				emailList.push(email);
				email.item.emailListIndex = i;
				email.x = 31;
				email.y = 36+i*72;
			}
		}
		public function initEvent():void {
			ui.btn_close.buttonMode = true;
			GlobalData.emailInfo.addEventListener(ParamEvent.GET_MAIL_LIST, updateEmailList);
			ui.btn_close.addEventListener(MouseEvent.CLICK, removeMC);
			ui.btn_pageDown.addEventListener(MouseEvent.CLICK, flipPage);
			ui.btn_pageUp.addEventListener(MouseEvent.CLICK, flipPage);
			//this.addEventListener(Event.REMOVED, removeMC);
		}
		/*
		 * 翻页方法
		 */ 
		private function flipPage(e:MouseEvent):void {
			var _tmpIndex:int = pageIndex;
			if(_total>1){
				switch(e.currentTarget.name) {
					case "btn_pageDown":
						_tmpIndex = pageIndex < _total?pageIndex + 1:pageIndex;
					break;
					case "btn_pageUp":
						_tmpIndex = pageIndex > 1?pageIndex - 1:pageIndex;
					break;
					default:break;
				}
			}
			GlobalData.emailInfo.getEmailList(_tmpIndex, _type);
		}
		/*
		 * 更新邮件列表
		 */ 
		private function updateEmailList(e:ParamEvent):void {
			SetModuleUtils.removeLoading();
			var o:Object = e.Param;
			pageIndex = o.index;
			_total = o.total;
			ui.txt_page.text = pageIndex + "/" + _total;
			var list:Array = (o.items) as Array;
			for (var i:int = 0; i < emailNum; i++ ) {
				if (list[i]) {
					emailList[i].visible = true;
					emailList[i].initEmailList(list[i],pageIndex);
				}else {
					emailList[i].visible = false;
				}
			}
			
			
		}
		private function removeMC(e:Event = null):void {
			GlobalData.emailInfo.removeEventListener(ParamEvent.GET_MAIL_LIST, updateEmailList);
			this.removeEventListener(Event.REMOVED, removeMC);
			ui.btn_pageDown.removeEventListener(MouseEvent.CLICK, flipPage);
			ui.btn_pageUp.removeEventListener(MouseEvent.CLICK, flipPage);
			ui.btn_close.removeEventListener(MouseEvent.CLICK, removeMC);
			for (var i:int = 0; i < emailNum; i++ ) {
				emailList[i].removeMC();
			}
			emailList = null;
			ui = null;
			
			SetModuleUtils.removeModule(this, ModuleType.MAIL);
		}
		
	}

}