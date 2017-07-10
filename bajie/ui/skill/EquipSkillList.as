package bajie.ui.skill 
{
	import bajie.core.data.bag.BagItemInfo;
	import bajie.core.data.skill.SkillTemplateInfo;
	import flash.display.MovieClip;
	import bajie.core.data.GlobalAPI;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import bajie.constData.SourceClearType;
	import bajie.core.data.GlobalData;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class EquipSkillList extends MovieClip 
	{
		public var equip:Boolean = false;
		private var _mc:*;
		public var icon:SkillItem;
		public var pageIndex:int = 0;
		public function EquipSkillList() 
		{
			_mc = GlobalAPI.loaderAPI.getObjectByClassPath("equipSkillList");
			
			addChild(_mc);
			icon = new SkillItem();
			icon.x = 4;
			icon.y = 5;
			addChild(icon);
			initEvent();
			_mc.btn_unEquip.buttonMode = true;
		}
		public function setEquipType(o:Object = null,index:int = 0):void {
			//{\\\"idx\\\":1,\\\"type\\\":6,\\\"position\\\":1,\\\"inside\\\":0,\\\"openid\\\":550001,\\\"level\\\":1,\\\"learn\\\":1}
			icon.info = new BagItemInfo();

			icon.info.itemId = o.idx;
			icon.info.type = o.type;
			icon.info.position = o.position;
			icon.info.inside = o.inside;
			icon.info.templateId = o.openid;
			icon.info.level = o.level;
			icon.info.curPage = index;
			
			
			var tempInfo:SkillTemplateInfo = GlobalData.skillTemplateList.getTemplate(icon.info.templateId,icon.info.level);
			
			//icon.info.expired = "附加描述";
			
			icon.initBagCell();
		}
		/**
		 * 
		 * @param	value 是否显示按钮
		 */
		private function updateButtonState(value:int):void {
			_mc.btn_unEquip.visible = value;
		}
		private function initEvent():void {
			_mc.btn_unEquip.addEventListener(MouseEvent.CLICK,unEquipHandler);
		}
		private function unEquipHandler(e:MouseEvent):void {
			GlobalData.skillInfo.stripSkill(icon.info.itemId);
			GlobalData.skillInfo.getSkillList(icon.info.curPage);
		}
		public function removeMC():void {
			_mc.btn_unEquip.removeEventListener(MouseEvent.CLICK, unEquipHandler);
			icon.removeEvent();
			_mc = null;
			icon = null;
		}
		
	}

}