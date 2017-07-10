package bajie.core.data.bag 
{
	import bajie.core.data.LayerInfo;
	import flash.utils.ByteArray;
	
	public class ItemTeampleInfo extends LayerInfo
	{
		/**
		 *模板名称 
		 */		
		public var name:String;
		/**
		 *id 
		 */		
		public var template_id:int;
		/**
		 *圖片 
		 */		
		public var pic:String;
		/**
		 *圖標 
		 */		
		public var icon:String;
		/**
		 *描述 
		 */		
		public var description:String;
		/**
		 *分類編號 //1道具2武器3装备4时装5宝石6技能
		 */		
		public var type:String;
		
		/**
		 *分类名 
		 */		
		public var typeName:String;
		/**
		 *子類編號 
		 */		
		public var subType:int;
		/**
		 * 顏色
		 */
		public var color:int;
		/**
		 *品質 
		 */		
		public var quailty:int;
		/**
		 *需要等級 
		 */		
		public var need_level:int;
		/**
		 *需要性別 
		 */		
		public var need_sex:int;
		/**
		 *需要職業 
		 */		
		public var need_career:int;
		/**
		 *最大數量 
		 */		
		public var max_count:int;
		/**
		 *賣店價格 
		 */		
		public var sell_copper:int;
		/**
		 *賣店貨幣類型 
		 */		
		public var sell_type:int;
		/**
		 *銀幣 
		 */		
		public var silver:int;
		/**
		 *金幣 
		 */		
		public var gold:int;
		/**
		 *套裝編號 
		 */		
		public var suit_id:int;
		/**
		 *修理係數 
		 */		
		public var repair_modulus:int;
		/**
		 *綁定類型-0非綁定，1綁定 
		 */		
		public var bind_type:int;
		/**
		 *耐久度上線 
		 */		
		public var durable_upper:int;
		/**
		 *冷卻時間 
		 */		
		public var cd:int;
		/**
		 *能否使用-0不能使用，1能使用 
		 */		
		public var can_use:int;
		/**
		 *能否解鎖-0不能，1能 
		 */		
		public var can_lock:int;
		/**
		 *能否強化-0不能，1能 
		 */		
		public var can_strengthen:int;
		/**
		 *能否鑲嵌-0不能，1能 
		 */		
		public var can_enchase:int;
		/**
		 *能否洗練-0不能，1能 
		 */		
		public var can_rebuild:int;
		/**
		 *能否分解-0不能，1能 
		 */		
		public var can_recycle:int;
		/**
		 *能否升階-0不能，1能 
		 */		
		public var can_improve:int;
		/**
		 *能否解綁-0不能，1能 
		 */		
		public var can_unbind:int;
		/**
		 *能否修理-0不能，1能 
		 */		
		public var can_repair:int;
		/**
		 *能否丟棄-0不能，1能
		 */		
		public var can_destroy:int;
		/**
		 *能否出售-0不能，1能 
		 */		
		public var can_sell:int;
		/**
		 *能否交易-0不能，1能 
		 */		
		public var can_trade:int;
		/**
		 *基礎屬性 
		 */		
		public var base_property:int;
		/**
		 *附加属性描述 
		 */		
		public var additional_description:String;
		/**
		 *附加属性 
		 */		
		public var additional_property:int;
		/**
		 *天生属性 
		 */		
		public var natura_property:int;
		/**
		 *有效时间 
		 */		
		public var valid_time:int;
		/**
		 *属性1 
		 */		
		public var property1:int;
		/**
		 *属性2 
		 */		
		public var property2:int;
		public var other_data:int;
		public var freePropertyList:Array;
		public var regularPropertyList:Array;
		public var hidePropertyList:Array;
		
		//---------------------------------
		public var categoryId:int;
		public var category_id:int;
		public function ItemTeampleInfo() {
			// constructor code
			freePropertyList = [];
			regularPropertyList = [];
			hidePropertyList = [];
		}
		
		public function fillData(xml:XML):void
		{
			name = xml.@name;
			template_id = xml.@openid;
			pic = xml.@openid;
			icon = xml.@openid;
			description = xml.@content;
			typeName = xml.@type;
			type = getTypeByName(typeName);
			additional_description = xml.@expansion;
		}
		
		public function getTypeByName(s:String):String
		{
			switch(s)
			{
				case "道具":
					return "prop";
					break;
				case "武器":
					return "weapon";
					break;
				case "头盔":
					return "equip";
					break;
				case "上装":
					return "equip";
					break;
				case "下装":
					return "equip";
					break;
				case "鞋子":
					return "equip";
					break;
				case "饰品":
					return "equip";
					break;
				case "头部":
					return "fashion";
					break;
				case "脸饰":
					return "fashion";
					break;
				case "身体":
					return "fashion";
					break;
				case "装饰":
					return "fashion";
					break;
				case "背景":
					return "fashion";
					break;
				case "技能":
					return "skill";
					break;
			}
			return "";
		}
		
		public function loadData(category:int, data:ByteArray):void
		{
			
		}
		
		public function splitString(argContent:String, argKeyWords:String):Array
		{
			var tmpSplitList:Array = null;
			if(argContent != "")
			{
				tmpSplitList = argContent.split(argKeyWords);
			}
			return tmpSplitList;
		}
		

	}
	
}
