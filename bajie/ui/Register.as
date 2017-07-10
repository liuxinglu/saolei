package bajie.ui
{
	import bajie.core.data.GlobalData;
	import bajie.core.data.GlobalAPI;
	import bajie.events.BajieDispatcher;
	import bajie.events.ParamEvent;
	import bajie.utils.SaoLeiTool;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Register extends Sprite
	{
		private static var _registers:Register;
		private static var _register:*;
		public var playerid:int = 0;
		private var fiterArray:Array = ["'", "\"", "_", "-", "$", "%", "^", "[", "]", "<", ">", ";", "\\", "/", "&", "*", "#", "@", "!", "~", ":", ",", ".", "+", "(", ")", "{", "}"];
		
		public static function getInstance():Register
		{
			if(_registers == null)
			{
				_registers = new Register();
			}
			return _registers;
		}
		
		public function Register()
		{
			_register = GlobalAPI.loaderAPI.getObjectByClassPath("register");
			addChild(_register);
			initEvent();
		}
		
		public function setView(o:Object):void
		{
			var i:int = o.sex;
			sexSelected = i;
			if(i == 1)
			{
				manBtnClickHandler(new MouseEvent(MouseEvent.CLICK));
			}
			else
			{
				womanBtnClickHandler(new MouseEvent(MouseEvent.CLICK));
			}
			_register.energyMC.energyText.text = o.energy.toString();
			_register.luckyMC.luckyText.text = o.lucky.toString();
			_register.dexMC.dexText.text = o.dexterity.toString();
		}
		
		private function initEvent():void
		{
			_register.manBtn.buttonMode = true;
			_register.womanBtn.buttonMode = true;
			_register.randomAttBtn.buttonMode = true;
			_register.manBtn.addEventListener(MouseEvent.CLICK, manBtnClickHandler);
			_register.manBtn.addEventListener(MouseEvent.MOUSE_OVER, manBtnMouseOverHandler);
			_register.manBtn.addEventListener(MouseEvent.MOUSE_DOWN, manBtnMouseDownHandler);
			_register.manBtn.addEventListener(MouseEvent.MOUSE_OUT, manBtnMouseOutHandler);
			
			_register.womanBtn.addEventListener(MouseEvent.CLICK, womanBtnClickHandler);
			_register.womanBtn.addEventListener(MouseEvent.MOUSE_OVER, womanBtnMouseOverHandler);
			_register.womanBtn.addEventListener(MouseEvent.MOUSE_DOWN, womanBtnMouseDownHandler);
			_register.womanBtn.addEventListener(MouseEvent.MOUSE_OUT, womanBtnMouseOutHandler);
			
			_register.randomAttBtn.addEventListener(MouseEvent.CLICK, randomAttBtnClickHandler);
			_register.randomAttBtn.addEventListener(MouseEvent.MOUSE_DOWN, randomAttBtnMouseDownHandler);
			_register.randomAttBtn.addEventListener(MouseEvent.MOUSE_OVER, randomAttBtnMouseOverHandler);
			_register.randomAttBtn.addEventListener(MouseEvent.MOUSE_OUT, randomAttBtnMouseOutHandler);
			
			_register.createBtn.addEventListener(MouseEvent.CLICK, createBtnClickHandler);
		}
		
		private var sexSelected:int = 0;
		//男按钮---------------------------------------------------------------
		private function manBtnClickHandler(e:MouseEvent):void
		{
			var mwMCArr:Array = [_register.manMC, _register.womenMC];
			var iconArr:Array = [_register.manBtn, _register.womanBtn];
			sexSelected = 1;
			SaoLeiTool.currentFrames(iconArr, _register.manBtn, 3, 1);
			SaoLeiTool.currentFrames(mwMCArr, _register.manMC, 2, 1);
		}
		
		private function manBtnMouseOverHandler(e:MouseEvent):void
		{
			_register.manBtn.gotoAndStop(2);
		}
		
		private function manBtnMouseDownHandler(e:MouseEvent):void
		{
			_register.manBtn.gotoAndStop(3);
		}
		
		private function manBtnMouseOutHandler(e:MouseEvent):void
		{
			if(sexSelected != 1)
				_register.manBtn.gotoAndStop(1);
		}
		
		//女按钮---------------------------------------------------------------
		private function womanBtnClickHandler(e:MouseEvent):void
		{
			var mwMCArr:Array = [_register.manMC, _register.womenMC];
			var iconArr:Array = [_register.manBtn, _register.womanBtn];
			sexSelected = 2;
			_register.womanBtn.gotoAndStop(3);
			SaoLeiTool.currentFrames(iconArr, _register.womanBtn, 3, 1);
			SaoLeiTool.currentFrames(mwMCArr, _register.womenMC, 2, 1);
		}
		
		private function womanBtnMouseOverHandler(e:MouseEvent):void
		{
			_register.womanBtn.gotoAndStop(2);
		}
		
		private function womanBtnMouseDownHandler(e:MouseEvent):void
		{
			_register.womanBtn.gotoAndStop(3);
		}
		
		private function womanBtnMouseOutHandler(e:MouseEvent):void
		{
			if(sexSelected != 2)
				_register.womanBtn.gotoAndStop(1);
		}
		
		//随机属性按钮---------------------------------------------------------------
		private function randomAttBtnClickHandler(e:MouseEvent):void
		{
			_register.randomAttBtn.gotoAndStop(3);
			if(!BajieDispatcher.getInstance().hasEventListener(BajieDispatcher.GET_ATT_SUCCESS))
				BajieDispatcher.getInstance().addEventListener(BajieDispatcher.GET_ATT_SUCCESS, changeAttHandler);
			GlobalData.playerInfo.randomAtt(playerid);
		}
		
		//更改属性显示值
		private function changeAttHandler(e:ParamEvent):void
		{
			var o:Object = e.Param;
			_register.energyMC.energyText.text = o.energy.toString();
			_register.luckyMC.luckyText.text = o.lucky.toString();
			_register.dexMC.dexText.text = o.dexterity.toString();
			BajieDispatcher.getInstance().removeEventListener(BajieDispatcher.GET_ATT_SUCCESS, changeAttHandler);
		}
		
		private function randomAttBtnMouseOverHandler(e:MouseEvent):void
		{
			_register.randomAttBtn.gotoAndStop(2);
		}
		
		private function randomAttBtnMouseDownHandler(e:MouseEvent):void
		{
			_register.randomAttBtn.gotoAndStop(3);
		}
		
		private function randomAttBtnMouseOutHandler(e:MouseEvent):void
		{
			_register.randomAttBtn.gotoAndStop(1);
		}
		
		//创建按钮---------------------------------------------------------------
		private function createBtnClickHandler(e:MouseEvent):void
		{
			var o:Object = new Object;
			if(_register.nickText.text.length == 0)
			{
				
				o.message= "用户名不能为空";
				GlobalData.alertInfo.pureAlert(o);
				return;
			}
			else
			{
				var s:String = _register.nickText.text;
				for(var i:int = 0; i < s.length; i++)
				{
					for(var j:int = 0; j < fiterArray.length; j++)
					{
						if(fiterArray[j] == s.charAt(i))
						{
							o.message= "昵称不可用";
							GlobalData.alertInfo.pureAlert(o);
							return;
						}
						
					}
				}
				GlobalData.playerInfo.createPlayer(playerid, _register.nickText.text, sexSelected, _register.energyMC.energyText.text, _register.luckyMC.luckyText.text, _register.dexMC.dexText.text);
			}
			
		}
	}
}