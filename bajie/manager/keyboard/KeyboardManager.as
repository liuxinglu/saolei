﻿package bajie.manager.keyboard
{
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import bajie.interfaces.keyboard.*;
	
	public class KeyboardManager implements IKeyboardApi
	{
		private var _downKeys:Array;
		private var _stage:Stage;
		
		public function KeyboardManager(stage:Stage)
		{
			_stage = stage;
			if(_stage != null)
			{
				stage.stageFocusRect = false;
				init();
				initEvent();
			}
			
		}
		
		private function clearKeys():void
		{
			_downKeys.length = 0;
		}
		
		public function getKeyListener():IEventDispatcher
		{
			return (_stage);
		}
		
		public function dispose():void
		{
			removeEvent();
			_stage = null;
		}
		
		public function hasKeyDown(keys:Array):Boolean
		{
			var i:int;
			for each(i in keys)
			{
				if(keyIsDown(i))
				{
					return true;
				}
			}
			return false;
		}
		
		private function keyUpHandler(e:KeyboardEvent):void
		{
			var n:int = _downKeys.indexOf(e.keyCode);
			if(n != -1)
			{
				_downKeys.splice(n, 1);
			}
		}
		
		private function keyDownHandler(e:KeyboardEvent):void
		{
			if(_downKeys.indexOf(e.keyCode) == -1)
			{
				_downKeys.push(e.keyCode);
			}
		}
		
		private function initEvent():void
		{
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			_stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			_stage.addEventListener(Event.ACTIVATE, activateHandler);
			_stage.addEventListener(Event.DEACTIVATE, deactivateHandler);
		}
		
		public function keyIsDown(keyCode:int):Boolean
		{
			return (_downKeys.indexOf(keyCode) > -1);
		}
		
		private function init():void
		{
			_downKeys = [];
		}
		
		private function removeEvent():void
		{
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			_stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			_stage.removeEventListener(Event.ACTIVATE, activateHandler);
			_stage.removeEventListener(Event.DEACTIVATE, deactivateHandler);
		}
		
		private function activateHandler(e:Event):void
		{
			clearKeys();
		}
		
		private function deactivateHandler(e:Event):void
		{
			clearKeys();
		}
	}
}