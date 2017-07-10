package bajie.ui 
{
	import bajie.ui.friends.Friends;
	import bajie.ui.skill.Skill;
	import bajie.ui.task.Task;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import bajie.utils.module.SetModuleUtils;
	import bajie.ui.UserSetPanel;
	import bajie.core.data.GlobalData;
	import bajie.core.data.GlobalAPI;
	import bajie.constData.ModuleType;
	import bajie.interfaces.loader.ILoader;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class BottomMenu extends MovieClip 
	{
		private static var _menu:BottomMenu;
		private var _friends:Friends;
		public function BottomMenu() 
		{
			initMC();
			initEvent();
		}
		public static function getInstance():BottomMenu {
			if (_menu == null)_menu = new BottomMenu();
			return _menu;
		}
		private function initMC():void {
			this.x = 495;
			this.y = 519;
		}
		public function initEvent():void
		{
			taskBtn.addEventListener(MouseEvent.CLICK, taskBtnHandler);
			bagBtn.addEventListener(MouseEvent.CLICK, bagBtnHandler);
			skillBtn.addEventListener(MouseEvent.CLICK, skillBtnHandler);
			friendBtn.addEventListener(MouseEvent.CLICK, friendBtnHandler);
			setBtn.addEventListener(MouseEvent.CLICK, setBtnHandler);
		}
		private function taskBtnHandler(e:MouseEvent):void
		{
			SetModuleUtils.addMod(ModuleType.TASK, funTaskHandler);
		}
		
		private function funTaskHandler(cl:Class):void
		{
			var task:Task = new cl() as Task;
			SetModuleUtils.addModule(task, null, true, false, ModuleType.TASK);
		}
		
		private function bagBtnHandler(e:MouseEvent):void
		{
			SetModuleUtils.addMod(ModuleType.BAG, funBaghandler);
		}
		
		private function funBaghandler(cl:Class):void
		{
			var bag:Bag = new cl() as Bag;
			bag.initEvent();
			SetModuleUtils.addModule(bag, null, true, false, ModuleType.BAG);
			GlobalData.bagInfo.openBag();
		}
		
		private function skillBtnHandler(e:MouseEvent):void
		{
			SetModuleUtils.addMod(ModuleType.SKILL, funSkillHandler);
		}
		private function funSkillHandler(cl:Class):void {
			var _skill:Skill = new Skill();
			SetModuleUtils.addModule(_skill, null, true, false, ModuleType.SKILL);
		}
		
		private function friendBtnHandler(e:MouseEvent):void
		{
			if (_friends == null) SetModuleUtils.addMod(ModuleType.FRIENDS, funFriendHandler);
			else {
				_friends.setVisible();
			}
		}
		private function funFriendHandler(cl:Class):void {
			_friends = new Friends();
			_friends.x = 970;
			_friends.y = 48;
			SetModuleUtils.addModule(_friends, null, false, true, ModuleType.FRIENDS);
			_friends.setVisible();
		}
		
		private function setBtnHandler(e:MouseEvent):void
		{
			SetModuleUtils.addMod(ModuleType.SETTING, funSetHandler);
		}
		private function funSetHandler(cl:Class):void {
			var _userSet:UserSetPanel = new UserSetPanel();
			SetModuleUtils.addModule(_userSet, null, true, false, ModuleType.SETTING);
		}
	}

}