package bajie.ui.skill 
{
	import bajie.core.data.bag.BagItemInfo;
	import bajie.core.data.skill.SkillTemplateInfo;
	import bajie.ui.base.item.BaseItem;
	import bajie.core.data.GlobalData;
	import bajie.action.item.skill.*
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import bajie.core.data.GlobalAPI;
	import bajie.constData.SourceClearType;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class SkillItem extends BaseItem 
	{
		private var _icon:Bitmap;
		public function SkillItem() 
		{
			initItem();
			_icon = new Bitmap();
			addChild(_icon);
			_icon.x = 1;
			_icon.y = 1;
		}
		private function initItem():void {
			itemClick = new SkillItemClick();
			itemDown = new SkillItemDown();
			itemOut = new SkillItemOut();
			itemOver = new SkillItemOver();
		}
		/**
		填图
		*/
		public function initBagCell():void
		{
			if(info == null)
				return;
				
			try {
				var _iconPath:String = GlobalAPI.pathManager.getDisplayPicPath(info.template.type, info.template.icon);
			
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
			_icon = null
		}
	}

}