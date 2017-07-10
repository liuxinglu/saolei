package bajie.interfaces.moviewrapper
{
	import flash.display.BitmapData;
	
	/**
	缓存bitmapdata,对重复性多的图像使用
	*/
	public interface IBDMovieWrapperFactory
	{
		/**
		获得一个imoviewrapper
		*/
		function getMovie():IMovieWrapper;
		/**
		获得源图数据
		*/
		function getBitmapData():BitmapData;
		function dispose():void;
	}
}