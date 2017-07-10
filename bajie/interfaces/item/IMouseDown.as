package bajie.interfaces.item
{
	import flash.events.MouseEvent;
	import bajie.events.ItemEvent;

	public interface IMouseDown
	{
		/**
		鼠标按下
		*/
		function itemMouseDown(e:ItemEvent):void;
	}
}