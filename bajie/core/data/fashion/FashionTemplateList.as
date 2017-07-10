package bajie.core.data.fashion
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	public class FashionTemplateList
	{
		private var _templateList:Dictionary;
		
		public function FashionTemplateList()
		{
			_templateList = new Dictionary;
		}
		
		/**
		 *获取对应时装模板信息 
		 * @param id 时装id
		 * @return 
		 * 
		 */		
		public function getTemplate(id:int):FashionTemplateInfo
		{
			return _templateList[id];
		}
		
		public function setup(data:XMLList):void
		{
			var xml:XML = XML(data);
			var xmllist:XMLList = xml.children();
			var len:int = xmllist.length();
			var info:FashionTemplateInfo;
			for(var i:uint = 0; i < len; i++)
			{//时装分类
				info = new FashionTemplateInfo();
				info.fillData(xmllist[i]);
				_templateList[info.templateId] = info;
			}
		}
		
	}
}