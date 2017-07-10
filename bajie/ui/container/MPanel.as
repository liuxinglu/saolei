package bajie.ui.container 
{
	import bajie.interfaces.layer.IPanel;
	import fl.core.UIComponent;
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import fl.controls.Button;
	import fl.core.InvalidationType;
	import bajie.constData.CommonConfig;

	public class MPanel extends UIComponent implements IPanel
	{
		protected var _minHeight:Number = 80;
		protected var _minWidth:Number = 280;
		protected var _minTitleWidth:Number = 204;
		
		protected var _paddingWidth:Number = 6;
		
		protected var _paddingTop:Number = 2;
		protected var _paddingBottom:Number = 6;
		
		protected var _titleHeight:Number = 34;
		protected var _titleTopOffset:int = 1;
		
		private const _closeBtnYoffset:int = 6;
		private const _closeBtnXoffset:int = 35;
		
		
		protected var _contentWidth:Number;
		protected var _contentHeight:Number;
		protected var _contentX:Number;
		protected var _contentY:Number;
		/**
		 * 
		 */		
		private var _subContainer:Sprite;
		
		protected var _title:DisplayObject;
		private var _dragable:Boolean;
		private var _mode:Number;
		private var _closeable:Boolean;
		
		private var _background:DisplayObject;
		private var _closeBtn:Button;
		private var _dragarea:Sprite;
		private var _setCenter:Boolean;
		protected var _container:Sprite;
		
		private var _hadDraw:Boolean;
		private var _tmpX:Number,_tmpY:Number;
		private var _bgRecordList:Dictionary;
		
		protected var _innerEscHandler:Function;
		
		private static const CLOSE_STYLE:Object = {upSkin:Panel_CloseBtn_upSkin,overSkin:Panel_CloseBtn_overSkin,downSkin:Panel_CloseBtn_downSkin,repeatDelay:500,repeatInterval:35};
		/**
		 * 
		 * @param title
		 * @param dragable
		 * @param mode -1表示非mode
		 * @param closeable
		 * 
		 */		
		public function MPanel(title:DisplayObject = null,dragable:Boolean = true,mode:Number = 0.5,closeable:Boolean = true,toCenter:Boolean = true)
		{
			_title = title;
			_dragable = dragable;
			_mode = mode;
			_closeable = closeable;
			_setCenter = toCenter;
			_tmpX = _tmpY = 0;
			_innerEscHandler = innerEscHandler;
			_bgRecordList = new Dictionary();
			super();
			super.move(5000,5000);
		}
		
		private function initConfigDatas():void
		{
			_contentWidth = _minWidth;
			_contentHeight = _minHeight;
			_contentY = _titleHeight;
			_contentX = _titleWidth;
		}
		
		override protected function configUI():void
		{
			super.configUI();
			initConfigDatas();
			_container = new Sprite();
			_subContainer = new Sprite();
			_subContainer.x = _contentX;
			_subContainer.y = _contentY;
			if(_mode >= 0)
			{
				var sp:Sprite = new Sprite();
				sp.graphics.beginFill(0, _mode);
				sp.graphics.drawRect(-1000, -1000, 4000, 4000);
				sp.graphics.endFill();
				addChild(sp);
			}
			addChild(_container);
			
			if(_dragable)
			{
				if(_dragarea == null)
				{
					_dragarea = new Sprite();
					_dragarea.addEventListener(MouseEvent.MOUSE_DOWN, dragDownHandler);
					_dragarea.addEventListener(MouseEvent.MOUSE_UP, dragUpHandler);
					_container.addChild(_dragarea);
				}
			}
			if(_closeable)
			{
				if(_closeBtn == null)
				{
					_closeBtn = new Button();
					_closeBtn.addEventListener(MouseEvent.CLICK, closeClickHandler);
				}
			}
			_container.addChild(_subContainer);
		}
		
		override protected function draw():void
		{
			if(ifInvalid(InvalidationType.SIZE))
			{
				drawLayout();
			}
			if(isInvalid("center") && _setCenter)
			{
				_hadDraw = true;
				x = (CommonConfig.GAME_WIDTH - _background.width) / 2;
				y = (CommonConfig.GAME_HEIGHT - _background.height) / 2;
			}
			else if(!_hadDraw)
			{
				_hadDraw = true;
				x = _tmpX;
				y = _tmpY;
			}
			super.draw();
		}
		
		override public function move(x:Number, y:Number):void
		{
			if(_hadDraw)
			{
				super.move(x, y);
			}
			else
			{
				_tmpX = x;
				_tmpY = y;
			}
		}
		
		public function setToTop():void
		{
			if(parent)
			{
				parent.setChildIndex(this, parent.numChildren - 1);
			}
		}
		
		override public function set x(value:Number):void
		{
			if(_hadDraw)
			{
				super.x = value;
			}
			else 
			{
				move(value, _tmpY);
			}
		}
		
		override public function set y(value:Number):void
		{
			if(_hadDraw)
			{
				super.y = value;
			}
			else
			{
				move(_tmpX, value);
			}
		}
		
		protected function drawLayout():void
		{
			var bgWidth:Number = _contentWidth + _paddingWidth * 2;
			if(_title)
			{
				_title.x = (bgWidth - _title.width) / 2;
				_title.y = _titleTopOffset;
			}
			if(_closeBtn)
			{
				_closeBtn.move(bgWidth - _closeBtnXoffset,_closeBtnYoffset);
			}
			if(_dragarea)
			{
				_dragarea.graphics.beginFill(0,0);
				_dragarea.graphics.drawRect(0,0,bgWidth,_titleHeight);
				_dragarea.graphics.endFill();
			}
			_contentY = _titleHeight;
			_contentX = _paddingWidth;
			var bgHeight:Number = _contentHeight + _contentY + _paddingBottom + _paddingTop;
			if(_background && _background.parent)_background.parent.removeChild(_background);
			if(_bgRecordList == null)_bgRecordList = new Dictionary();
			if(_bgRecordList[int(bgWidth) + "," + int(bgHeight)] == null)
			{
				_background = createBg(bgWidth,bgHeight) as DisplayObject;
				_bgRecordList[int(bgWidth) + "," + int(bgHeight)] = _background;
			}
			else
			{
				_background = _bgRecordList[int(bgWidth) + "," + int(bgHeight)];
			}
			_container.addChildAt(_background,0);

		}
		
		protected function createBg(bgWidth:Number,bgHeight:Number):IMovieWrapper
		{
			var list:Array = [
					new BackgroundInfo(BackgroundType.BORDER_1,new Rectangle(0,0,bgWidth,bgHeight))
					];
			if(_title)
				list.push(new BackgroundInfo(BackgroundType.DISPLAY,new Rectangle(_title.x,_title.y,_title.width,_title.height),_title));
			return BackgroundUtils.setBackground(list);
		}
		
		override public function get height():Number
		{
			return _background.height;
		}
		override public function get width():Number
		{
			return _background.width;
		}
		
		public function setContentSize(width:Number,height:Number):void
		{
			_contentWidth = width;
			_contentHeight = height;
			invalidate(InvalidationType.SIZE);
		}
		
		public function addContent(content:DisplayObject):void
		{
			if(content.parent == _subContainer)return;
			_subContainer.addChild(content);
		}
		
		public function addContentAt(content:DisplayObject,index:int):void
		{
			if(content.parent == _subContainer)
			{
				_subContainer.setChildIndex(content,index);
			}
			_subContainer.addChildAt(content,index);
		}
		
		protected function closeClickHandler(evt:MouseEvent):void
		{
			dispose();
		}
		
		public function setCenter():void
		{
			_setCenter = true;
			invalidate("center");
		}
		
		private function dragDownHandler(evt:MouseEvent):void
		{
			_container.startDrag(false,new Rectangle(-x,-y,parent.stage.stageWidth - width,parent.stage.stageHeight - height));
		}
		
		private function dragUpHandler(evt:MouseEvent):void
		{
			_container.stopDrag();
		}
		
		public function doEnterHandler():void
		{
		}
		
		public function doEscHandler():void
		{
			if(_innerEscHandler != null)
				_innerEscHandler();
			
		}
		
		public function setEscHandler(handler:Function):void
		{
			_innerEscHandler = handler;
		}
		
		protected function innerEscHandler():void
		{
			dispose();
		}
		
		/**
		 * 方法不同于copyStylesToChild,此方法style的值是显示对象，copyStylesToChild中style的值是string，需再次提取显示对象
		 * @param component
		 * @param style
		 * 
		 */		
		public function setStyleToChild(component:UIComponent,style:Object):void
		{
			for(var i:String in style)
			{
				component.setStyle(i,style[i]);
			}
		}
		
		public function dispose():void
		{
			if(stage)
				stage.focus = stage;
			if(_dragarea)
			{
				_dragarea.removeEventListener(MouseEvent.MOUSE_DOWN,dragDownHandler);
				_dragarea.removeEventListener(MouseEvent.MOUSE_UP,dragUpHandler);
			}
			if(_closeBtn)
			{
				_closeBtn.removeEventListener(MouseEvent.CLICK,closeClickHandler);
				if(_closeBtn.parent)_closeBtn.parent.removeChild(_closeBtn);
			}
			if(parent)parent.removeChild(this);
			for each(var i:DisplayObject in _bgRecordList)
			{
				if(i is IMovieWrapper)
				{
					IMovieWrapper(i).dispose();
				}
			}
			_bgRecordList = null;
			_background = null;
			dispatchEvent(new Event(Event.CLOSE));
			try
			{
				delete StyleManager.getInstance().classToInstancesDict[StyleManager.getClassDef(this)][this];
			}
			catch(e:Error){trace(e);}
		}

	}
	
}
