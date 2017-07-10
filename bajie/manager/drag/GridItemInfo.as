package bajie.manager.drag
{
	public class GridItemInfo
	{
		public var instanceID:int;	//	物品实例id
		public var templateID:Number;	//	物品模板id静态
		public var iconID:String;//物品图标id
		public var grid:int;		//物品所在格子位置
		public var typeID:int;	//物品装备类型id
		public var isLock:Boolean;//物品是否锁定
		public var num:int;	//物品数量
		public function GridItemInfo()
		{
		}
	}
}