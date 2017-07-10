package bajie.ui.fight
{
	import bajie.core.data.GlobalAPI;
	import bajie.events.GridEvent;
	import bajie.events.ParamEvent;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;

	public class MineGrid extends MovieClip
	{
		private var _grid:*;
		public var index:int = 0;
		private var lrClick:int = 0;//左右击标识
		private var rightClickFlag:int = 0;//同一个格子上右击down的次数
		public var check:int = 0;//0没有被点击，1点过了。

		public function MineGrid(small:int = 0)
		{
			initView(small);
			initEvent();
		}

		private function initView(small:int):void
		{
			if (small == 0)
			{
				_grid = GlobalAPI.loaderAPI.getObjectByClassPath("bigmine");
			}
			else
			{
				_grid = GlobalAPI.loaderAPI.getObjectByClassPath("smallmine");
			}
			_grid.gotoAndStop(1);
			addChild(_grid);

		}

		private function initEvent():void
		{
			_grid.doubleClickEnabled = true;
			_grid.addEventListener(MouseEvent.MOUSE_DOWN, leftMouseDownHandler, false, 1);
			//改变格子状态;
			_grid.addEventListener(MouseEvent.MOUSE_OVER, leftMouseOverHandler);
			//改变格子状态;
			_grid.addEventListener(MouseEvent.MOUSE_UP, leftMouseUpHandler);
			//排雷;
			_grid.addEventListener(MouseEvent.MOUSE_OUT, leftMouseOutHandler);
			_grid.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, rightMouseDownHandler, false, 1);
			//标记，怀疑，取消;
			_grid.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler, false, 2);
			_grid.addEventListener(MouseEvent.CLICK, leftClickHandler, false, 1);
			_grid.addEventListener(MouseEvent.MIDDLE_CLICK,middleClickHandler);
		}

		public function removeAllEvent():void
		{
			removeLeftMouseDownEvent();
			removeLeftMouseOverEvent();
			removeLeftMouseUpEvent();
			removeLeftMouseOutEvent();
			removeRightMouseDownEvent();
			removeLeftClickEvent();
			removeDoubleClickEvent();
			removeMiddleClickEvent();
		}

		public function removeLeftMouseDownEvent():void
		{
			_grid.removeEventListener(MouseEvent.MOUSE_DOWN, leftMouseDownHandler);
		}

		public function removeLeftMouseOverEvent():void
		{
			_grid.removeEventListener(MouseEvent.MOUSE_OVER, leftMouseOverHandler);
		}

		public function removeLeftMouseUpEvent():void
		{
			_grid.removeEventListener(MouseEvent.MOUSE_UP, leftMouseUpHandler);
		}

		public function removeLeftMouseOutEvent():void
		{
			_grid.removeEventListener(MouseEvent.MOUSE_OUT, leftMouseOutHandler);
		}

		public function removeRightMouseDownEvent():void
		{
			_grid.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, rightMouseDownHandler);
		}

		public function removeLeftClickEvent():void
		{
			_grid.removeEventListener(MouseEvent.CLICK, leftClickHandler);
		}

		public function removeMiddleClickEvent():void
		{
			_grid.removeEventListener(MouseEvent.MIDDLE_CLICK,middleClickHandler);
		}

		public function removeRightClickEvent():void
		{
			_grid.removeEventListener(MouseEvent.RIGHT_CLICK, rightClickHandler);
		}

		public function removeDoubleClickEvent():void
		{
			_grid.removeEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
		}


		private function leftMouseDownHandler(e:MouseEvent):void
		{
			lrClick +=  1;
		}

		private function leftMouseOverHandler(e:MouseEvent):void
		{
			if (_grid.currentFrame == 1 || _grid.currentFrame == 2)
			{
				var temp:int = 1;

				temp = _grid.flag.currentFrame;
				_grid.gotoAndStop(2);
				_grid.flag.gotoAndStop(temp);
			}
			e.stopImmediatePropagation();
		}

		//左键点击
		private function leftMouseUpHandler(e:MouseEvent):void
		{
			if (_grid.currentFrame == 3)
			{
				return;
			}
			if (check != 1)
			{
				_grid.gotoAndStop(3);
				_grid.num.gotoAndStop(9);
			}

			this.dispatchEvent(new ParamEvent(GridEvent.LEFT_UP));
		}

		private function leftMouseOutHandler(e:MouseEvent):void
		{
			if (_grid.currentFrame == 1 || _grid.currentFrame == 2)
			{
				var temp:int = 1;
				temp = _grid.flag.currentFrame;

				_grid.gotoAndStop(1);
				_grid.flag.gotoAndStop(temp);
			}
			e.stopImmediatePropagation();
		}

		private function rightMouseDownHandler(e:MouseEvent):void
		{
			lrClick +=  2;
			rightClickFlag++;
			if (rightClickFlag == 1)
			{//插旗

			}
			else if (rightClickFlag == 2)
			{//怀疑
				if (_grid.currentFrame == 3)
				{//已经翻开了
					return;
				}
				setMineState(3);

				this.dispatchEvent(new ParamEvent(GridEvent.RIGHT_DISTRUST));
			}
			else if (rightClickFlag == 3)
			{//取消标记
				if (_grid.currentFrame == 3)
				{
					return;
				}
				else
				{
					if (_grid.currentFrame == 2 || _grid.currentFrame == 1)
					{
						if (_grid.flag.currentFrame == 3)
						{
							setMineState(1);
							rightClickFlag = 0;
							this.dispatchEvent(new ParamEvent(GridEvent.RIGHT_UNDISTRUST));
						}
					}
				}
				return;
			}

			if (_grid.currentFrame == 3)
			{//已经翻开了
			}
			else
			{
				if (_grid.currentFrame == 2)
				{
					if (_grid.flag.currentFrame == 3)
					{
						
					}
					else
					{
						this.dispatchEvent(new ParamEvent(GridEvent.RIGHT_MARK));
					}
				}
			}

		}

		private function rightClickHandler(e:MouseEvent):void
		{
			if (lrClick == 3)
			{//左右击=双击=中键=打开当前格子周围九宫格
				doubleClickHandler(e);
				/*if (_grid.currentFrame == 3)
				{
					if (_grid.num.currentFrame != 9)
					{
						dispatchEvent(new ParamEvent(GridEvent.DOUBLE_CLICK));
						return;
					}
				}*/
			}
			lrClick = 0;
		}

		private function leftClickHandler(e:MouseEvent):void
		{
			if (e.ctrlKey)
			{
				rightClickHandler(e);
				return;
			}
			else if (e.shiftKey)
			{
				rightClickHandler(e);
				return;
			}
			else if (e.altKey)
			{
				doubleClickHandler(e);
				return;
			}

			if (lrClick == 3)
			{//左右击=双击=中键=打开当前格子周围九宫格
				doubleClickHandler(e);
				/*if (_grid.currentFrame == 3)
				{
					if (_grid.num.currentFrame != 9)
					{
						dispatchEvent(new ParamEvent(GridEvent.DOUBLE_CLICK));
						return;
					}
				}*/
			}
			else
			{

			}

			lrClick = 0;
			e.stopImmediatePropagation();
		}

		private function middleClickHandler(e:MouseEvent):void
		{//左右击=双击=中键=打开当前格子周围九宫格
			doubleClickHandler(e);
			/*if (_grid.currentFrame == 3)
			{
				if (_grid.num.currentFrame != 9)
				{
					dispatchEvent(new ParamEvent(GridEvent.DOUBLE_CLICK));
					return;
				}
			}*/
		}

		private function doubleClickHandler(e:MouseEvent):void
		{//左右击=双击=中键=打开当前格子周围九宫格
			e.stopImmediatePropagation();
			if (_grid.currentFrame == 3)
			{
				if (_grid.num.currentFrame != 9)
				{
					dispatchEvent(new ParamEvent(GridEvent.DOUBLE_CLICK));
					return;
				}
				
			}
			
		}

		/**
		设置格子跳转帧
		*/
		public function setGridFrame(i:int):void
		{
			_grid.gotoAndStop(i);
			if (i == 3)
			{
				_grid.hShape.visible = false;
				_grid.vShape.visible = false;
				_grid.num.gotoAndStop(9);
			}
		}

		/**
		设置格子显示雷数
		*/
		public function setMineNum(i:int = 9, ci:int = 0):void
		{
			if (_grid.currentFrame == 3)
			{
				_grid.num.gotoAndStop(i);
				_grid.num.mouseEnabled = true;
				_grid.num.doubleClickEnabled = true;
				if (i == 10)
				{//暴雷
					_grid.num.mine.gotoAndPlay(2);
				}
				else if(i == 11)
				{//叉
					_grid.num.doubleClickEnabled = false;
					setTimeout(function faa():void{
							   _grid.num.gotoAndStop(ci);
							   _grid.num.doubleClickEnabled = true;
							   },300);
				}
				
			}
		}

		/**
		获取当前格子的状态
		*/
		public function getCurGridFrame():int
		{
			return _grid.currentFrame;
		}

		/**
		获取当前格子的现实雷数
		*/
		public function getCurMineNum():int
		{
			return _grid.num.currentFrame;
		}

		public function getCurMineState():int
		{
			if (_grid.flag != null)
			{
				return _grid.flag.currentFrame;
			}
			else
			{
				return 1;
			}
		}/**
		设置雷的状态
		1.空
		2.插旗
		3.怀疑
		4.暴雷
		*/

		public function setMineState(i:int):void
		{
			if (_grid.currentFrame == 1 || _grid.currentFrame == 2)
			{
				_grid.flag.gotoAndStop(i);
			}
		}

		/**
		设置顶部阴影是否显示
		*/
		public function setTopShapeVisible(b:Boolean):void
		{
			if (_grid.currentFrame == 3)
			{
				_grid.hShape.visible = b;
			}
		}

		/**
		设置左边阴影是否显示
		*/
		public function setLeftShapeVisible(b:Boolean):void
		{
			if (_grid.currentFrame == 3)
			{
				_grid.vShape.visible = b;
			}
		}
	}
}