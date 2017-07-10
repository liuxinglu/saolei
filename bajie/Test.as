package  bajie{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class Test extends MovieClip 
	{
		
		public var index:String = "";//格子索引
		private var lrClick:int = 0;//左右击标识
		private var rightClickFlag:int = 0;//同一个格子上右击down的次数
		
		public function Test() 
		{
			// constructor code
			this.gotoAndStop(13);
			this.doubleClickEnabled = true;
			this.addEventListener(MouseEvent.MOUSE_DOWN, leftMouseDownHandler);
			this.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, rightMouseDownHandler);
			this.addEventListener(MouseEvent.RIGHT_CLICK, rightClickHandler);
			this.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
			this.addEventListener(MouseEvent.CLICK, leftClickHandler);
			this.addEventListener(MouseEvent.MIDDLE_CLICK,middleClickHandler);
		}
		
		public function removeAllEvent():void
		{
			removeLeftMouseDownEvent();
			removeRightMouseDownEvent();
			removeLeftClickEvent();
			removeRightClickEvent();
			removeDoubleClickEvent();
			removeMiddleClickEvent();
		}
		
		public function removeLeftMouseDownEvent():void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN, leftMouseDownHandler);
		}
		
		public function removeRightMouseDownEvent():void
		{
			this.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, rightMouseDownHandler);
		}
		
		public function removeLeftClickEvent():void
		{
			this.removeEventListener(MouseEvent.CLICK, leftClickHandler);
		}
		
		public function removeMiddleClickEvent():void
		{
			this.removeEventListener(MouseEvent.MIDDLE_CLICK,middleClickHandler);
		}
		
		public function removeRightClickEvent():void
		{
			this.removeEventListener(MouseEvent.RIGHT_CLICK, rightClickHandler);
		}
		
		public function removeDoubleClickEvent():void
		{
			this.removeEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
		}
		
		private function keyUpHandler(e:KeyboardEvent):void
		{
			if(e.keyCode == 32)
			{
				leftClickHandler(new MouseEvent("key"));
			}
		}
		
		private function leftMouseDownHandler(e:MouseEvent):void
		{
			lrClick += 1;
		}

		private function rightMouseDownHandler(e:MouseEvent):void
		{
			lrClick += 2;
			rightClickFlag++;
			if(rightClickFlag == 1)
			{
				this.gotoAndStop(4);
			}
			else if(rightClickFlag == 2)
			{
				this.gotoAndStop(5);
			}
			else if(rightClickFlag == 3)
			{
				this.gotoAndStop(1);
				rightClickFlag = 0;
			}
			
		}
		
		private function rightClickHandler(e:MouseEvent):void
		{
			if(lrClick == 3)
			{//左右击=双击=中键=打开当前格子周围九宫格
				this.gotoAndStop(3);
				dispatchEvent(new Event("OTHER_GRID"));
			}
			lrClick = 0;
		}

		private function leftClickHandler(e:MouseEvent):void
		{
			if(e.ctrlKey)
			{
				rightClickHandler(e);
				return;
			}
			else if(e.shiftKey)
			{
				rightClickHandler(e);
				return;
			}
			else if(e.altKey)
			{
				doubleClickHandler(e);
				return;
			}
			
			if(lrClick == 3)
			{//左右击=双击=中键=打开当前格子周围九宫格
				this.gotoAndStop(3);
				dispatchEvent(new Event("OTHER_GRID"));
			}
			else
			{
				this.gotoAndStop(6);
			}
			
			lrClick = 0;
			e.stopImmediatePropagation();
		}

		private function middleClickHandler(e:MouseEvent):void
		{//左右击=双击=中键=打开当前格子周围九宫格
			this.gotoAndStop(3);
			dispatchEvent(new Event("OTHER_GRID"));
		}

		private function doubleClickHandler(e:MouseEvent):void
		{//左右击=双击=中键=打开当前格子周围九宫格
			e.stopImmediatePropagation();
			this.gotoAndStop(3);
			dispatchEvent(new Event("OTHER_GRID"));
		}
		
		public function setCurrentState(i:int):void
		{
			this.gotoAndStop(i);
		}
	}
	
}
