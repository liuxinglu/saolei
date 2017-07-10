package bajie.interfaces.item
{
	import flash.events.MouseEvent;
	import bajie.events.ItemEvent;

	public interface IClick
	{
		/**
		格子点击事件
		*/
		function itemClick(e:ItemEvent):void;
	}
}