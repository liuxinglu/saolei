package bajie.ui {
	
	import bajie.Test;
	import bajie.constData.ModuleType;
	import bajie.utils.LayMines;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class Classic extends MovieClip {
		
		private var sp:Sprite;
		private static var _classic:Classic;
		
		public static function getInstance():Classic
		{
			if(_classic == null)
			{
				_classic = new Classic();
			}
			return _classic;
		}
		
		public function Classic() {
			// constructor code
			initView();
			initEvent();
			
		}
		
		private function initView():void
		{
			sp = LayMines.layMine("Test", 9, 9);
			for(var i:int = 0; i < sp.numChildren; i++)
			{
				sp.getChildAt(i).addEventListener("OTHER_GRID", openNineGridHandler);
			}
			sp.x = 100;
			sp.y = 100;
			this.addChild(sp);
		}
		
		public function initEvent():void
		{
			//closeBtn.buttonMode = true;
			//closeBtn.addEventListener(MouseEvent.CLICK, closeHandler, false, 0, true);
		}
		
		private function openNineGridHandler(e:Event):void
		{
			var t:Test = e.currentTarget as Test;
			var s:String = t.index;
			var arr:Array = [];
			arr = s.split("_");
			var gridArr:Array = LayMines.getCurNineGrid(int(arr[0]), int(arr[1]), 8, 8);
			for(var i:int = 0; i < gridArr.length; i++)
			{
				Test(sp.getChildByName(gridArr[i])).setCurrentState(2);
			}
		}
		
		private function closeHandler(e:MouseEvent):void
		{
			//removeEvent();
			SetModuleUtils.removeModule(this, ModuleType.COMPOSE);
		}
		
		private function removeEvent():void
		{
			//closeBtn.removeListener(MouseEvent.CLICK, closeHandler);
		}

		
	}
	
}
