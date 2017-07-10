package bajie.ui.email 
{
	import bajie.action.item.email.*;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.ui.base.item.BaseItem;
	import bajie.core.data.GlobalAPI;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import bajie.constData.SourceClearType;
	import flash.events.MouseEvent;
	import bajie.core.data.GlobalData;
	import bajie.events.ParamEvent;
	import bajie.events.ItemEvent;
	/**
	 * ...
	 * @author azjune
	 */
	public class EmailItem extends BaseItem 
	{
		public var icon:Bitmap;
		public var emailListIndex:int;
		public function EmailItem() 
		{
			//this.graphics.beginFill(0xffffff, 1);
			//this.graphics.drawRect(0, 0, 48, 48);
			//this.graphics.endFill();
			super();
			icon = new Bitmap();
			addChild(icon);
			icon.x = 1;
			icon.y = 1;
			initItem();
			this.infoTextMC.gotoAndStop(13);
		}
		override public function removeEvent():void {
			super.removeEvent();
			icon = null;
		}
		private function initItem():void {
			itemClick = new EmailItemClick();
			itemDown = new EmailItemDown();
			itemOut = new EmailItemOut();
			itemOver = new EmailItemOver();
		}
		public function initBagCell():void
		{
			if(info == null)
				return;
				
			try {
				var iconPath:String = GlobalAPI.pathManager.getDisplayPicPath(info.template.type, info.template.icon);
			
				GlobalAPI.loaderAPI.getPicFile(iconPath, function (e:BitmapData):void
				{
					icon.bitmapData = e;
				}, SourceClearType.NEVER);
			}catch (err:Error) {
				trace(err);
				icon.bitmapData = null;
			}
		}
	}

}