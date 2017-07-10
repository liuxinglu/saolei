package bajie.action.item.shop 
{
	import bajie.interfaces.item.IClick;
	import bajie.events.ItemEvent;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.constData.GoodsType;
	/**
	 * ...
	 * @author azjune
	 */
	public class ShopClick implements IClick
	{
		private var _info:BagItemInfo;
		

		public function ShopClick() {
			// constructor code
		}
		
		public function itemClick(e:ItemEvent):void
		{
			_info = e.Param.currentTarget.info;
			if (_info.type == GoodsType.FLASHION ) {
				trace("时装物品点击了");
			}
			
		}
		
	}

}