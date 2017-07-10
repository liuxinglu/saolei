package bajie.core.data.bag
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	public class ItemTemplateList extends EventDispatcher
	{
		private var _templateList:Dictionary;
		
		public function ItemTemplateList()
		{
			_templateList = new Dictionary();
		}
		
		/**
		 *获取对应物品模板信息 
		 * @param id 物品id
		 * @return 
		 * 
		 */		
		public function getTemplate(id:int):ItemTeampleInfo
		{
			return _templateList[id];
		}
		
		public function setup(data:XMLList):void
		{
			var xml:XML = XML(data);
			var xmllist:XMLList = xml.children();
			var len:int = xmllist.length();
			var info:ItemTeampleInfo;
			for(var i:uint = 0; i < len; i++)
			{
				info = new ItemTeampleInfo();
				info.fillData(xmllist[i]);
				_templateList[info.template_id] = info;
			}
		}
		
		
	}
}