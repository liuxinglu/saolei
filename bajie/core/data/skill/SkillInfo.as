package bajie.core.data.skill {
	import bajie.core.data.GlobalData;
	import bajie.core.data.socketHandler.skill.*;
	import bajie.events.ParamEvent;
	
	import flash.events.EventDispatcher;
	
	public class SkillInfo extends EventDispatcher{

		public function SkillInfo() {
			// constructor code
		}

		/**
		 * 获取技能列表信息
		 */ 
		public function getSkillList(index:int):void {
			GetSkillListSocketHandler.send(GlobalData.playerid, index);
		}
		/**
		 * 显示技能列表信息
		 */ 
		public function showSkillList(o:Object):void {
			this.dispatchEvent(new ParamEvent(ParamEvent.GET_SKILL_LIST, o));
		}
		/**
		 * 获取已装备技能信息
		 */ 
		public function getEquipSkill():void {
			AssemblySkillListSocketHandler.send(GlobalData.playerid);
		}
		/**
		 * 更新已装备技能信息
		 */ 
		public function updateEquipSkill(o:Object):void {
			this.dispatchEvent(new ParamEvent(ParamEvent.GET_EQUIP_SKILL, o));
		}
		/**
		 * 升级技能
		 */ 
		public function upgradeSkill(ID:int):void {
			
		}
		/**
		 * 装备技能
		 * @param	ID
		 */
		public function equipSkill(idx:Number):void {
			CarrayRolesSkillSocketHandler.send(GlobalData.playerid,idx);
		}
		/**
		 * 卸载技能
		 * @param	ID
		 */
		public function stripSkill(idx:Number):void {
			StripRolesSkillSocketHandler.send(GlobalData.playerid,idx);
		}
	}
	
}
