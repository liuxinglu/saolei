package bajie.ui.fight.regard {
	import flash.display.MovieClip;
	import bajie.core.data.GlobalAPI;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class Puke extends MovieClip
	{
		private static var _puke:*;

		public function Puke() {
			// constructor code
			initView();
		}
		
		private function initView():void
		{
			_puke = GlobalAPI.loaderAPI.getObjectByClassPath("puke");
			addChild(_puke);
		}

		
		//设置puke帧数，1反2正
		public function setPukeFrame(i:int):void
		{
			_puke.gotoAndStop(i);
		}
		
		//设置奖品图片
		public function setIconImg(type:String, icon:String):void
		{
			var iconPath = GlobalAPI.pathManager.getDisplayPicPath(type, icon);
			var bounSprite:Sprite;
			var bitmap:Bitmap;
			GlobalAPI.loaderAPI.getPicFile(iconPath, function (e:BitmapData):void
			{
				boundSprite = new Sprite;
				boundSprite.doubleClickEnabled = true;
				boundSprite.x = 1;
				boundSprite.y = 1
				addChild(boundSprite);
				bitmap = new Bitmap(e);
				boundSprite.addChild(bitmap);
			}, SourceClearType.NEVER);
			_puke.iconContent.addChild(bounSprite);
		}
		//设置图片文字说明
		public function setIconInfo(s:String):void
		{
			_puke.iconInfo.text = s;
		}

	}
	
}
