package bajie.ui.shop 
{
	import bajie.core.data.bag.BagItemInfo;
	import bajie.ui.base.item.BaseItem;
	import bajie.action.item.shop.*
	import bajie.core.data.GlobalAPI;
	import bajie.constData.SourceClearType;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author azjune
	 */
	public class ShopItem extends BaseItem 
	{
		private var _icon:Bitmap;
		private var _iconPath:String;
		public function ShopItem() 
		{
			itemClick = new ShopClick();
			itemOver = new ShopOver();
			itemDown = new ShopDown();
			itemOut = new ShopOut();
			
			_icon = new Bitmap();
			addChild(_icon);
			_icon.x = _icon.y = 1;
			
		}
		/**
		填图
		*/
		public function initBagCell():void
		{
			if(info == null)
				return;
				
			try {
				_iconPath = GlobalAPI.pathManager.getDisplayPicPath(info.template.type, info.template.icon);
			
				GlobalAPI.loaderAPI.getPicFile(_iconPath, function (e:BitmapData):void
				{
					_icon.bitmapData = e;
				}, SourceClearType.NEVER);
			}catch (err:Error) {
				trace(err);
				_icon.bitmapData = null;
			}
			
			
		}
		override public function removeEvent():void {
			super.removeEvent();
			while (this.numChildren>0) {
				removeChildAt(0);
			}
			_icon = null;
		}
	}

}