package bajie.ui.shop
{
	import flash.events.*;
	import flash.net.*;
	/**
	 * ...
	 * @author azjune
	 */
	public class LoaderShopInfo
	{
		private var address_1:String = "http://112.82.223.13:10088/mall/itemlist.ashx";
		private var address_2:String = "http://112.82.223.13:10088/mall/itemprice.ashx";
		
		private var variables:URLVariables;
		private var loader:URLLoader;
		private var request:URLRequest;
		
		private var loadFun:Function;
		public function LoaderShopInfo()
		{
			loader = new URLLoader();
			
			loader.addEventListener(Event.COMPLETE, loader_complete);
			loader.addEventListener(Event.OPEN, loader_open);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, loader_httpStatus);
			loader.addEventListener(ProgressEvent.PROGRESS, loader_progress);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_security);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loader_ioError);
		}
		public function loaderListInfo(type:String,style:String,index:String,fun:Function):void {
			request = new URLRequest(address_1);
			variables = new URLVariables();
			request.data = variables;
			request.method = URLRequestMethod.POST;
			variables.tab = type;
			variables.style = style;
			variables.index = index;
			loadFun = fun;
			
			loader.load(request);
		}
		public function loaderItemInfo(kind:String,fun:Function):void {
			request = new URLRequest(address_2);
			variables = new URLVariables();
			variables.kind = kind;
			request.data = variables;
			request.method = URLRequestMethod.GET;
			
			loadFun = fun;
			
			loader.load(request);
		}
		
		private function loader_complete(e:Event):void
		{
			//trace("Event.COMPLETE");
			//trace("目标文件的原始数据 (纯文本) : \n" + loader.data);
			var xml:XML = new XML(loader.data);
			loadFun(xml);
		}
		
		private function loader_open(e:Event):void
		{
			//trace("Event.OPEN");
			//trace("读取了的字节 : " + loader.bytesLoaded);
		}
		
		private function loader_httpStatus(e:HTTPStatusEvent):void
		{
			//trace("HTTPStatusEvent.HTTP_STATUS");
			//trace("HTTP 状态代码 : " + e.status);
		}
		
		private function loader_progress(e:ProgressEvent):void
		{
			//trace("ProgressEvent.PROGRESS");
			//trace("读取了的字节 : " + loader.bytesLoaded);
			//trace("文件总字节 : " + loader.bytesTotal);
		}
		
		private function loader_security(e:SecurityErrorEvent):void
		{
			//trace("SecurityErrorEvent.SECURITY_ERROR");
		}
		
		private function loader_ioError(e:IOErrorEvent):void
		{
			//trace("IOErrorEvent.IO_ERROR");
		}
		public function removeEvent():void {
			loader.removeEventListener(Event.COMPLETE, loader_complete);
			loader.removeEventListener(Event.OPEN, loader_open);
			loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, loader_httpStatus);
			loader.removeEventListener(ProgressEvent.PROGRESS, loader_progress);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_security);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, loader_ioError);
			loader = null;
		}
	}

}