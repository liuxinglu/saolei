package bajie.core.data.bag
{
	import bajie.core.data.GlobalData;
	import bajie.core.data.GlobalAPI;
	import bajie.interfaces.tick.ITick;
	import flash.events.EventDispatcher;
	import bajie.events.ItemEvent;

	public class BagItemInfo extends EventDispatcher implements ITick
	{
		//1道具2武器3装备4时装5宝石6技能
		public var type:int = 0;
		public var binder:int = 0;//是否绑定 1绑定 0未绑定
		public var position:int = 0;//背包中的位置索引
		//public var openid:int = 0;
		public var number:int = 0;//数量
		public var expired:int = 0;//附加描述
		public var color:uint = 0;//品质颜色 1绿 2蓝 3紫
		//--------------------
		public var wear:int = 0;//物品使用所需等级
		public var style:int = 0;//备用
		public var itemId:Number;//物品id
		public var templateId:int;//模板id
		public var energy:int;//能量
		public var lucky:int;//幸运
		public var dex:int;//灵巧
		public var additEnergy:int;//附加能量
		public var additLucky:int;//附加幸运
		public var additDex:int;//附加灵巧
		public var classify:int;//武器分类（1能量2幸运3灵巧）
		public var level:int;//等级
		public var inside:int = 0;//人物属性显示位置
		public var getInfoOrNot:Boolean = false;//是否获得过格子详细信息 
		public var curPage:int = 1;//格子所在页
		public var gemfirst:int;//宝石镶嵌第一个位置的宝石id
		public var gemsecond:int;//宝石镶嵌的第二个位置的宝石id
		public var gemthird:int;//宝石镶嵌的第三个位置的宝石id
		public var gemfour:int;//宝石镶嵌的第四个位置的宝石id
		public var sysclass:int;//武器分类=classify
		public var learn:int;//技能是否学习过 1已学习过 0未学习过

		public var useLevel:int;//使用等级
		public var skillLevel:int;//装备时装等关联技能的等级
		public var skillTemplateId:int;//装备时装等关联技能模板id

		public var buyGold:int;//购买时金币价格
		public var buySilver:int;//购买时银币价格

		
		
		//public var date:Date;
		/**
		 *道具状态， 0正常, 1冷却, 2耐久为0, 3出售中， 4求购中, 5保护锁 
		 */		
		public var state:int;
		/**
		 *未开孔-1，开孔0，镶嵌后宝石模板id 
		 */		
		public var enchase1:Number;
		public var enchase2:Number;
		public var enchase3:Number;
		public var isExist:Boolean;
		/**
		 *装备基础属性 
		 */		
		public var baseProperty:String;
		/**
		 *装备附加属性 
		 */		
		public var additProperty:String;
		/**
		 *装备洗练属性 
		 */		
		public var washProperty:String;
		/**
		 *装备套装属性 
		 */		
		public var suitProperty:String;
		/**
		 *装备宝石属性 
		 */		
		public var gemProperty:String;
	
		public var freePropertyVector:Array;
		public var lastUseTime:int;
		private var _isInCooldown:Boolean;
		private var _locked:Boolean;
		/**
		 *交易锁定 
		 */		
		private var _tradeLocked:Boolean;
		public function BagItemInfo()
		{
			freePropertyVector = [];
		}
		
		public function get template():ItemTeampleInfo
		{
			return GlobalData.itemTemplateList.getTemplate(templateId);
		}
		
		public function updateInfo():void
		{
			dispatchEvent(new ItemEvent(ItemEvent.UPDATE));
		}
		
		public function get lock():Boolean
		{
			return _locked || _tradeLocked;
		}
		
		public function set lock(value:Boolean):void
		{
			if(_locked == value)
				return ;
			_tradeLocked = value;
			dispatchEvent(new ItemEvent(ItemEvent.LOCK_UPDATE));
		}
		
		public function set tradeLock(value:Boolean):void
		{
			if(_tradeLocked == value)
			{
				return;
			}
			_tradeLocked = value;
			dispatchEvent(new ItemEvent(ItemEvent.LOCK_UPDATE));
		}
		
		public function get isInCoolDown():Boolean
		{
			return _isInCooldown;
		}
		
		public function set isInCoolDown(value:Boolean):void
		{
			if(_isInCooldown == value)
				return;
			_isInCooldown = value;
			if(_isInCooldown)
				GlobalAPI.tickManager.addTick(this);
			dispatchEvent(new ItemEvent(ItemEvent.COOLDOWN_UPDATE));
		}
		
		public function update(times:int, dt:Number = 0.04):void
		{
			if(!((GlobalData.systemDate.getSystemDate().getTime() - lastUseTime) < 10000 + 200))
			{
				isInCoolDown = (GlobalData.systemDate.getSystemDate().getTime() - lastUseTime) < 10000 + 200;
				GlobalAPI.tickManager.removeTick(this);
			}
		}
		
		public function isInStall():Boolean
		{
			return state == 3;
		}
		
		public function isInLock():Boolean
		{
			return state == 5;
		}
		
		public function canOperate():Boolean
		{
			return !lock && !isInStall() && !isInLock();
		}
		
		public function getSellPrice():int
		{
			return template.sell_copper;
		}
		
		/**
		 *已镶嵌宝石的孔数 
		 */		
		public function getEnhanseCount():int
		{
			var count:int;
			if(enchase1 > 0) count++;
			if(enchase2 > 0) count++;
			if(enchase3 > 0) count++;
			return count;
		}
		
		/**
		 *已使用的孔数 
		 */		
		public function getUseHoleCount():int
		{
			var count:int;
			if(enchase1 >= 0) count++;
			if(enchase2 >= 0) count++;
			if(enchase3 >= 0) count++;
			return count;
		}
		
		/**
		 *已开孔数 
		 */		
		public function getOpenHoleCount():int
		{
			var count:int;
			if(enchase1 == 0) count++;
			if(enchase2 == 0) count++;
			if(enchase3 == 0) count++;
			return count;
		}
		
		public function getCanUse():Boolean
		{
			return true;
		}
	}
}