package  bajie
{
	
	import bajie.Test;
	import bajie.constData.CommonConfig;
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.socketHandler.TestSocketHandler;
	import bajie.events.BajieDispatcher;
	import bajie.events.ParamEvent;
	import bajie.manager.layer.LayerManager;
	import bajie.manager.socket.SocketManager;
	import bajie.ui.Classic;
	import bajie.ui.Hall;
	import bajie.ui.Loading;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.Security;
	
	public class SaoLei extends Sprite 
	{
		private var loading:Loading = Loading.getInstance();
		public function SaoLei()
		{
			loading.x = 0;
			loading.y = 0;
			this.addChild(loading);
			
			BajieDispatcher.getInstance().addEventListener(BajieDispatcher.LOGIN_INTO_SCENE_SUCCESS, LoginIntoSceneHandler, false, 0, true);
			BajieDispatcher.getInstance().addEventListener(BajieDispatcher.MODULE_OPEN_REGISTER, openRegisterHandler, false, 0, true);
			BajieDispatcher.getInstance().addEventListener(BajieDispatcher.ALERT_MESSAGE, alertMessageHandler);
			BajieDispatcher.getInstance().addEventListener(BajieDispatcher.CONFIRM_MESSAGE, confirmMessageHandler);
			BajieDispatcher.getInstance().addEventListener(BajieDispatcher.RISK_MESSAGE, riskMessageHandler);
			var t:Declear = new Declear();
			GlobalData.domain = ApplicationDomain.currentDomain;
			GlobalAPI.sp = this;
			GlobalData.layer = this;
			GlobalAPI.loadConfig();
			BajieDispatcher.getInstance().addEventListener("LOADING", loadProgressHandler);
			this.addEventListener(Event.ADDED_TO_STAGE, stageResizeHandler);
		}
		
		//弹框警告
		private function alertMessageHandler(e:ParamEvent):void
		{
			
		}
		
		//确认提示
		private function confirmMessageHandler(e:ParamEvent):void
		{
			
		}
		
		//浮动文字
		private function riskMessageHandler(e:ParamEvent):void
		{
			
		}
		
		private function loadProgressHandler(e:ParamEvent):void
		{
			var o:Object = e.Param;
			var temp:int = (o.bytesLoaded/o.bytesTotal) * 100;
			
			this.loading.setCurFrame(int(Math.floor(temp)));
		}
		
		//设置模块显示
		private function LoginIntoSceneHandler(e:ParamEvent):void
		{
			
			var o:Object = e.Param;
			GlobalAPI.addMainMC(o);
			BajieDispatcher.getInstance().removeEventListener("LOADING", loadProgressHandler);
			
			removeLoading();
		}
		
		public function openRegisterHandler(e:ParamEvent):void
		{
			
			var o:Object = e.Param;
			GlobalAPI.addRegisterMC(o);
			BajieDispatcher.getInstance().removeEventListener("LOADING", loadProgressHandler);
			removeLoading();
		}
		
		private function removeLoading():void
		{
			loading.removeLoading();
			this.removeChild(loading);
			loading = null;
		}
		
		private function stageResizeHandler(e:Event):void
		{
			CommonConfig.setGameSize(stage.stageWidth, stage.stageHeight);
		}
		
		
	}
	
}
