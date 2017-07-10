package bajie.ui.skill
{
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.events.ParamEvent;
	import bajie.ui.skill.SkillList;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * 技能界面
	 * @author azjune
	 */
	public class Skill extends MovieClip
	{
		private var ui:*;
		private var skillList:Array = new Array();
		private var equipList:Array = new Array();
		private var equipNumber:int = 4;
		private var perNumber:int = 8;
		private var pageIndex:int = 1;
		
		public function Skill()
		{
			ui = GlobalAPI.loaderAPI.getObjectByClassPath("skillPan");
			
			addChild(ui);
			//GlobalData.emailInfo.getEmailList(_index, _type);
			initMCState();
			initEvent();
			updateBtnState(1);
			GlobalData.skillInfo.getSkillList(1);
		}
		
		private function initMCState():void
		{
			ui.btn_close.buttonMode = true;
			for (var i:int = 0; i < perNumber; i++)
			{
				var skillMC:SkillList = new SkillList();
				ui["list_"+(i+1)].addChild(skillMC);
				skillList.push(skillMC);
			}
			for (var j:int = 0; j < equipNumber; j++)
			{
				var equipMC:EquipSkillList = new EquipSkillList();
				ui["equipSkill_"+(j+1)].addChild(equipMC);
				equipList.push(equipMC);
			}
		}
		
		private function initEvent():void
		{
			GlobalData.skillInfo.addEventListener(ParamEvent.GET_SKILL_LIST, updateSkillList, false, 0, true);
			GlobalData.skillInfo.addEventListener(ParamEvent.GET_EQUIP_SKILL, updateEquip, false, 0, true);
			ui.btn_close.addEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_page1.addEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_page2.addEventListener(MouseEvent.CLICK, buttonHandler);
		}
		
		private function buttonHandler(e:MouseEvent):void
		{
			switch (e.currentTarget.name)
			{
				case "btn_close": 
					removeMC();
					break;
				case "btn_page1": 
					updateBtnState(1);
					GlobalData.skillInfo.getSkillList(1);
					//SetModuleUtils.addLoading();//添加loading
					break;
				case "btn_page2": 
					updateBtnState(2);
					GlobalData.skillInfo.getSkillList(2);
					//SetModuleUtils.addLoading();//添加loading
					break;
				default: 
					break;
			}
		}
		
		private function removeMC():void
		{
			GlobalData.skillInfo.removeEventListener(ParamEvent.GET_SKILL_LIST, updateSkillList);
			GlobalData.skillInfo.removeEventListener(ParamEvent.GET_EQUIP_SKILL, updateEquip);
			ui.btn_close.removeEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_page1.removeEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_page2.removeEventListener(MouseEvent.CLICK, buttonHandler);
			
			for (var i:int = 0; i < perNumber; i++)
			{
				skillList[i].removeMC();
			}
			for (var j:int = 0; j < equipNumber; j++)
			{
				equipList[j].removeMC();
			}
			
			skillList = null;
			equipList = null;
			ui = null;
			SetModuleUtils.removeModule(this, ModuleType.SKILL);
		}
		
		/**
		 * 更新技能列表信息
		 */
		private function updateSkillList(e:ParamEvent):void
		{
			SetModuleUtils.removeLoading();
			if (e.Param)
			{
				var o:Object = e.Param;
				var list:Array = (o.items) as Array;
				pageIndex = o.index;
				
				for (var j:int = 0; j < perNumber; j++)
				{
					SkillList(skillList[j]).visible = false;
				}
				
				var len:int = list.length;
				for (var i:int = 0; i < len; i++)
				{
					SkillList(skillList[list[i].position - 1]).visible = true;
					SkillList(skillList[list[i].position-1]).setSkillType(list[i],pageIndex);
				}
			}
		
		}
		/**
		 * 更新已装备技能列表信息
		 */
		private function updateEquip(e:ParamEvent):void
		{
			if (e.Param)
			{
				var list:Array = e.Param.items as Array;
				
				for (var j:int = 0; j < equipNumber; j++)
				{
					EquipSkillList(equipList[j]).visible = false;
				}
				
				var len:int = list.length;
				for (var i:int = 0; i < len; i++)
				{
					EquipSkillList(equipList[list[i].inside-1]).visible = true;
					EquipSkillList(equipList[list[i].inside-1]).setEquipType(list[i],pageIndex);
				}
			}
		
		}
		private function updateBtnState(value:int):void {
			if (value == 1) {
				ui.btn_page1.buttonMode = false;
				ui.btn_page1.gotoAndStop("onclick");
				ui.btn_page2.buttonMode = true;
				ui.btn_page2.gotoAndStop("_up");
			}else if (value == 2){
				ui.btn_page1.buttonMode = true;
				ui.btn_page1.gotoAndStop("_up");
				ui.btn_page2.buttonMode = false;
				ui.btn_page2.gotoAndStop("onclick");
			}
		}
	}

}