package bajie.ui.alert
{
	import bajie.constData.AlertType;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import bajie.events.AlertEvent;
	import bajie.utils.module.SetModuleUtils;
	import bajie.constData.ModuleType;
	
	public class BajieAlert extends MovieClip
	{
		private static var _alert:BajieAlert;
		private var _curFrame:int = 0; 
		public static function getInstance():BajieAlert
		{
			if(_alert == null)
			{
				_alert = new BajieAlert();
			}
			return _alert;
		}
		
		/**
		 * 设置警告框
		 * @param curFrame 取AlertType中的值
		 * @param showText 警告框中显示的文字
		 * 
		 */		
		public function setAlert(frame:int, showText:String):void
		{
			if(frame == AlertType.CONFIRM_ALERT)
			{
				_alert.gotoAndStop(1);
				_curFrame = frame;
				_alert.alertText.text = showText;
				if(!_alert.submit.hasEventListener(MouseEvent.CLICK))
				{
					_alert.submit.addEventListener(MouseEvent.CLICK, submitHandler);
				}
				if(!_alert.cancel.hasEventListener(MouseEvent.CLICK))
				{
					_alert.cancel.addEventListener(MouseEvent.CLICK, cancelHandler);
				}
			}
			else if(frame == AlertType.INPUT_ALERT)
			{
				_alert.gotoAndStop(2);
				_curFrame = frame;
				_alert.alertText.text = showText;
				if(!_alert.submit.hasEventListener(MouseEvent.CLICK))
				{
					_alert.submit.addEventListener(MouseEvent.CLICK, submitHandler);
				}
				if(!_alert.cancel.hasEventListener(MouseEvent.CLICK))
				{
					_alert.cancel.addEventListener(MouseEvent.CLICK, cancelHandler);
				}
			}
			else if(frame == AlertType.PURE_ALERT)
			{
				_alert.gotoAndStop(4);
				_curFrame = frame;
				_alert.alertText.text = showText;
				if(!_alert.submit2.hasEventListener(MouseEvent.CLICK))
				{
					_alert.submit2.addEventListener(MouseEvent.CLICK, closeHandler);
				}
			}
		}
		
		private function submitHandler(e:MouseEvent):void
		{
			if(_alert.currentFrame == 2)
			{
				this.dispatchEvent(new AlertEvent(AlertEvent.SUBMIT));
			}
			else
			{
				this.dispatchEvent(new AlertEvent(AlertEvent.SUBMIT));
			}
			
			closeHandler(e);
		}
		
		private function cancelHandler(e:MouseEvent):void
		{
			this.dispatchEvent(new AlertEvent(AlertEvent.CANCEL));
			closeHandler(e);
		}
		
		private function closeHandler(e:MouseEvent):void
		{
			this.dispatchEvent(new AlertEvent(AlertEvent.CLOSE));
			SetModuleUtils.removeModule(this, ModuleType.ALERT);
			removeEvent();
		}
		
		
		
		private function removeEvent():void
		{
			if(_alert.currentFrame == AlertType.CONFIRM_ALERT)
			{
				if(_alert.submit.hasEventListener(MouseEvent.CLICK))
				{
					_alert.submit.removeEventListener(MouseEvent.CLICK, submitHandler);
				}
				if(_alert.cancel.hasEventListener(MouseEvent.CLICK))
				{
					_alert.cancel.removeEventListener(MouseEvent.CLICK, cancelHandler);
				}
			}
			else if(_alert.currentFrame == AlertType.INPUT_ALERT)
			{
				if(_alert.submit.hasEventListener(MouseEvent.CLICK))
				{
					_alert.submit.removeEventListener(MouseEvent.CLICK, submitHandler);
				}
				if(_alert.cancel.hasEventListener(MouseEvent.CLICK))
				{
					_alert.cancel.removeEventListener(MouseEvent.CLICK, cancelHandler);
				}
			}
			else if(_alert.currentFrame == AlertType.PURE_ALERT)
			{
				if(_alert.submit2.hasEventListener(MouseEvent.CLICK))
				{
					_alert.submit2.removeEventListener(MouseEvent.CLICK, closeHandler);
				}
			}
		}
		
		public function BajieAlert()
		{
			
		}
		
		
	}
}