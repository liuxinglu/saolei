package bajie.ui {
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
	
	public class TopPanel extends MovieClip 
	{
		private static var _topPanel:TopPanel;

		private var bag:Bag;
		private var _userSet:UserSetPanel;
		
		public function TopPanel() {
			// constructor code
			initEvent();
		}
		
		public static function getInstance():TopPanel
		{
			if(_topPanel == null)
			{
				_topPanel = new TopPanel();
			}
			
			return _topPanel;
		}
		
		public function initEvent():void
		{
			sendBtn.addEventListener(MouseEvent.CLICK, sendHandler);
			taskBtn.addEventListener(MouseEvent.CLICK, taskBtnHandler);
			bagBtn.addEventListener(MouseEvent.CLICK, bagBtnHandler);
			skillBtn.addEventListener(MouseEvent.CLICK, skillBtnHandler);
			friendBtn.addEventListener(MouseEvent.CLICK, friendBtnHandler);
			setBtn.addEventListener(MouseEvent.CLICK, setBtnHandler);
		}
		
		private function sendHandler(e:MouseEvent):void
		{
			GlobalData.topPanelInfo.delMessage();
		}
		
		private function taskBtnHandler(e:MouseEvent):void
		{
			GlobalAPI.loaderAPI.loadSwf(GlobalAPI.pathManager.getModulePath(ModuleType.TASK), _loaderReady, 0);
			function _loaderReady(loader:ILoader):void
			{
				var task:Task = new Task();
				SetModuleUtils.addModule(task, null, true, false, ModuleType.TASK);
			}
		}
		
		private function bagBtnHandler(e:MouseEvent):void
		{
			GlobalAPI.loaderAPI.loadSwf(GlobalAPI.pathManager.getModulePath(ModuleType.BAG), _loaderReady, 0);
			function _loaderReady(loader:ILoader):void
			{
				bag = new Bag();
				bag.initEvent();
				SetModuleUtils.addModule(bag, null, false, ModuleType.BAG);
				GlobalData.bagInfo.openBag();
			}
			
		}
		
		private function skillBtnHandler(e:MouseEvent):void
		{
			GlobalAPI.loaderAPI.loadSwf(GlobalAPI.pathManager.getModulePath(ModuleType.SKILL), _loaderReady, 0);
			function _loaderReady(loader:ILoader):void
			{
				var _skill:Skill = new Skill();
				SetModuleUtils.addModule(_skill, null, true, false, ModuleType.SKILL);
			}
		}
		
		private function friendBtnHandler(e:MouseEvent):void
		{
			GlobalAPI.loaderAPI.loadSwf(GlobalAPI.pathManager.getModulePath(ModuleType.FRIENDS), _loaderReady, 0);
			function _loaderReady(loader:ILoader):void
			{
				var _friends:Friends = new Friends();
				SetModuleUtils.addModule(_friends, null, false, false, ModuleType.FRIENDS);
			}
		}
		
		private function setBtnHandler(e:MouseEvent):void
		{
			GlobalAPI.loaderAPI.loadSwf(GlobalAPI.pathManager.getModulePath(ModuleType.SETTING), _loaderReady, 0);
			function _loaderReady(loader:ILoader):void
			{
				var _userSet:UserSetPanel = new UserSetPanel();
				SetModuleUtils.addModule(_userSet, null, true, false, ModuleType.SETTING);
			}
		}
	}
	
}
