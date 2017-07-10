package bajie.interfaces.loader
{
	import flash.utils.ByteArray;

	public interface ICacheApi
	{
		function getFile(path:String, callBack:Function, backup:Boolean = true):void;
		
		function setFile(path:String, data:ByteArray, backup:Boolean = true):void;
		
		/*
		*是否有缓存
		*/
		function getCanCache():Boolean;
		
		function setCanCache(value:Boolean):void;
		/**
		*保存缓存文件列表
		*/
		function saveCacheList():Boolean;
	}
}