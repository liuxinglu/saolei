package bajie.ui.base.item
{
	import bajie.core.data.bag.BagItemInfo;
	import bajie.core.data.drag.GlobalDragItemInfo;
	import bajie.events.ItemEvent;
	import bajie.interfaces.item.IClick;
	import bajie.interfaces.item.IMouseDown;
	import bajie.interfaces.item.IMouseOut;
	import bajie.interfaces.item.IMouseOver;
	import bajie.manager.drag.GlobalDragManager;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	所有的格子都具有点击，mouseDown， MouseOver, MouseOut操作属性 格子采用策略模式
	*/
	public class BaseItem extends MovieClip
	{
		public var itemType:int;//格子类型
		public var itemBaseType:int;//格子基本类型
		public var index:int = 0;//格子索引
		public var itemClick:IClick;//点击行为
		public var itemOver:IMouseOver;//mouseOver行为
		public var itemOut:IMouseOut;//mouseOut行为
		public var itemDown:IMouseDown;//mouseDown行为
		private var _dragEnable:Boolean;
		
		public function get dragEnable():Boolean
		{
			return _dragEnable;
		}

		public function set dragEnable(value:Boolean):void
		{
			_dragEnable = value;
		}
		
		protected var _info:BagItemInfo;
		
		public function get info():BagItemInfo
		{
			return _info;
		}

		public function set info(value:BagItemInfo):void
		{
			_info = value;
		}

//是否可以拖动
		
		public function BaseItem()
		{
			initEvent();
		}
		
		private function initEvent():void
		{
			this.addEventListener(MouseEvent.CLICK, itemClickHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_DOWN, itemMouseDownHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OVER, itemMouseOverHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OUT, itemMouseOutHandler, false, 0, true);
		}
		
		public function removeEvent():void
		{
			this.removeEventListener(MouseEvent.CLICK, itemClickHandler);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, itemMouseDownHandler);
			this.removeEventListener(MouseEvent.MOUSE_OVER, itemMouseOverHandler);
			this.removeEventListener(MouseEvent.MOUSE_OUT, itemMouseOutHandler);
		}
		
		public function itemClickHandler(e:MouseEvent):void
		{
			itemClick.itemClick(new ItemEvent(ItemEvent.ITEM_CLICK, e));
		}
		
		public function itemMouseDownHandler(e:MouseEvent):void
		{
			itemDown.itemMouseDown(new ItemEvent(ItemEvent.ITEM_DOWN, e));
			onMouseDowns(e);
			if(!dragEnable)
				return;
			GlobalDragManager.getInstance().startDragItem(e, this);
		}
		
		public function onMouseDowns(e:MouseEvent):void
		{
			
		}
		
		public function itemMouseOverHandler(e:MouseEvent):void
		{
			itemOver.itemMouseOver(new ItemEvent(ItemEvent.ITEM_OVER, e));
		}
		
		public function itemMouseOutHandler(e:MouseEvent):void
		{
			itemOut.itemMouseOut(new ItemEvent(ItemEvent.ITEM_OUT, e));
		}
		
		//子类根据需要实现拖拽效果---------------------------------------------------------------------------------------
		/**
		 *开始拖拽并移动了一段距离 
		 * @param globalInfo
		 */		
		public function startDragMove(globalInfo:GlobalDragItemInfo):void
		{
			
		}
		/**
		 *结束拖拽物品 
		 * @param globalInfo
		 */		
		public function endDragMove(globalInfo:GlobalDragItemInfo):void
		{
			
		}
		/**
		 *拖拽到不接受拖拽的物品上时 
		 */		
		public function dragOut(globalInfo:GlobalDragItemInfo):void
		{
			
		}
		/**
		 *拖拽到某一对象上时，源对象的响应 
		 * @param globalInfo
		 * 
		 */		
		public function dragToGrid(globalInfo:GlobalDragItemInfo):void
		{
			
		}
		/**
		 *接受拖拽操作 
		 * @param globalInfo
		 * 
		 */		
		public function acceptDrag(globalInfo:GlobalDragItemInfo):void
		{
			
		}
		/**
		 *拖拽到舞台背景上时的处理 
		 * @param globalInfo
		 * 
		 */		
		public function dragToScence(globalInfo:GlobalDragItemInfo):void
		{
			
		}
		public function dragSprite():Sprite
		{
			return null;
		}
	}
}