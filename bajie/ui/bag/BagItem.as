package bajie.ui.bag {
	
	import bajie.action.item.bag.BagItemClick;
	import bajie.action.item.bag.BagItemDown;
	import bajie.action.item.bag.BagItemOut;
	import bajie.action.item.bag.BagItemOver;
	import bajie.constData.ModuleType;
	import bajie.constData.SourceClearType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.bag.BagInfo;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.core.data.drag.GlobalDragItemInfo;
	import bajie.events.BajieDispatcher;
	import bajie.events.ItemEvent;
	import bajie.events.ParamEvent;
	import bajie.manager.drag.GridItemInfo;
	import bajie.ui.att.AttItem;
	import bajie.ui.base.item.BaseItem;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.display.DisplayObject;
	import bajie.constData.GoodsType;
	
	public class BagItem extends BaseItem
	{
		override public function set info(value:BagItemInfo):void
		{
			_info = value;
			itemClick = new BagItemClick(info);
			itemOver = new BagItemOver(info);
			itemDown = new BagItemDown(info);
			itemOut = new BagItemOut(info);
		}

		private var _isLoad:Boolean;
		private var _icon:Bitmap;
		private var _boundSprite:Sprite;
		private var _iconPath:String;
		private var _gridBaseType:int;
		private var _gridMc:MovieClip;
		private var _g_gridItemInfo:GridItemInfo;
		private var _g_itemInfo:BagItemInfo;
		
		public function set boundSprite(value:Sprite):void
		{
			_boundSprite = value;
		}
		
		public function get boundSprite():Sprite
		{
			return _boundSprite;
		}
		
		public function set icon(value:Bitmap):void
		{
			_icon = value;
		}
		
		public function get icon():Bitmap
		{
			return _icon;
		}
		
		public function BagItem() {
			// constructor code
			
			this.doubleClickEnabled = true;
			
			initEvent();
		}
		
		
		/**
		填图
		*/
		public function initBagCell():void
		{
			if(info == null)
				return;
				
			_iconPath = GlobalAPI.pathManager.getDisplayPicPath(info.template.type, info.template.icon);
			
			GlobalAPI.loaderAPI.getPicFile(_iconPath, function (e:BitmapData):void
			{
				boundSprite = new Sprite;
				boundSprite.doubleClickEnabled = true;
				boundSprite.x = 1;
				boundSprite.y = 1
				addChild(boundSprite);
				_icon = new Bitmap(e);
				boundSprite.addChild(_icon);
			}, SourceClearType.NEVER);
		}
		
		public function removeBagCell():void
		{
			if(boundSprite != null)
			while(boundSprite.numChildren> 0)
			{
				boundSprite.removeChildAt(0);
			}
			icon = null;
			boundSprite = null;
			info = null;
			graphics.clear();
		}
		
		public function get cellIcon():Bitmap
		{
			return _icon;
		}
		
		private function initEvent():void
		{
			itemClick = new BagItemClick(info);
			itemOver = new BagItemOver(info);
			itemDown = new BagItemDown(info);
			itemOut = new BagItemOut(info);
			
			if(this.hasEventListener(MouseEvent.MOUSE_UP))
				this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			
			if(this.hasEventListener(MouseEvent.DOUBLE_CLICK))
				this.removeEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
			this.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
		}
		
		
		
		private function doubleClickHandler(e:MouseEvent):void
		{
			
		}
		
		private function mouseUpHandler(e:MouseEvent):void
		{
			this.removeEvent();
		}
		
		/**
		获取物品拖拽方法
		*/
		override public function dragSprite():Sprite
		{
			var newSprite:Sprite = null;
			if(cellIcon != null)
			{
				newSprite = new Sprite();
				var icons:Bitmap = new Bitmap(cellIcon.bitmapData.clone());
				newSprite.addChild(icons);
			}
			return newSprite;
		}
		
		///**
//		鼠标按下时的处理函数
//		*/
//		public function onMouseDown(e:MouseEvent):void
//		{
//			if(cellIcon == null)
//			{
//				return;
//			}
//			BajieDispatcher.getInstance().dispatchEvent(new ItemEvent(ItemEvent.ITEM_INFO, info));
//		}
		
		private var myFilter:Array = [];
		public function set gridLock(lock:Boolean):void
		{
			//this._info.lock = lock;
//			if(this.info.lock == true && cellIcon != null)
//			{
//				var filter:ColorMatrixFilter = new ColorMatrixFilter([0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0, 0, 0, 1, 0]);
//				myFilter.push(filter);
//				this.filters = myFilter;
//			}
//			else if(this.info.lock && cellIcon != null)
//			{
//				this.filters = [];
//			}
		}
		
		public function get gridLock():Boolean
		{
			return this.info.lock;
		}
		
		/**
		拖动该物品
		*/
		override public function startDragMove(globalInfo:GlobalDragItemInfo):void
		{
			BagItem(globalInfo.dragSrcObj).gridLock = true;
		}
		
		override public function endDragMove(globalInfo:GlobalDragItemInfo):void
		{
			BagItem(globalInfo.dragSrcObj).gridLock = false;
		}
		
		/**
		判断是否允许拖拽
		*/
		override public function get dragEnable():Boolean
		{
			//if(info.lock)
//			{
//				return false;
//			}
//			if(_isAcceptLock)
//			{
//				return false;
//			}
//			else
			 return true;
		}
		
		override public function set dragEnable(enable:Boolean):void
		{
			info.lock = enable;
		}
		
		/**
		接收拖拽操作
		*/
		override public function acceptDrag(globalInfo:GlobalDragItemInfo):void
		{
			var srcObj:BaseItem = BaseItem(globalInfo.dragSrcObj);
			var tagObj:BaseItem = BaseItem(globalInfo.dragTagObj);
			var srcBaseType:int = srcObj.itemType;
			var tagBaseType:int = tagObj.itemType;
			var srcItemInfo:BagItemInfo;
			var tagItemInfo:BagItemInfo;
			
			if(srcBaseType == ModuleType.BAG && tagBaseType == ModuleType.BAG)
			{//交换位置--------
				srcItemInfo = BagItem(srcObj).info;
				tagItemInfo = BagItem(tagObj).info;
				if(srcItemInfo != null)
				{
					if(srcItemInfo.type == GoodsType.EQUIP || srcItemInfo.type == GoodsType.WEAPON)
					{//装备
						GlobalData.bagInfo.changeEquipSite(srcObj.index, tagObj.index);
					}
					else if(srcItemInfo.type == GoodsType.PROP || srcItemInfo.type == GoodsType.GEMSTONE)
					{//道具
						GlobalData.bagInfo.changePropSite(srcObj.index, tagObj.index);
					}
					else if(srcItemInfo.type == GoodsType.FLASHION)
					{//时装
						GlobalData.bagInfo.changeFashionSite(srcObj.index, tagObj.index);
					}
				}
				
				
			}
			else if((srcBaseType == ModuleType.ROLE || srcBaseType == ModuleType.FASHION) && tagBaseType == ModuleType.BAG)
			{//卸下--------
				srcItemInfo = AttItem(srcObj).info;
				tagItemInfo = BagItem(tagObj).info;
				if(srcItemInfo != null)
				{
					if(srcItemInfo.type == GoodsType.EQUIP || srcItemInfo.type == GoodsType.WEAPON)
					{//装备
						GlobalData.bagInfo.unsnachEquip(srcItemInfo.itemId, tagObj.index);
					}
					else if(srcItemInfo.type == GoodsType.FLASHION)
					{//时装
						GlobalData.bagInfo.unsnachFashion(srcItemInfo.itemId, tagObj.index);
					}
				}
				
				
			}
			else if(srcBaseType == ModuleType.PROP && tagBaseType == ModuleType.BAG)
			{//卸下--------
				srcItemInfo = AttItem(srcObj).info;
				if(srcItemInfo != null)
				{
					if(srcItemInfo.type == GoodsType.PROP)
					{//道具
						GlobalData.bagInfo.unsnachProp(srcItemInfo.itemId, tagObj.index);
					}
				}
				
			}
		}
		
		/**
		作为源对象时的处理
		*/
		override public function dragToGrid(globalInfo:GlobalDragItemInfo):void
		{
			trace("a");
		}
		
		/**
		拖拽到舞台
		*/
		override public function dragToScence(globalInfo:GlobalDragItemInfo):void
		{
			trace("b");
		}
		
		
		
		private var _isAcceptLock:Boolean;
		public function set canAcceptLock(islock:Boolean):void
		{
			_isAcceptLock = islock;
			//锁定时该物品显示滤镜效果
			if(_isAcceptLock == true && cellIcon != null)
			{
				var filter:ColorMatrixFilter = new ColorMatrixFilter([0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0, 0, 0, 1, 0]);
				myFilter.push(filter);  
				this.filters = myFilter;
			}
				//解除锁定时取消滤镜效果
			else if(!_isAcceptLock && cellIcon != null)
			{ 
				this.filters = [];
			}
		}
		
		
		override public function removeEvent():void
		{
			//super.removeEvent();
			this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			this.removeEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
		}
		
	}
	
}
