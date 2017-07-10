package bajie.interfaces.keyboard
{
	import flash.events.IEventDispatcher;
	import bajie.interfaces.dispose.IDispose;

	public interface IKeyboardApi extends IDispose
	{
		/**
		数组中是否有键被按下
		*/
		function hasKeyDown(keys:Array):Boolean;
		
		/**
		按钮是否被按下
		*/
		function keyIsDown(keyCode:int):Boolean;
		
		/**
		获取键盘侦听器（场景）
		*/
		function getKeyListener():IEventDispatcher;
		
		//function dispose();
	}
}