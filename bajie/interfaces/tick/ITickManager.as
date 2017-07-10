package bajie.interfaces.tick
{
	public interface ITickManager
	{
		function addTick(tick:ITick):void;
		function removeTick(tick:ITick):void;
		function inTick(tick:ITick):Boolean;
		/**
		*清除所有tick
		*/
		function clear():void;
	}
}