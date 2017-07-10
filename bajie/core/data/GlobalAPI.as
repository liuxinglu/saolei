package bajie.core.data
{
	import bajie.Declear;
	import bajie.core.data.socket.SocketInfo;
	import bajie.core.data.socketHandler.SetSocketHandler;
	import bajie.core.data.socketHandler.TestSocketHandler;
	import bajie.core.data.socketHandler.login.LoginEnterGameSocketHandler;
	import bajie.core.proxy.LoginSocketProxy;
	import bajie.events.BajieDispatcher;
	import bajie.events.ParamEvent;
	import bajie.events.SocketEvent;
	import bajie.interfaces.decode.IDecode;
	import bajie.interfaces.keyboard.IKeyboardApi;
	import bajie.interfaces.layer.ILayerManager;
	import bajie.interfaces.loader.ICacheApi;
	import bajie.interfaces.loader.ILoaderApi;
	import bajie.interfaces.loader.IWaitLoading;
	import bajie.interfaces.module.IModuleManager;
	import bajie.interfaces.moviewrapper.IMovieManager;
	import bajie.interfaces.socket.ISocketManager;
	import bajie.interfaces.tick.ITickManager;
	import bajie.manager.layer.LayerManager;
	import bajie.manager.path.PathManager;
	import bajie.manager.socket.SocketManager;
	import bajie.manager.tick.ToolTipManager;
	import bajie.ui.*;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.Security;
	import bajie.manager.menu.MenuManager;
	import bajie.manager.drag.GlobalDragManager;
	import bajie.constData.ModuleType;
	import bajie.interfaces.loader.ILoader;
	import flash.net.URLVariables;
	import bajie.events.AlertEvent;

	public class GlobalAPI
	{
		public static var sp:Sprite;
		public static var main:Main;
		public static var register:Register;
		
		/**
		socket通讯包
		*/
		public static var socketManager:ISocketManager;
		/**
		层管理
		*/
		public static var layerManager:ILayerManager;
		/**
		模块管理
		*/
		public static var moduleManager:IModuleManager;
		
		/**
		路径管理
		*/
		public static var pathManager:PathManager;
		
		/**
		菜单管理
		*/
		public static var menuManager:MenuManager;
		

		public static var loaderAPI:ILoaderApi;
		/**
		动画包装
		*/
		public static var movieManagerApi:IMovieManager;
		/**
		缓存管理
		*/
		public static var cacheManager:ICacheApi;
		/**
		帧循环器
		*/
		public static var tickManager:ITickManager;
		/**
		键盘事件api
		*/
		public static var keyboardManager:IKeyboardApi;
		
		public static var waitingLoading:IWaitLoading;
		public static function initWaitingApi(value:IWaitLoading):void
		{
			waitingLoading = value;
		}

		/**
		解码
		*/
		public static var decoder:IDecode;

		public static var useCache:Boolean;
		public static var sitePath:String;
		public static var requestPath:String;
		public static var configData:XML;//主配置文件
		private static var itemConfigData:XMLList;//物品配置文件
		private static var skillConfigData:XMLList;//技能配置文件
		private static var fashionConfigData:XMLList;//时装配置文件
		private static var taskConfigData:XMLList;//任务配置文件
		
		public static function preSetUp():void
		{
			GlobalData.systemDate = new SystemDateInfo();
			GlobalData.tmpIP = String(configData.config.ip.@value);
			GlobalData.tmpPort = int(configData.config.port.@value);
			if(int(configData.config.debug.@value) == 1)
			{
				GlobalData.tmpUserName = String(configData.config.loginName.@value);
				GlobalData.tmpPassword = String(configData.config.loginPwd.@value);
			}
			
			useCache = String(configData.config.CACHELOCAL.@value) == "true";
			sitePath = String(configData.config.SITE.@value);
			requestPath = String(configData.config.WEBSERVICE_PATH.@value);
			pathManager = new PathManager(configData);
			layerManager = new LayerManager(sp);
			
		}
		
		public static function setup():void
		{
			GlobalDragManager.init(sp.stage);
			GlobalDragManager.getInstance();
			
			if(GlobalData.domain.hasDefinition("bajie.manager.module.ModuleManager"))
			{
				var moduleC:Class = GlobalData.domain.getDefinition("bajie.manager.module.ModuleManager") as Class;
				moduleManager = new moduleC() as IModuleManager;
				moduleManager.setup(layerManager, pathManager, loaderAPI, waitingLoading);
			}
			if (GlobalData.domain.hasDefinition("bajie.manager.socket.SocketManager"))
			{
				var socketCl:Class = GlobalData.domain.getDefinition("bajie.manager.socket.SocketManager") as Class;
				socketManager = new socketCl() as ISocketManager;
				//第一次登陆连接
				socketManager.addEventListener(SocketEvent.SOCKET_CLOSE,socketCloseHandler);
				socketManager.addEventListener(SocketEvent.CONNECT_FAIL,socketConnectFailHandler);
				socketManager.addEventListener(SocketEvent.CONNECT_SUCCESS, socketConnectSuccessHandler);
				BajieDispatcher.getInstance().addEventListener(BajieDispatcher.LOGIN_SUCCESS, 
								function t(e:ParamEvent):void
								{
									socketManager.close();
									var o:Object = e.Param;
									GlobalData.ip = o.ip;
									GlobalData.port = o.port;
									GlobalData.sessionKey = o.session_key;
									GlobalData.numberCode = o.number;
									
									BajieDispatcher.getInstance().removeEventListener(BajieDispatcher.LOGIN_SUCCESS, t);
									socketManager.removeEventListener(SocketEvent.SOCKET_CLOSE,socketCloseHandler);
									socketManager.removeEventListener(SocketEvent.CONNECT_FAIL,socketConnectFailHandler);
									socketManager.removeEventListener(SocketEvent.CONNECT_SUCCESS, socketConnectSuccessHandler);
									//第二次登陆连接
									socketManager.addEventListener(SocketEvent.SOCKET_CLOSE,socketCloseHandler2);
									socketManager.addEventListener(SocketEvent.CONNECT_FAIL,socketConnectFailHandler2);
									socketManager.addEventListener(SocketEvent.CONNECT_SUCCESS, socketConnectSuccessHandler2);
									LoginSocketProxy.loginSocket(new SocketInfo(GlobalData.ip, GlobalData.port));
									trace("开始进入游戏");
									
								});
				LoginSocketProxy.loginSocket(new SocketInfo(GlobalData.tmpIP, GlobalData.tmpPort));
				
			}
			if (GlobalData.domain.hasDefinition("bajie.manager.loader.CacheManager"))
			{
				var cl1:Class = GlobalData.domain.getDefinition("bajie.manager.loader.CacheManager") as Class;
				cacheManager = new cl1((configData.update)[0]..version, sitePath) as ICacheApi;
			}
			if (GlobalData.domain.hasDefinition("bajie.manager.loader.LoaderManager"))
			{
				var cl:Class = GlobalData.domain.getDefinition("bajie.manager.loader.LoaderManager") as Class;
				loaderAPI = new cl() as ILoaderApi;
				loaderAPI.setup(GlobalData.domain, decoder, useCache? cacheManager: null);
			}
			if (GlobalData.domain.hasDefinition("bajie.manager.moviewrapper.MovieManager"))
			{
				var mcl:Class = GlobalData.domain.getDefinition("bajie.manager.moviewrapper.MovieManager") as Class;
				movieManagerApi = new mcl() as IMovieManager;
			}
			if(GlobalData.domain.hasDefinition("bajie.manager.tick.TickManager"))
			{
				var tcl:Class = GlobalData.domain.getDefinition("bajie.manager.tick.TickManager") as Class;
				tickManager = new tcl(layerManager) as ITickManager;
			}
			if(GlobalData.domain.hasDefinition("bajie.manager.keyboard.KeyboardManager"))
			{
				var kcl:Class = GlobalData.domain.getDefinition("bajie.manager.keyboard.KeyboardManager") as Class;
				keyboardManager = new kcl(layerManager.getPopLayer().stage) as IKeyboardApi;
			}
			loaderAPI.setTickManager(tickManager);
			
			ToolTipManager.getInstance().border = 0x627178;
			ToolTipManager.getInstance().borderSize = 2;
			ToolTipManager.getInstance().alpha = 0.65;
			ToolTipManager.getInstance().colors = [0x604832,0xff0000];
			
			menuManager = new MenuManager();
			
		}

		//加载配置文件
		public static function loadConfig():void
		{
			var mainConfPath:String = "";
			//if(sp.stage != null)
			//{
				if (sp.loaderInfo.parameters["conf"] != undefined)
					mainConfPath = sp.loaderInfo.parameters["conf"];
				else
					mainConfPath = "";
			//}
			
			
			Security.allowDomain("*");
			var configLoader:URLLoader = new URLLoader();
			configLoader.dataFormat = URLLoaderDataFormat.TEXT;
			configLoader.addEventListener(Event.COMPLETE, configCompleteHandler);
			configLoader.load(new URLRequest(mainConfPath +"bajie/config/config.xml"));//主配置文件
			
			var configLoader2:URLLoader = new URLLoader;
			configLoader2.dataFormat = URLLoaderDataFormat.TEXT;
			configLoader2.addEventListener(Event.COMPLETE, configCompleteHandler2);
			configLoader2.load(new URLRequest(mainConfPath +"bajie/config/propsexplain.xml"));//道具武器等说明文档
			
			var configLoader3:URLLoader = new URLLoader;
			configLoader3.dataFormat = URLLoaderDataFormat.TEXT;
			configLoader3.addEventListener(Event.COMPLETE, configCompleteHandler3);
			configLoader3.load(new URLRequest(mainConfPath +"bajie/config/skillconfig.xml"));//技能属性配置文档
			
			var configLoader4:URLLoader = new URLLoader;
			configLoader4.dataFormat = URLLoaderDataFormat.TEXT;
			configLoader4.addEventListener(Event.COMPLETE, configCompleteHandler4);
			configLoader4.load(new URLRequest(mainConfPath +"bajie/config/fashionconfig.xml"));//时装属性配置文档
			
			var configLoader5:URLLoader = new URLLoader;
			configLoader5.dataFormat = URLLoaderDataFormat.TEXT;
			configLoader5.addEventListener(Event.COMPLETE, configCompleteHandler5);
			configLoader5.load(new URLRequest(mainConfPath +"bajie/config/taskconfig.xml"));//任务静态配置文档
			
		}

		//加载完配置文件后加载主文件
		private static function configCompleteHandler(e:Event):void
		{
			var configLoader:URLLoader = e.currentTarget as URLLoader;
			configLoader.removeEventListener(Event.COMPLETE, configCompleteHandler);
			configData = XML(configLoader.data);

			try
			{
					Security.loadPolicyFile(String(configData.config.SITE.@value) + "crossdomain.xml");
					Security.loadPolicyFile(String(configData.config.SITE.@value) + "resource/crossdomain.xml");
			}
			catch(err:SecurityError)
			{
				trace(err.message);
			}
			//addMainMC();
			preSetUp();
			setup();
		}
		
		//道具说明文档
		private static function configCompleteHandler2(e:Event):void
		{
			var configLoader:URLLoader = e.currentTarget as URLLoader;
			configLoader.removeEventListener(Event.COMPLETE, configCompleteHandler2);
			itemConfigData = XMLList(configLoader.data);
			GlobalData.itemTemplateList.setup(itemConfigData);
		}
		
		//技能说明文档
		private static function configCompleteHandler3(e:Event):void
		{
			var configLoader:URLLoader = e.currentTarget as URLLoader;
			configLoader.removeEventListener(Event.COMPLETE, configCompleteHandler3);
			skillConfigData = XMLList(configLoader.data);
			GlobalData.skillTemplateList.setup(skillConfigData);
		}
		
		//时装属性说明文档
		private static function configCompleteHandler4(e:Event):void
		{
			var configLoader:URLLoader = e.currentTarget as URLLoader;
			configLoader.removeEventListener(Event.COMPLETE, configCompleteHandler4);
			fashionConfigData = XMLList(configLoader.data);
			GlobalData.fashionTempleteList.setup(fashionConfigData);
		}
		
		//任务静态配置文档
		private static function configCompleteHandler5(e:Event):void
		{
			var configLoader:URLLoader = e.currentTarget as URLLoader;
			configLoader.removeEventListener(Event.COMPLETE, configCompleteHandler5);
			taskConfigData = XMLList(configLoader.data);
			GlobalData.taskTempleteList.setup(taskConfigData);
		}
		
		/**
		 *加载主界面 
		 * 
		 */		
		public static function addMainMC(o:Object = null):void
		{
			
			GlobalAPI.loaderAPI.loadSwf(GlobalAPI.pathManager.getModulePath(ModuleType.NAVIGATION), _loaderReady, 0);
			function _loaderReady(loader:ILoader):void
			{
				main = Main.getInstance();//new Room();
				for(var i:int = 0; i < ModuleType.moduleList.length; i++)
				{
				var s:String =SetModuleUtils.getModuleName(ModuleType.moduleList[i]);
					o[ModuleType.moduleList[i]] == 1? GlobalAPI.main.setView(s) : false;
				}
			
				GlobalAPI.layerManager.getModuleLayer().addChild(main);
				GlobalAPI.layerManager.getModuleLayer().addChild(ChatPanel.getInstance());
				GlobalAPI.layerManager.getModuleLayer().addChild(BottomMenu.getInstance());
			}
			if(o != null)
				GlobalData.playerid = o.playerid;//接口预留 后端现在处理方式为忽略
		}

		/**
		 *加载注册面板 
		 * 
		 */		
		public static function addRegisterMC(o:Object):void
		{
			GlobalAPI.loaderAPI.loadSwf(GlobalAPI.pathManager.getModulePath(ModuleType.REGISTER), _loaderReady, 0);
			function _loaderReady(loader:ILoader):void
			{
				
				register = Register.getInstance();
				register.playerid = o.playerid;
				GlobalData.playerid = o.playerid;
				GlobalAPI.sp.addChild(register);
				register.setView(o);
			}
		
		}
		
		
		//第一次登陆连接关闭
		private static function socketCloseHandler(e:SocketEvent):void
		{
			socketManager.removeEventListener(SocketEvent.SOCKET_CLOSE,socketCloseHandler);
			
			trace("与登陆服务器断开连接");
		}

		//第一次登陆连接失败
		private static function socketConnectFailHandler(e:SocketEvent):void
		{
			socketManager.removeEventListener(SocketEvent.CONNECT_FAIL,socketConnectFailHandler);
			
			trace("GlobalAPI", "登陆socket断开连接");
		}
		
		private static function reConnectHandler(e:AlertEvent):void
		{
			GlobalData.alertInfo.removeEventListener(AlertEvent.SUBMIT, reConnectHandler);
			loadConfig();
		}

		//第一次登陆成功
		private static function socketConnectSuccessHandler(e:SocketEvent):void
		{
			socketManager.removeEventListener(SocketEvent.CONNECT_SUCCESS, socketConnectSuccessHandler);
			trace("socket已连接");
			SetSocketHandler.setHandlers();//初始化socket
			if(int(configData.config.debug.@value) == 0)
			{
				   var urlLoader:URLLoader = new URLLoader();
					urlLoader.addEventListener(Event.COMPLETE, onHttpLoad);
					var urlRequest:URLRequest = new URLRequest(String(configData.config.LOGIN_PATH.@value + "user/loginsession.ashx"));
					urlLoader.load(urlRequest);
					function onHttpLoad(event:Event):void {
						var xmlData:XML = new XML(urlLoader.data);
						GlobalData.tmpUserName = String(xmlData.@name);
						GlobalData.tmpPassword = String(xmlData.@pass);
						TestSocketHandler.send();
					}
			}
			else
			{
				TestSocketHandler.send();
			}
			
			
			SetModuleUtils.setToScene();
			
		}
		
		//第二次登陆连接关闭
		private static function socketCloseHandler2(e:SocketEvent):void
		{
			trace("与游戏服务器断开连接");
			var o:Object = new Object();
			o.message = "与游戏服务器断开连接,请重新登陆";
			GlobalData.alertInfo.confirmAlert(o);
			GlobalData.alertInfo.addEventListener(AlertEvent.SUBMIT, reConnectHandler);
		}
		
		//第二次登陆连接失败
		private static function socketConnectFailHandler2(e:SocketEvent):void
		{
			trace("GlobalAPI", "游戏socket断开连接");
			var o:Object = new Object();
			o.message = "游戏socket断开连接,请重新登陆";
			GlobalData.alertInfo.confirmAlert(o);
			GlobalData.alertInfo.addEventListener(AlertEvent.SUBMIT, reConnectHandler);
		}
		
		//第二次登陆成功
		private static function socketConnectSuccessHandler2(e:SocketEvent):void
		{
			trace("游戏socket已连接");
			SetSocketHandler.setHandlers();//初始化socket
			TestSocketHandler.send(GlobalData.sessionKey);
			SetModuleUtils.setToScene();
			
		}
	}
}