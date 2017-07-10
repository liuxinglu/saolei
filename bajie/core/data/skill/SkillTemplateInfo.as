package bajie.core.data.skill
{
	import bajie.core.data.LayerInfo;
	
	public class SkillTemplateInfo extends LayerInfo
	{
		/**
		 *分類編號 //1道具2武器3装备4时装5宝石6技能
		 */	
		public var type:String;
		
		/**
		 *使用等级 
		 */		
		public var useLevel:String;
		
		/**
		 *道具等级 
		 */		
		public var level:String;
		
		/**
		 *消耗的银币 
		 */		
		public var silver:String;
		
		/**
		 *触发概率 
		 */		
		public var touch:String;
		
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
		 *冷却时间 -毫秒
		 */		
		public var coolTimer:String;
		
		/**
		 * 持续时间 -毫秒
		 */		
		public var holdTimer:String;
		
		/**
		 *技能范围 
		 */		
		public var radius:String;
		
		/**
		 *显示格子范围 
		 */		
		public var lattice:String;
		
		/**
		 *减少有害状态持续时间 -毫秒 
		 */		
		public var killTimer:String;
		
		/**
		 *技能升级最大等级 
		 */		
		public var maxLevel:String;
		
		public function SkillTemplateInfo(templateid:int)
		{
			super();
			templateId = templateid;
		}
		
		public function fillData(xml:XML):void
		{
			type = xml.@type;
			useLevel = xml.@uselevel;
			level = xml.@level;
			silver = xml.@silver;
			touch = xml.@touch;
			energy = xml.@energy;
			lucky = xml.@lucky;
			dexterity = xml.@dexterity;
			coolTimer = xml.@cooltimer;
			holdTimer = xml.@holdtimer;
			radius = xml.@radius;
			lattice = xml.@lattice;
			killTimer = xml.@killtimer;
			maxLevel = xml.@maxLevel;
		}
	}
}