package bajie.core.data.alert
{
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.events.AlertEvent;
	import bajie.events.ParamEvent;
	import bajie.ui.alert.BajieAlert;
	import bajie.utils.module.SetModuleUtils;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Cubic;
	
	import flash.events.EventDispatcher;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;
	
	import flashx.textLayout.formats.TextAlign;

	public class AlertInfo extends EventDispatcher
	{
		public function AlertInfo()
		{
		}

		/**
		 *falg 用来表示是全局还是个人提示 
		 * @param tf
		 * @param falg null为全局
		 * 
		 */
		private function tweenText(tf:TextField, falg:String = null):void
		{
			tf.x = (760 - tf.width) * 0.5;
			tf.alpha = 0;
			tf.y = 160;
			GlobalAPI.sp.stage.addChild(tf);

			if (falg == null)
			{
				TweenLite.to(tf, 2, {y: 140, alpha: 1, onComplete: onFirst, ease: Cubic.easeOut});
				function onFirst():void
				{
					setTimeout(gogo,1000);
				}

				function gogo():void
				{
					TweenLite.to(tf, 2.5, {y: 100, alpha: 0, onComplete: onSecond, ease: Cubic.easeIn});
				}

				function onSecond():void
				{
					GlobalAPI.sp.stage.removeChild(tf);
				}
			}
			else
			{
				TweenLite.to(tf, 2, {y: 140, alpha: 1, onComplete: gogo1, ease: Cubic.easeOut});
				function gogo1():void
				{
					TweenLite.to(tf, 2.5, {y: 100, alpha: 0, onComplete: onSecond1, ease: Cubic.easeIn});
				}

				function onSecond1():void
				{
					GlobalAPI.sp.stage.removeChild(tf);
				}
			}
		}

		/**
		 *浮动文字 
		 * @param o
		 * 
		 */
		public function topAttantionShow(o:Object):void
		{
			var textField:TextField = new TextField();
			var temStr:String;
			var tf:TextFormat = new TextFormat("",18,0xffffff);
			var gf:GlowFilter = new GlowFilter(0x0000ff,1,6,6,3);

			temStr = o.message;
			tf.align = TextAlign.CENTER;
			textField.defaultTextFormat = tf;
			textField.htmlText = temStr;
			textField.width = textField.textWidth + 20;
			textField.setTextFormat(tf);

			textField.filters = [gf];
			tweenText(textField, "p");
			textField.mouseEnabled = false;

		}

		/**
		 *确认弹框 , 外部监听AlertInfo的AlertEvent.SUBMIT & AlertEvent.CANCEL事件来捕获消息
		 * @param o
		 */
		public function confirmAlert(o:Object):void
		{
			var al:BajieAlert = BajieAlert.getInstance();
			al.setAlert(1, o.message);
			al.addEventListener(AlertEvent.SUBMIT, submitHandler);
			al.addEventListener(AlertEvent.CANCEL, cancelHandler);
			SetModuleUtils.addModule(al, null, false, false, ModuleType.ALERT);
		}

		/**
		 *纯提示弹框 ，外部监听AlertInfo的AlertEvent.SUBMIT事件来捕获消息
		 * @param o
		 * 
		 */
		public function pureAlert(o:Object):void
		{
			var al:BajieAlert = BajieAlert.getInstance();
			al.setAlert(4, o.message);
			al.addEventListener(AlertEvent.CLOSE, closeHandler);
			SetModuleUtils.addModule(al, null, false, false, ModuleType.ALERT);
		}

		/**
		 *输入弹框 ，外部监听AlertInfo的AlertEvent.SUBMIT
		 * @param o
		 * 
		 */
		public function inputAlert(o:Object):void
		{
			var al:BajieAlert = BajieAlert.getInstance();
			al.setAlert(2, o.message.toString());
			al.addEventListener(AlertEvent.SUBMIT, submitHandler);
			SetModuleUtils.addModule(al, null, false,false, ModuleType.ALERT);
		}

		private function submitHandler(e:AlertEvent):void
		{
			var al:BajieAlert = e.currentTarget as BajieAlert;
			al.removeEventListener(AlertEvent.SUBMIT, submitHandler);
			this.dispatchEvent(new AlertEvent(AlertEvent.SUBMIT));
		}

		private function cancelHandler(e:AlertEvent):void
		{
			var al:BajieAlert = e.currentTarget as BajieAlert;
			al.removeEventListener(AlertEvent.CANCEL, cancelHandler);
			this.dispatchEvent(new AlertEvent(AlertEvent.CANCEL));
		}

		private function closeHandler(e:AlertEvent):void
		{
			var al:BajieAlert = e.currentTarget as BajieAlert;
			al.removeEventListener(AlertEvent.CLOSE, closeHandler);
			this.dispatchEvent(new AlertEvent(AlertEvent.CLOSE));
		}
	}
}