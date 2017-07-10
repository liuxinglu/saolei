package bajie.interfaces.moviewrapper
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	
	import bajie.interfaces.display.IDisplayObject;
	
	public interface IMovieWrapper extends IDisplayObject
	{
		/**
		播放动画
		upateImmediately 马上显示到屏幕
		stopAt 只会停止一次
		*/
		function play(updateImmediately:Boolean = false, stopAt:int = -1):void;
		
		/**
		停止
		*/
		function stop():void;
		
		/**
		停止并从屏幕上移除
		*/
		function stopAndClear():void;
		
		/**
		从屏幕上移除
		*/
		function clear():void;
		
		/**
		从第frame帧开始播放
		*/
		function gotoAndPlay(frame:int, updateImmdiately:Boolean = false):void;
		
		/**
		跳转到frame帧并停止
		*/
		function gotoAndStop(frame:int):void;
		
		/**
		设置和返回当前帧
		*/
		function get currentFrame():int;
		function set currentFrame(value:int):void;
		function get totalFrame():int;
		
		/**
		添加帧代码
		*/
		function addFrameScript(frame:int, script:Function):void;
		
		/**
		设置和获取帧间隔时间
		*/
		function get tick():int;
		function set tick(value:int):void;
		function move(x:Number, y:Number):void;
	}
}