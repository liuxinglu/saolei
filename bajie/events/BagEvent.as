package bajie.events
{
	import flash.events.Event;
	
	public class BagEvent extends Event
	{	
		public static const BAG_PLAYER_INFO:String = "BAG_PLAYER_INFO";//获取背包内人物信息
		public static const BAG_PROP_INFO:String = "BAG_PROP_INFO";//获取背包内道具信息
		public static const BAG_FASHION_INFO:String = "BAG_FASHION_INFO";//获取背包内时装信息
		public static const BAG_EQUIP_INFO:String = "BAG_EQUIP_INFO";//获取背包内装备信息
		public var data:Object;
		
		public function BagEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.data = data;
			super(type, bubbles, cancelable);
		}
	}
}