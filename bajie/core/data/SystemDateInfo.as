package bajie.core.data
{
	import flash.events.EventDispatcher;
	import bajie.interfaces.tick.ITick;
	import bajie.module.ModuleEventDispatcher;
	import bajie.events.CommonModuleEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;

	public class SystemDateInfo extends EventDispatcher implements ITick
	{
		private var _serverDate:Date;
		private var _timeWhenSynch:Number;
		private var _preday:int;
		private var _dtCount:Number = 0;
		
		public function SystemDateInfo()
		{
			_serverDate = new Date();
			_preday = -1;
		}
		
		public function syncSystemDataBy(n:Number):void
		{
			if(_serverDate != null)
			return;
			_serverDate = new Date();
			_serverDate.time = n;
			_timeWhenSynch = n;
			GlobalAPI.tickManager.addTick(this);
		}
		
		public function syncSystemDate(d:Date):void
		{
			_serverDate = d;
			_timeWhenSynch = getTimer();
			GlobalAPI.tickManager.addTick(this);
		}
		
		public function getSystemDate():Date
		{
			var d:Date = new Date(_serverDate.time);
			d.milliseconds += (getTimer() - _timeWhenSynch);
			return d;
		}
		
		public function update(times:int, dt:Number = 0.04):void
		{
			_dtCount += dt * times;
			if(_dtCount >= 1)
			{
				_dtCount = 0;
				if(_serverDate == null)
				return;
				var t:Date = getSystemDate();
				if(_preday != -1)
				{
					if(_preday != t.day)
					{
						ModuleEventDispatcher.dispatchCommonModuleEvent(new CommonModuleEvent(CommonModuleEvent.DATETIME_UPDATE));
					}
				}
				_preday = t.day;
			}
		}
	}
}