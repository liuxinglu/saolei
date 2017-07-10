package bajie.ui.skill 
{
	import bajie.constData.ModuleType;
	import bajie.constData.SourceClearType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.core.data.skill.SkillTemplateInfo;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * ...
	 * @author azjune
	 */
	public class SkillUpgrade extends MovieClip 
	{
		private var ui:*;
		public var icon:SkillItem;
		private var icon_2:SkillItem;
		
		public function SkillUpgrade(tmpinfo:BagItemInfo) 
		{
			ui = GlobalAPI.loaderAPI.getObjectByClassPath("skillUpgrade");
			addChild(ui);
			initEvent();
			setIcon(tmpinfo);
		}
		private function initMC():void {
			var curLevelInfo:SkillTemplateInfo = GlobalData.skillTemplateList.getTemplate(icon.info.templateId, icon.info.level);
			var nextLevelInfo:SkillTemplateInfo = GlobalData.skillTemplateList.getTemplate(icon_2.info.templateId, icon_2.info.level);
			
			ui.skillName_1.text = icon.info.template.name;
			ui.skillName_2.text = icon_2.info.template.name;
			ui.skillLevel_1.text = "lv "+icon.info.level;
			ui.skillLevel_2.text =	"lv "+icon_2.info.level;
			ui.useType_1.text = getUseType(curLevelInfo);
			ui.useType_2.text = getUseType(nextLevelInfo);
			ui.skillExplain_1.text = icon.info.template.description;
			ui.skillExplain_2.text = icon_2.info.template.description;
			ui.useMoney.text = nextLevelInfo.silver;
			
			ui.btn_submit.buttonMode = true;
			ui.btn_cancel.buttonMode = true;
			ui.btn_submit.btnTxt.gotoAndStop(1);
			ui.btn_cancel.btnTxt.gotoAndStop(2);
		}
		private function setIcon(tmpInfo:BagItemInfo):void {
			icon = new SkillItem();
			ui.item_1.addChild(icon);
			icon_2 = new SkillItem();
			ui.item_2.addChild(icon_2);
			
			icon.info = tmpInfo;
			icon_2.info = tmpInfo;
			icon_2.info.level == tmpInfo.level+1;
			
			icon.initBagCell();
			icon_2.initBagCell();
			
			initMC();
		}
		private function initEvent():void {
			ui.btn_submit.addEventListener(MouseEvent.CLICK, upgradeSkill);
			ui.btn_cancel.addEventListener(MouseEvent.CLICK, removeMC);
		}
		private function upgradeSkill(e:MouseEvent):void {
			GlobalData.skillInfo.upgradeSkill(icon.info.templateId);
			GlobalData.skillInfo.getSkillList(icon.info.curPage);
			removeMC();
		}
		private function removeMC(e:MouseEvent = null):void {
			ui.btn_submit.removeEventListener(MouseEvent.CLICK, upgradeSkill);
			ui.btn_cancel.removeEventListener(MouseEvent.CLICK, removeMC);
			icon = null;
			icon_2 = null;
			ui = null;
			SetModuleUtils.removeModule(this, ModuleType.UPDATE_SKILL);
		}
		private function getUseType(info:SkillTemplateInfo):String {
			if (info.type == "1") {
				return "主动";
			}else if(info.type == "2"){
				return "被动";
			}else {
				return "";
			}
			
		}
	}

}