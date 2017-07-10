package bajie.manager.tick {
	import flash.events.Event;
	import flash.utils.getTimer;
	import bajie.interfaces.layer.ILayerManager;
	import bajie.interfaces.tick.ITick;
	import bajie.interfaces.tick.ITickManager;
	
	public class TickManager implements ITickManager
	{
		public static var enterFrameTick:int;
		private var _tickTimes:uint;
		private var _startSec:Number;
		private var _ticks:Array;
		
		public function TickManager(layerManager:ILayerManager, enterFrameTick:int = 40) 
		{
			// constructor code
			TickManager.enterFrameTick = enterFrameTick;
			_ticks = [];
			layerManager.getModuleLayer().addEventListener(Event.ENTER_FRAME, tickHandler);
			_startSec = getTimer();
			_tickTimes = 0;
		}
		
		public function removeTick(tick:ITick):void
		{
			var n:int = _ticks.indexOf(tick);
			if(n > -1)
			{
				_ticks.splice(n, 1);
			}
		}
		
		public function inTick(tick:ITick):Boolean
		{
			return (_ticks.indexOf(tick) > -1);
		}
		
		public function onTick(times:int):void
		{
			var tmp:ITick;
			var i:int = _ticks.length - 1;
			while(i >= 0)
			{
				tmp = _ticks[i];
				if(tmp)
				{
					tmp.update(times);
				}
				i--;
			}
		}
		
		public function addTick(tick:ITick):void
		{
			if(_ticks.indexOf(tick) == -1)
			{
				_ticks.push(tick);
			}
		}
		
		private function tickHandler(e:Event):void
		{
			var timers:int = (getTimer() - _startSec) / TickManager.enterFrameTick;
			var dtimes:int = timers - _tickTimes;
			if(dtimes > 3)
			{
				onTick(dtimes);
			}
			else
			{
				onTick(1);
			}
			_tickTimes = timers;
		}
		
		public function clear():void
		{
			_ticks.length = 0;
		}

	}
	
}
