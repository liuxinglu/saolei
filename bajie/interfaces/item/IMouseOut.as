package bajie.interfaces.item
{
	import flash.events.MouseEvent;
	import bajie.events.ItemEvent;

	public interface IMouseOut
	{
		/**
		鼠标移出
		*/
		function itemMouseOut(e:ItemEvent):void;
	}
}