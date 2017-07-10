package bajie.interfaces.loader
{
	import flash.events.IEventDispatcher;
	import bajie.interfaces.decode.IDecode;
	import flash.system.LoaderContext;
	import bajie.interfaces.dispose.IDispose;

	public interface ILoader extends IEventDispatcher, IDispose
	{
		function loadSync(context:LoaderContext = null):void;
		function cancel():void;
		function get isStart():Boolean;
		function get path():String;
		function set path(value:String):void;
		function get isFinish():Boolean;
		function addCallBack(callBack:Function):void;
		function setDataFormat(value:String):void;
		function getData():*;
	}
}