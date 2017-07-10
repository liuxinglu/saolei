package bajie.ui.skill 
{
	import bajie.core.data.bag.BagItemInfo;
	import bajie.core.data.bag.ItemTeampleInfo;
	import bajie.core.data.skill.SkillTemplateInfo;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import fl.motion.ColorMatrix;
	import flash.filters.ColorMatrixFilter;
	import bajie.utils.module.SetModuleUtils;
	import bajie.constData.SourceClearType;
	import bajie.ui.skill.*;
	import bajie.constData.ModuleType;
	/**
	 * ...
	 * @author azjune
	 */
	public class SkillList extends MovieClip 
	{
		private var _mc:*;
		public var icon:SkillItem;
		private var filter:ColorMatrixFilter;
		public function SkillList()
		{
			_mc = GlobalAPI.loaderAPI.getObjectByClassPath("skillList");
			addChild(_mc);
			icon = new SkillItem();
			addChild(icon);
			initEvent();
			initFilter();
		}
		private function initFilter():void {
			var colorMatrix:ColorMatrix = new ColorMatrix();
			colorMatrix.SetSaturationMatrix(0);
			filter = new ColorMatrixFilter(colorMatrix.GetFlatArray());
		}
		public function setSkillType(o:Object,index:int):void {
			//{\\\"idx\\\":1,\\\"type\\\":6,\\\"position\\\":1,\\\"inside\\\":0,\\\"openid\\\":550001,\\\"level\\\":1,\\\"learn\\\":1}
			icon.info = new BagItemInfo();
			if (o.learn == 1) {
				setButtonNon(true);
			}else {
				setButtonNon(false);
			}
			icon.info.itemId = o.idx;
			icon.info.type = o.type;
			icon.info.position = o.position;
			icon.info.inside = o.inside;
			icon.info.templateId = o.openid;
			icon.info.level = o.level;
			icon.info.curPage = index;
			
			_mc.skillName.text = icon.info.template.name;
			var tmpstr:String = icon.info.level > 9?"lv":"lv ";
			_mc.level.text = tmpstr+icon.info.level;
			
			var tempInfo:SkillTemplateInfo = GlobalData.skillTemplateList.getTemplate(icon.info.templateId,icon.info.level);
			
			//icon.info.expired = "附加描述";
			
			if (icon.info.inside>0) {
				updateButtonState(2);
			}else {
				updateButtonState(1);
			}
			icon.initBagCell();
		}
		/**
		 * 
		 * @param	value 1显示装备按钮 2显示卸下按钮
		 */
		private function updateButtonState(value:int):void {
			if (value == 1) {
				_mc.btn_equip.visible = true;
				_mc.btn_unEquip.visible = false;
			}else if (value == 2){
				_mc.btn_equip.visible = false;
				_mc.btn_unEquip.visible = true;
			}
		}
		private function setButtonNon(value:Boolean):void {
			_mc.btn_upgrade.mouseEnabled = value;
			_mc.btn_equip.mouseEnabled = value;
			_mc.btn_unEquip.mouseEnabled = value;
			if (value) {
				_mc.btn_upgrade.gotoAndStop("_up");
				_mc.btn_equip.gotoAndStop("_up");
				_mc.btn_unEquip.gotoAndStop("_up");
				icon.filters = null;
			}else {
				_mc.btn_upgrade.gotoAndStop("non");
				_mc.btn_equip.gotoAndStop("non");
				_mc.btn_unEquip.gotoAndStop("non");
				icon.filters = [filter];
			}
		}
		private function initEvent():void {
			_mc.btn_upgrade.addEventListener(MouseEvent.CLICK, upgradeHandler);
			_mc.btn_unEquip.addEventListener(MouseEvent.CLICK, unEquipHandler);
			_mc.btn_equip.addEventListener(MouseEvent.CLICK, equipHandler);
		}
		/**
		 * 打开升级面板
		 * @param	e
		 */
		private function upgradeHandler(e:MouseEvent):void {
			var upgradePan:SkillUpgrade = new SkillUpgrade(icon.info);
			SetModuleUtils.addModule(upgradePan, null, true,false,ModuleType.UPDATE_SKILL);
		}
		private function unEquipHandler(e:MouseEvent):void {
			GlobalData.skillInfo.stripSkill(icon.info.itemId);
			GlobalData.skillInfo.getSkillList(icon.info.curPage);
		}
		private function equipHandler(e:MouseEvent):void {
			GlobalData.skillInfo.equipSkill(icon.info.itemId);
			GlobalData.skillInfo.getSkillList(icon.info.curPage);
		}
		/**
		 * 移除此组件
		 */ 
		public function removeMC():void {
			_mc.btn_upgrade.removeEventListener(MouseEvent.CLICK, upgradeHandler);
			_mc.btn_unEquip.removeEventListener(MouseEvent.CLICK, unEquipHandler);
			_mc.btn_equip.removeEventListener(MouseEvent.CLICK, equipHandler);
			icon = null;
			_mc = null;
		}
	}

}