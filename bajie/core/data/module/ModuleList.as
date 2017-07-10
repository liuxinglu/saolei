package bajie.core.data.module
{
	import bajie.constData.ModuleType;
	//import bajie.core.manager.LanguageManager;
	
	import flash.utils.Dictionary;
	import bajie.manager.language.LanguageManager;
	
	public class ModuleList
	{
		private static var _moduleList:ModuleList;
		private static var _list:Dictionary = new Dictionary;
		
		public static function getInstance():ModuleList
		{
			if(_moduleList == null)
			{
				_moduleList = new ModuleList;
			}
			return _moduleList;
		}
		public function addInfo(info:ModuleInfo):void
		{
			_list[info.moduleId] = info;
		}
		
		public static function setup():void
		{
			//addInfo(new ModuleInfo(ModuleType.SERVERLIST,LanguageManager.getWord("moduleName.serverList")));
			//addInfo(new ModuleInfo(ModuleType.SCENE,LanguageManager.getWord("moduleName.scene")));
//			addInfo(new ModuleInfo(ModuleType.NAVIGATION,LanguageManager.getWord("moduleName.navigation")));
			//addInfo(new ModuleInfo(ModuleType.BAG,LanguageManager.getWord("moduleName.bag")));
			//addInfo(new ModuleInfo(ModuleType.STALL,LanguageManager.getWord("moduleName.stall")));
			//addInfo(new ModuleInfo(ModuleType.STORE,LanguageManager.getWord("moduleName.store")));
//			addInfo(new ModuleInfo(ModuleType.ROLECHOISE,LanguageManager.getWord("moduleName.roleChoise")));
			//addInfo(new ModuleInfo(ModuleType.ROLE,LanguageManager.getWord("moduleName.role")));
			//addInfo(new ModuleInfo(ModuleType.TASK,LanguageManager.getWord("moduleName.task")));
			//addInfo(new ModuleInfo(ModuleType.CONSIGN,LanguageManager.getWord("moduleName.consign")));
			//addInfo(new ModuleInfo(ModuleType.CHAT,LanguageManager.getWord("moduleName.chat")));
			//addInfo(new ModuleInfo(ModuleType.SETTING,LanguageManager.getWord("moduleName.setting")));
			//addInfo(new ModuleInfo(ModuleType.SKILL,LanguageManager.getWord("moduleName.skill")));
			//addInfo(new ModuleInfo(ModuleType.FURNACE,LanguageManager.getWord("moduleName.furnace")));
			//addInfo(new ModuleInfo(ModuleType.CLUB,LanguageManager.getWord("moduleName.club")));
			//addInfo(new ModuleInfo(ModuleType.MAIL,LanguageManager.getWord("moduleName.mail")));
			//addInfo(new ModuleInfo(ModuleType.FRIENDS,LanguageManager.getWord("moduleName.friends")));
			//addInfo(new ModuleInfo(ModuleType.ACTIVITY,LanguageManager.getWord("moduleName.activity")));
			//addInfo(new ModuleInfo(ModuleType.TEAM, LanguageManager.getWord("moduleName.team")));

			//addInfo(new ModuleInfo(ModuleType.RANK,LanguageManager.getWord("moduleName.rank")));

			//addInfo(new ModuleInfo(ModuleType.VIP,LanguageManager.getWord("moduleName.Vip")));
		}
		
		
		
		public function getInfo(infoType:int):ModuleInfo
		{
			return _list[infoType];
		}
		
		public function setInfoAsNull(info:ModuleInfo):void
		{
			_list[info.moduleId] = null;
		}
	}

}