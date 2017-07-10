package bajie.core.data.task 
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author azjune
	 */
	public class TaskTemplateList extends EventDispatcher
	{
		private var _templateList:Dictionary;
		public function TaskTemplateList() 
		{
			_templateList = new Dictionary();
		}
		/**
		 *获取对应任务模板信息 
		 * @param id 任务id
		 * @return 
		 * 
		 */		
		public function getTemplate(id:int):TaskTemplateInfo
		{
			
			return _templateList[id];
		}
		
		public function setup(data:XMLList):void
		{
			var xml:XML = XML(data);
			var xmllist:XMLList = xml.children();
			var len:int = xmllist.length();
			var info:TaskTemplateInfo;
			for(var i:uint = 0; i < len; i++)
			{
				info = new TaskTemplateInfo(int(xmllist[i].@openid));
				info.fillData(xmllist[i]);
				_templateList[info.templateId] = info;
			}
		}
	}

}