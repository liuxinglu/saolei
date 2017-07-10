package bajie.ui.strengthen 
{
	import bajie.action.item.strengthen.*;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.ui.base.item.BaseItem;
	import bajie.action.item.bag.*;
	import bajie.core.data.GlobalAPI;
	import bajie.constData.SourceClearType;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import bajie.core.data.drag.GlobalDragItemInfo;
	import bajie.constData.ModuleType;
	/**
	 * ...
	 * @author azjune
	 */
	public class StrengthenItem extends BaseItem 
	{
		public var clickEnabled:Boolean = true;
		private var _icon:Bitmap;
		public var style:int = 0;
		/**
		 * @param	type 0普通 1装备 2强化石 3幸运符 4防爆符 
		 */
		public function StrengthenItem(_style:int = 0) 
		{
			this.gotoAndStop(2);
			
			if (_style == 2) {
				txt_strengthen.gotoAndStop(2);
			}else if (_style == 3) {
				txt_strengthen.gotoAndStop(3);
			}else if (_style == 4) {
				txt_strengthen.gotoAndStop(4);
			}
			style = _style;
			
			_icon = new Bitmap();
			addChild(_icon);
			_icon.x = 1;
			_icon.y = 1;
			initEvent();
		}
		/**
		 * 设置强化装备时格子的样式
		 * @param	_style 1装备，2强化石，3幸运符，4防爆符
		 */
		public function initBagInfo(o:Object):void {
			info = new BagItemInfo();
		}
		private function initEvent():void {
			itemClick = new StrengthenClick();
			itemOver = new StrengthenOver();
			itemDown = new StrengthenDown();
			itemOut = new StrengthenOut();
		}
		/**
		 * 获取图片的方法
		 */
		public function initItemPic():void
		{
			if (info == null) {
				_icon.bitmapData = null;
				return;
			}
			var _iconPath:String = GlobalAPI.pathManager.getDisplayPicPath(info.template.type, info.templateId.toString());
			GlobalAPI.loaderAPI.getPicFile(_iconPath, getPic, SourceClearType.NEVER);
		}
		private function getPic(e:BitmapData):void {
			_icon.bitmapData = e;
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
			//var srcItemInfo:BagItemInfo;
			//var tagItemInfo:BagItemInfo;
			//
			//if(srcBaseType == ModuleType.STRENGTHEN && tagBaseType == ModuleType.STRENGTHEN)
			//{//交换位置--------
				//srcItemInfo = BagItem(srcObj).info;
				//tagItemInfo = BagItem(tagObj).info;
				//
				//if(srcItemInfo.type == GoodsType.EQUIP || srcItemInfo.type == GoodsType.WEAPON)
				//{//装备
					//GlobalData.bagInfo.changeEquipSite(srcObj.index, tagObj.index);
				//}
				//else if(srcItemInfo.type == GoodsType.PROP || srcItemInfo.type == GoodsType.GEMSTONE)
				//{//道具
					//GlobalData.bagInfo.changePropSite(srcObj.index, tagObj.index);
				//}
				//else if(srcItemInfo.type == GoodsType.FLASHION)
				//{//时装
					//GlobalData.bagInfo.changeFashionSite(srcObj.index, tagObj.index);
				//}
				//
			//}
		}
	}

}