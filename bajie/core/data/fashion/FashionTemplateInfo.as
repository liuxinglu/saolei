package bajie.core.data.fashion
{
	import bajie.core.data.LayerInfo;
	
	public class FashionTemplateInfo extends LayerInfo
	{
		/**
		 *使用等级 
		 */		
		public var useLevel:String;
		/**
		 *能量 
		 */		
		public var energy:String;
		/**
		 *幸运 
		 */		
		public var lucky:String;
		/**
		 *灵巧 
		 */		
		public var dexterity:String;
		/**
		 *技能提升等级 
		 */		
		public var skillLevel:String;
		/**
		 *技能模板id 
		 */		
		public var skillTemplateId:String;
		/**
		 *佩戴位置 
		 */		
		public var position:String;
		
		public function FashionTemplateInfo()
		{
			super();
			//templateId = templateid;
		}
		
		public function fillData(xml:XML):void
		{
			templateId = xml.@openid;
			useLevel = xml.@uselevel;
			energy = xml.@energy;
			lucky = xml.@lucky;
			dexterity = xml.@dexterity;
			skillLevel = xml.@skilllevel;
			skillTemplateId = xml.@skillopenid;
			position = xml.@position;
		}
	}
}