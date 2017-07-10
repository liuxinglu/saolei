package bajie.core.data.skill
{
	import flash.utils.Dictionary;
	import flash.events.EventDispatcher;
	
	public class SkillTemplateList extends EventDispatcher
	{
		private var _templateList:Dictionary;
		
		public function SkillTemplateList()
		{
			_templateList = new Dictionary();
		}
		
		/**
		 *获取对应技能模板信息 
		 * @param id 技能id
		 * @param level 技能等级
		 * @return 
		 * 
		 */		
		public function getTemplate(id:int, level:int):SkillTemplateInfo
		{
			
			return _templateList[id + "_" + level];
		}
		
		public function setup(data:XMLList):void
		{
			var xml:XML = XML(data);
			var xmllist:XMLList = xml.children();
			var len:int = xmllist.length();
			var info:SkillTemplateInfo;
			for(var i:uint = 0; i < len; i++)
			{//技能分类
				var xmllist2:XMLList = xmllist[i].children();
				var len2:int = xmllist2.length();
				
				for(var j:uint = 0; j < len2; j++)
				{
					info = new SkillTemplateInfo(int(xmllist[i].@openid));
					info.fillData(xmllist2[j]);
					_templateList[info.templateId +"_" + info.level] = info;
				}
			}
		}
		
	}
}