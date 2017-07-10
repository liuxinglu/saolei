package bajie.action.item.skill 
{
	import bajie.core.data.bag.BagItemInfo;
	import bajie.interfaces.item.IMouseOver;
	import flash.events.MouseEvent;
	import bajie.events.ItemEvent;
	import bajie.manager.tick.ToolTipManager;
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class SkillItemOver implements IMouseOver 
	{
		private var _info:BagItemInfo;
		public function SkillItemOver() 
		{
			// constructor code
		}
		
		public function itemMouseOver(e:ItemEvent):void
		{
			_info = e.Param.currentTarget.info;
			if (_info) {
				if (_info.template) {
					ToolTipManager.getInstance().show(Event(e.Param).currentTarget as DisplayObject, _info);
				}
			}
		}

	}
	
}
