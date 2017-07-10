package bajie.action.item.strengthen
{
	import bajie.interfaces.item.IClick;
	import bajie.events.ItemEvent;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.ui.strengthen.StrengthenItem;
	import bajie.core.data.GlobalData;
	import bajie.constData.GoodsType;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class StrengthenClick implements IClick
	{
		private var item:StrengthenItem;
		
		public function StrengthenClick()
		{
			// constructor code
		}
		
		public function itemClick(e:ItemEvent):void
		{
			item = e.Param.currentTarget;
			if (item.style == 0)
			{
				if (item.info)
				{
					
					if (GlobalData.strengthenInfo.strengthenType == GoodsType.EQUIP)
					{
						if (item.info.templateId == GoodsType.EQIUP_STONE)
						{
							if (item.info.number > GlobalData.strengthenInfo.mustStone)
							{
								GlobalData.strengthenInfo.useStone = GlobalData.strengthenInfo.mustStone;
							}
							else
							{
								GlobalData.strengthenInfo.useStone = item.info.number;
							}
						}
					}
					if (GlobalData.strengthenInfo.strengthenType == GoodsType.WEAPON)
					{
						if (item.info.templateId == GoodsType.WEAPON_STONE)
						{
							if (item.info.number > GlobalData.strengthenInfo.mustStone)
							{
								GlobalData.strengthenInfo.useStone = GlobalData.strengthenInfo.mustStone;
							}
							else
							{
								GlobalData.strengthenInfo.useStone = item.info.number;
							}
						}
					}
					if (item.info.templateId == GoodsType.LUCKY_STONE)
					{
						GlobalData.strengthenInfo.useLucky = 1;
					}
					if (item.info.templateId == GoodsType.EXPLOSION_STONE)
					{
						GlobalData.strengthenInfo.useExplosion = 1;
					}
				}
			}
			if (item.style == 2)
			{
				if (GlobalData.strengthenInfo.useStone > 0)
				{
					GlobalData.strengthenInfo.useStone = 0;
				}
				else
				{
					if (GlobalData.strengthenInfo.totalStone > 0)
					{
						if (GlobalData.strengthenInfo.totalStone > GlobalData.strengthenInfo.mustStone)
						{
							GlobalData.strengthenInfo.useStone = GlobalData.strengthenInfo.mustStone;
						}
						else
						{
							GlobalData.strengthenInfo.useStone = GlobalData.strengthenInfo.totalStone;
						}
					}
				}
			}
			if (item.style == 3)
			{
				if (GlobalData.strengthenInfo.useLucky > 0)
				{
					GlobalData.strengthenInfo.useLucky = 0;
				}
				else
				{
					if (GlobalData.strengthenInfo.totalLucky > 0)
					{
						GlobalData.strengthenInfo.useLucky = 1;
					}
				}
			}
			if (item.style == 4)
			{
				if (GlobalData.strengthenInfo.useExplosion > 0)
				{
					GlobalData.strengthenInfo.useExplosion = 0;
				}
				else
				{
					if (GlobalData.strengthenInfo.totalExplosion > 0)
					{
						GlobalData.strengthenInfo.useExplosion = 1;
					}
				}
			}
			GlobalData.strengthenInfo.updateStrengthenItem();
		}
	
	}

}