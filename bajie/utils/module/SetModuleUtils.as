package bajie.utils.module
{
	import bajie.constData.CommonConfig;
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.fight.regard.vo.RankVO;
	import bajie.core.data.module.ModuleInfo;
	import bajie.core.data.module.ModuleList;
	import bajie.core.data.module.changeInfos.ToSceneData;
	import bajie.events.BajieDispatcher;
	import bajie.events.ParamEvent;
	import bajie.interfaces.loader.ILoader;
	import bajie.ui.Bag;
	import bajie.ui.BottomMenu;
	import bajie.ui.ChatPanel;
	import bajie.ui.Classic;
	import bajie.ui.Fight;
	import bajie.ui.Hall;
	import bajie.ui.ModuleLoading;
	import bajie.ui.Register;
	import bajie.ui.Room;
	import bajie.ui.UserSetPanel;
	import bajie.ui.email.Email;
	import bajie.ui.fight.regard.Regard;
	import bajie.ui.friends.Friends;
	import bajie.ui.shop.Shop;
	import bajie.ui.sign.Sign;
	import bajie.ui.skill.Skill;
	import bajie.ui.strengthen.Strengthen;
	import bajie.ui.task.Task;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.utils.Dictionary;

	public class SetModuleUtils
	{
		private var bg:Sprite;
		private static var _backGround:Sprite = null;//附加一个背景，用来加深背景色
		private static var _hasBackGround:Boolean = false;//标记是否有附加背景
		private static var _hasParent:Boolean = false;//是否有父容器
		private static var _moduleDic:Dictionary = new Dictionary;//模块字典
		private static var _subModuleDic:Dictionary = new Dictionary;//sp子模块字典
		private static var _loading:ModuleLoading = new ModuleLoading;
		private static var _moduleList:ModuleList = ModuleList.getInstance();
		
		public function SetModuleUtils()
		{
			// constructor code
			_moduleDic["sp"] = _subModuleDic;
		}
		
		public static function setBackGround(b:Boolean):void
		{
			_hasBackGround = b;
		}

		public static function setToScene():void
		{
			//GlobalAPI.moduleManager.setModule(ModuleType.SCENE, null, toScene, [GlobalAPI.pathManager.getModulePath(ModuleType.SCENE)], null, false);
		}

		public static function setModuleTop(mc:DisplayObject):void
		{
			GlobalAPI.layerManager.getModuleLayer().setChildIndex(mc, GlobalAPI.layerManager.getModuleLayer().numChildren-1);
		}

		/**
		 *前后端模块名称对应方法 
		 * @param s 后端名称
		 * @return 
		 * 
		 */
		public static function getModuleName(s:String):String
		{
			switch (s)
			{
				case "mall" :
					return "shop";
					break;
				case "celebrity" :
					return "celebrity";
					break;
				case "sports" :
					return "hall";
					break;
				case "" :
					break;
			}
			return "";
		}
		
		/**
		 传入类名 得到对应格子类
		 */
		public static function moduleFactory(na:int):Class
		{
			switch(na)
			{
				case ModuleType.ACTIVITY:
					break;
				case ModuleType.BAG:
					return Bag;
				case ModuleType.CHAT:
					return ChatPanel;
				case ModuleType.FIGHT:
					return Fight;
				case ModuleType.FRIENDS:
					return Friends;
				case ModuleType.HALL:
					return Hall;
				case ModuleType.MAIL:
					return Email;
				case ModuleType.NAVIGATION:
					return BottomMenu
				case ModuleType.RANK:
					break;
				case ModuleType.REGARD:
					return Regard;
				case ModuleType.REGISTER:
					return Register;
				case ModuleType.ROOM:
					return Room;
				case ModuleType.SETTING:
					return UserSetPanel;
				case ModuleType.SIGN:
					return Sign;
				case ModuleType.SKILL:
					return Skill;
				case ModuleType.STORE:
					return Shop;
				case ModuleType.STRENGTHEN:
					return Strengthen;
				case ModuleType.TASK:
					return Task;
			}
			return null;
		}
		
		/**
		 *添加loading条 
		 * 
		 */		
		public static function addLoading():void
		{
			addModule(_loading, null, false, false, ModuleType.LOADING);
			setModuleTop(_loading);
		}
		
		/**
		 *移出loading条 
		 * 
		 */		
		public static function removeLoading():void
		{
			removeModuleByName("loading", null, false, ModuleType.LOADING);
		}
		
		/**
		 *添加新资源模块 
		 * @param moduName模块类型
		 * @param fun 资源加载到以后的回调方法
		 * 
		 */		
		public static function addMod(moduName:int, fun:Function):void
		{
			_loading.name = "loading";
			BajieDispatcher.getInstance().addEventListener("LOADING", loadProgressHandler);
			addLoading();
			GlobalAPI.loaderAPI.loadSwf(GlobalAPI.pathManager.getModulePath(moduName), _loaderReady, 0);
			function _loaderReady(loader:ILoader):void
			{
				BajieDispatcher.getInstance().removeEventListener("LOADING", loadProgressHandler);
				var cl:Class =  moduleFactory(moduName);
				fun(cl);
			}
		}
		
		private static function loadProgressHandler(e:ParamEvent):void
		{
			var o:Object = e.Param;
			_loading.setCurframe(Math.floor(o.bytesLoaded / o.bytesTotal * 100));
		}

		/**
		 *添加模块到舞台 
		 * @param mc 要添加的mc
		 * @param parentMC 父mc
		 * @param modal 是否为模态
		 * @param giveXY 是否指定坐标 
		 * @param mcType 模块类型
		 */
		public static function addModule(mc:MovieClip, parentMC:MovieClip = null, modal:Boolean = false, giveXY:Boolean = false, mcType:int = 0):void
		{
			if(_moduleDic[mcType] == null)
			{
				var info:ModuleInfo = new ModuleInfo(mcType, modal);
				_moduleDic[mcType] = info;
			}
			
			
			if (modal)
			{
				if(_hasBackGround == true)
				{
					setModuleTop(_backGround);
				}
				else
				{
					_backGround = new Sprite  ;
					_backGround.graphics.beginFill(2061, 0.2);
					_backGround.graphics.drawRect(0, 0, CommonConfig.GAME_WIDTH, CommonConfig.GAME_HEIGHT);
					_backGround.graphics.endFill();
					_backGround.x = GlobalAPI.sp.x;
					_backGround.y = GlobalAPI.sp.y;
					GlobalAPI.layerManager.getModuleLayer().addChild(_backGround);
					_hasBackGround = true;
				}
			}

			if (parentMC != null && giveXY == false)
			{
				mc.x = (parentMC.width - mc.width)/2;
				mc.y = (parentMC.height - mc.height)/2;
				parentMC.addChild(mc);
				_hasParent = true;
			}
			else
			{
				if (parentMC != null && giveXY == true)
				{
					parentMC.addChild(mc);
					_hasParent = true;
				}
				else if (giveXY == true)
				{
					GlobalAPI.layerManager.getModuleLayer().addChild(mc);
				}
				else
				{
					GlobalAPI.layerManager.setCenter(mc);
					GlobalAPI.layerManager.getModuleLayer().addChild(mc);
					//setModuleTop(mc);
				}
				try
				{
					setModuleTop(_loading);
				}
				catch(e:Error)
				{
					
				}
				
			}
			//setModuleTop(GlobalAPI.layerManager.getModuleLayer().getChildByName("loading"));
		}

		/**
		根据名字移出mc
		 * @param s 影片剪辑名称
		 * @param pmc 父容器
		 * @param model 是否有模态
		 * @param mcType 模块类型
		*/
		public static function removeModuleByName(s:String, pmc:MovieClip = null, model:Boolean = false, mcType:int = 0):void
		{
			try
			{
				if(_moduleDic[mcType] != null)
				{
					var moduleInfo:ModuleInfo = _moduleDic[mcType]//_moduleList.getInfo(mcType);
					
					if (pmc == null)
					{
						GlobalAPI.layerManager.getModuleLayer().removeChild(GlobalAPI.layerManager.getModuleLayer().getChildByName(s));
					}
					else
					{
						pmc.removeChild(pmc.getChildByName(s));
					}
					
					if (moduleInfo.hasModel == true)
					{
						if (_hasBackGround)
						{
							//GlobalAPI.layerManager.getModuleLayer().removeChild(_backGround);
							GlobalAPI.layerManager.getModuleLayer().setChildIndex(_backGround, 0);
							_hasBackGround = false;
						}
						if(_hasBackGround == false)
						{
							
						}
					}
					_moduleDic[mcType] = null;
					//_moduleList.setInfoAsNull(moduleInfo);
				}
				
			}
			catch (e:Error)
			{

			}
			finally
			{

			}

			

		}

		/**
		 *从舞台移出mc 
		 * @param mc要移出的mc
		 * @param mcType 模块类型
		 */
		public static function removeModule(mc:MovieClip, mcType:int = 0):void
		{
			if (mc != null)
			{
				if(_moduleDic[mcType] != null)
				{
					var moduleInfo:ModuleInfo = _moduleDic[mcType];//_moduleList.getInfo(mcType);
					
					try
					{
						GlobalAPI.layerManager.getModuleLayer().removeChild(mc);
					}
					catch (e:Error)
					{
						mc.parent.removeChild(mc);
					}
					finally
					{
						mc = null;
					}
					
					if (moduleInfo.hasModel == true)
					{
						if (_hasBackGround)
						{
							GlobalAPI.layerManager.getModuleLayer().setChildIndex(_backGround, 0);
					
							_hasBackGround = false;
						}
					}
					_moduleDic[mcType] = null;
					//_moduleList.setInfoAsNull(moduleInfo);
				}
			}
		}

		public static function getInstanceModule(mc:MovieClip):void
		{

		}





	}
}