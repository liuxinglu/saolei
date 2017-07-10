package bajie.core.data.task 
{
	import bajie.core.data.LayerInfo;
	/**
	 * ...
	 * @author azjune
	 */
	public class TaskTemplateInfo extends LayerInfo
	{
		public var type:int;
		public var name:String;
		public var description:String;
		public var sequence:String;
		public var gold:String;
		public var silver:String;
		public var exp:String;
		public var itemArr:Array;
		
		public function TaskTemplateInfo(templateid:int) 
		{
			super();
			templateId = templateid;
		}
		
		public function fillData(xml:XML):void
		{
			type = xml.@type;
			name = xml.@name;
			description = xml.@description;
			silver = xml.@silver;
			sequence = xml.@sequence;
			gold = xml.@gold;
			exp = xml.@exp;
			var xmlList:XMLList = xml.children();
			var len:int = xmlList.length();
			if (len > 0) {
				itemArr = new Array();
				for (var i:int = 0; i < len;i++ ) {
				var o:Object = new Object();
				o.openid = int(xmlList[i].@openid);
				o.type = int(xmlList[i].@type);
				o.style = int(xmlList[i].@style);
				o.quantity = int(xmlList[i].@quantity);
				itemArr.push(o);
				}
			}else {
				itemArr = null;
			}
			
		}
	}

}