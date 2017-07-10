package bajie.ui.email 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import bajie.core.data.GlobalAPI;
	import bajie.constData.SourceClearType;
	import bajie.utils.LayMines;
	import flash.display.Sprite;
	import bajie.ui.email.EmailItem;
	import bajie.core.data.GlobalData;
	import bajie.core.data.bag.BagItemInfo;
	import flash.events.MouseEvent;
	import bajie.utils.module.SetModuleUtils;
	import bajie.events.AlertEvent;

	/**
	 * ...
	 * @author azjune
	 */
	public class EmailList extends MovieClip 
	{
		private var _mc:*;
		public var item:EmailItem;
		private var curPage:int;
		//private var alert:FlashAlert;
		public function EmailList() 
		{
			_mc = GlobalAPI.loaderAPI.getObjectByClassPath("emailList");
			addChild(_mc);
			drawBagItem();
			initEvent();
		}
		private function initEvent():void {
			_mc.btn_delete.buttonMode = true;
			_mc.btn_getItem.addEventListener(MouseEvent.CLICK, getItemHandler);
			_mc.btn_delete.addEventListener(MouseEvent.CLICK, deleteHandler);
		}
		/**
		 * 获取附件方法
		 * @param	e
		 */
		private function getItemHandler(e:MouseEvent):void {
			GlobalData.emailInfo.sendMailProps(item.info.curPage,item.info.itemId);
		}
		/**
		 * 删除邮件
		 * @param	e
		 */
		private function deleteHandler(e:MouseEvent):void {
			var o:Object = new Object;
			o.message = "是否确认删除邮件？";
			GlobalData.alertInfo.confirmAlert(o);
			GlobalData.alertInfo.addEventListener(AlertEvent.SUBMIT, alertHandler);
			GlobalData.alertInfo.addEventListener(AlertEvent.CANCEL, alertHandler);
		}
		private function alertHandler(e:AlertEvent):void {
			if (e.type == AlertEvent.SUBMIT) {
				GlobalData.emailInfo.removeEmail(item.info.curPage, item.info.itemId);
			}
			GlobalData.alertInfo.removeEventListener(AlertEvent.SUBMIT, alertHandler);
			GlobalData.alertInfo.removeEventListener(AlertEvent.CANCEL, alertHandler);
		}
		/**
		 * 绘制图标格子的方法
		 */
		private function drawBagItem():void
		{
			item = new EmailItem();
			item.gotoAndStop(13);
			_mc.addChild(item);
			item.x = 363;
			item.y = 2;
			GlobalData.emailInfo.itemSp.push(item);
		}
		/**
		 * 初始化邮件数据
		 * @param	o
		 */
		public function initEmailList(o:Object,pageIndex:int):void {
			//idx,name,check title, date,openid,style
			_mc.txtName.text = o.name;
			_mc.txtTheme.text = o.title;
			_mc.txtTime.text = o.date;
			
			
			var info:BagItemInfo = new BagItemInfo;
			info.curPage = pageIndex;
			info.templateId = o.openid;
			info.itemId = o.idx;
			info.type = o.style;
			info.curPage = pageIndex;
			info.getInfoOrNot = false;
			item.info = info;
			
			if (o.check == 1) {
				_mc.btn_getItem.mouseEnabled = false;
				_mc.btn_getItem.buttonMode = false;
				_mc.btn_getItem.gotoAndStop("non");
				item.icon.bitmapData = null;
				return;
			}
			_mc.btn_getItem.mouseEnabled = true;
			_mc.btn_getItem.buttonMode = true;
			_mc.btn_getItem.gotoAndStop("_up");
			
			item.initBagCell();
		}
		public function removeMC():void {
			item.removeEvent();
			_mc.btn_getItem.removeEventListener(MouseEvent.CLICK, getItemHandler);
			_mc.btn_delete.removeEventListener(MouseEvent.CLICK, deleteHandler);
			item = null;
			_mc = null;
			
		}
	}

}