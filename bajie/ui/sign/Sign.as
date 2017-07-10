package bajie.ui.sign 
{
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.events.AlertEvent;
	import bajie.events.ParamEvent;
	import bajie.ui.sign.SignDateGird;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Sign extends MovieClip
	{
		
		private var ui:*;
		private var dateGird:SignDateGird;
		private var reSignOn:SignDateSingle;
		
		public function Sign()
		{
			ui = GlobalAPI.loaderAPI.getObjectByClassPath("signPan");;
			addChild(ui);
			initMC();
			GlobalData.signInfo.getSignDate(0,0);
		}
		private function initMC():void {
			dateGird = new SignDateGird();
			ui.addChild(dateGird);
			dateGird.x = 54;
			dateGird.y = 131;
			
			//设置翻页按钮初始不可点
			ui.btn_pageDown.buttonMode = true;
			ui.btn_pageUp.buttonMode = true;
			ui.btn_pageDown.gotoAndStop("non");
			ui.btn_pageUp.gotoAndStop("non");
			ui.btn_pageDown.mouseEnabled = false;
			ui.btn_pageUp.mouseEnabled = false;
			
			ui.btn_signOn.buttonMode = true;
			ui.btn_remedy.buttonMode = true;
			ui.btn_close.buttonMode = true;
			ui.btn_remedy.mouseEnabled = false;
			ui.btn_remedy.gotoAndStop("non");
			
			
			initEvent();
		}
		private function initEvent():void {
			ui.btn_pageDown.addEventListener(MouseEvent.CLICK,nextMonth);
			ui.btn_pageUp.addEventListener(MouseEvent.CLICK, previousMonth);
			ui.btn_signOn.addEventListener(MouseEvent.CLICK, signOn);
			ui.btn_close.addEventListener(MouseEvent.CLICK, removeMC);
			ui.btn_remedy.addEventListener(MouseEvent.CLICK, remedySign);
			
			//监听是否可以补签的按钮的方法
			dateGird.getRemedySignState(updateRemedyBtn);
			
			for (var i:int = 0; i < 4;i++ ) {
				ui["btn_receive"+i].addEventListener(MouseEvent.CLICK, getSignGift);
			}
			
			GlobalData.signInfo.addEventListener(ParamEvent.GET_SIGN_INFO, updateInfo);
		}
		/**
		 * 签到
		 * @param	e
		 */
		private function signOn(e:MouseEvent):void {
			GlobalData.signInfo.signOn();
		}
		/**
		 * 补签
		 * @param	e
		 */
		private function remedySign(e:MouseEvent):void {
			var o:Object = new Object;
			o.message = "补签将花费10金币,是否补签？";
			GlobalData.alertInfo.confirmAlert(o);
			GlobalData.alertInfo.addEventListener(AlertEvent.SUBMIT, alertHandler);
		}
		private function alertHandler(e:AlertEvent):void {
			if (e.type == AlertEvent.SUBMIT) {
				GlobalData.signInfo.reSignOn(reSignOn.year, reSignOn.month+1, reSignOn.day);
			}
			GlobalData.alertInfo.removeEventListener(AlertEvent.SUBMIT, alertHandler);
		}
		/**
		 * 下个月
		 */
		private function nextMonth(e:MouseEvent):void {
			var _year:int = dateGird.curDate.getFullYear();
			var _month:int = dateGird.curDate.getMonth();
			if (_month==11) {
				_month = 0;
				_year++;
			}else {
				_month++;
			}
			//发送向后翻页的方法
			GlobalData.signInfo.getSignDate(_year, _month+1);
		}
		/**
		 * 上个月
		 */
		private function previousMonth(e:MouseEvent):void {
			var _year:int = dateGird.curDate.getFullYear();
			var _month:int = dateGird.curDate.getMonth();
			if (_month==0) {
				_month = 11;
				_year--;
			}else {
				_month--;
			}
			//发送向前翻页的方法
			GlobalData.signInfo.getSignDate(_year, _month+1);
		}
		/**
		 * 获取签到奖励
		 * @param	e
		 */
		private function getSignGift(e:MouseEvent):void {
			var _name:String = e.currentTarget.name;
			var _number:int = int(_name.charAt(_name.length - 1))+1;
			GlobalData.signInfo.getSignItem(dateGird.curDate.getFullYear(),dateGird.curDate.getMonth(),_number);
		}
		
		/**
		 * 更新签到信息
		 * @param	_dateInfo
		 */
		private function updateInfo(e:ParamEvent):void {
			SetModuleUtils.removeLoading();
			
			var _dateInfo:Object = e.Param;
			
			//设置文字显示的月份
			ui.txt_month.text = _dateInfo.year.toString() + "年" + _dateInfo.month.toString() + "月";
			//设置累计签到次数
			ui.txt_number.text = getSignNumber(_dateInfo.signlist);
			dateGird.updateDate(_dateInfo);
			updateGifts(_dateInfo.take);
			
			//设置签到按钮状态
			if (_dateInfo.complete == 0) {
				ui.btn_signOn.mouseEnabled = true;
				ui.btn_signOn.gotoAndStop("_up");
				ui.btn_signOn.enabled = true;
			}else {
				ui.btn_signOn.enabled = false;
				ui.btn_signOn.mouseEnabled = false;
				ui.btn_signOn.gotoAndStop("non");
			}
			
			if ((dateGird.today.getFullYear() == _dateInfo.year)&&(dateGird.today.getMonth() == _dateInfo.month-1)) {
				updateFlipState("up");
			}else {
				updateFlipState("down");
			}
			
		}
		/**
		 * 更新礼包状态
		 * @param	str
		 */
		private function updateGifts(str:String):void {
			var len:int = str.length;
			for (var i:int = 0; i < len;i++ ) {
				if (str.charAt(i) == "1") {
					//未达到条件不可领取
					ui["btn_receive" + i].mouseEnabled = false;
					ui["btn_receive" + i].gotoAndStop("non");
				}else if (str.charAt(i) == "2") {
					//可以领取
					ui["btn_receive" + i].mouseEnabled = true;
					ui["btn_receive" + i].gotoAndStop("_up");
					ui["btn_receive" + i].buttonMode = true;
				}else {
					//已领取
					ui["btn_receive" + i].mouseEnabled = false;
					ui["btn_receive" + i].gotoAndStop("non");
				}
			}
		}
		/**
		 * 更新补签按钮状态
		 * @param	o
		 */
		private function updateRemedyBtn(o:SignDateSingle):void {
			if (o) {
				if (o.enableRemedy) {
					ui.btn_remedy.mouseEnabled = true;
					ui.btn_remedy.gotoAndStop("_up");
					reSignOn = o;
				}else {
					ui.btn_remedy.mouseEnabled = false;
					ui.btn_remedy.gotoAndStop("non");
				}
			}else {
				ui.btn_remedy.mouseEnabled = false;
				ui.btn_remedy.gotoAndStop("non");
			}
			
		}
		/**
		 * 获取累计签到次数
		 * @param	str
		 * @return
		 */
		private function getSignNumber(str:String):int {
			var len:int = str.length;
			var _number:int = 0;
			for (var i:int = 0; i < len;i++ ) {
				if (str.charAt(i) == "1") {
					_number++;
				}
			}
			return _number;
		}
		/**
		 * 设置翻页按钮状态
		 */
		private function updateFlipState(str:String):void {
			if (str == "down") {
				ui.btn_pageDown.mouseEnabled = true;
				ui.btn_pageDown.enabled = true;
				ui.btn_pageDown.gotoAndStop("_up");
				ui.btn_pageUp.mouseEnabled = false;
				ui.btn_pageUp.enabled = false;
				ui.btn_pageUp.gotoAndStop("non");
			}
			if(str == "up"){
				ui.btn_pageDown.mouseEnabled = false;
				ui.btn_pageDown.enabled = false;
				ui.btn_pageDown.gotoAndStop("non");
				ui.btn_pageUp.enabled = true;
				ui.btn_pageUp.mouseEnabled = true;
				ui.btn_pageUp.gotoAndStop("_up");
			}
		}
		private function removeMC(e:MouseEvent):void {
			dateGird.removeMC();
			ui.btn_pageDown.removeEventListener(MouseEvent.CLICK,nextMonth);
			ui.btn_pageUp.removeEventListener(MouseEvent.CLICK, previousMonth);
			ui.btn_signOn.removeEventListener(MouseEvent.CLICK, signOn);
			ui.btn_close.removeEventListener(MouseEvent.CLICK, removeMC);
			ui.btn_remedy.removeEventListener(MouseEvent.CLICK, remedySign);
			
			for (var i:int = 0; i < 4;i++ ) {
				ui["btn_receive"+i].removeEventListener(MouseEvent.CLICK, getSignGift);
			}
			
			GlobalData.signInfo.removeEventListener(ParamEvent.GET_SIGN_INFO, updateInfo);
			SetModuleUtils.removeModule(this, ModuleType.SIGN);
		}
	}

}
