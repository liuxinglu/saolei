package bajie.ui {
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.events.BajieDispatcher;
	import bajie.events.ParamEvent;
	import bajie.interfaces.loader.ILoader;
	import bajie.ui.email.Email;
	import bajie.ui.shop.Shop;
	import bajie.ui.sign.Sign;
	import bajie.ui.strengthen.Strengthen;//临时测试使用
	import bajie.utils.module.SetModuleUtils;
	import flash.display.MovieClip;
	
	import flash.display.Loader;
	import flash.events.MouseEvent;
	import flash.system.LoaderContext;
	import bajie.events.ParamEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	public class Main extends MovieClip  
	{
		private var classicSp:Classic;
		private var hallSp:Hall;
		private static var _main:Main;
		private var ui:*;
		
		public static function getInstance():Main
		{
			if(_main == null)
			{
				_main = new Main();
			}
			return _main;
		}
		
		public function Main() {
			ui = GlobalAPI.loaderAPI.getObjectByClassPath("main");
			addChild(ui);
			
			initEvent();
		}
		
		public function setView(s:String):void
		{
			switch(s)
			{
				case "hall":
					ui.hall.visible = true;
					break;
				case "shop":
					ui.shop.visible = true;
					break;
				case "celebrity":
					ui.celebrity.visible = true;
					break;
				case "classic":
					//classic.visible = true;
					break;
			}
		}
		
		public function initEvent():void
		{
			ui.txt_rewardTime.mouseEnabled = false;
			ui.btn_reward.mouseEnabled = false;
			
			ui.hall.addEventListener(MouseEvent.CLICK, hallClickHandler);
			ui.shop.addEventListener(MouseEvent.CLICK, shopClickHandler);
			//classic.addEventListener(MouseEvent.CLICK, classicSaoLeiHandler);
			ui.email.addEventListener(MouseEvent.CLICK, emailClickHandler);
			ui.checkIn.addEventListener(MouseEvent.CLICK, signClickHandler);
			ui.btn_reward.addEventListener(MouseEvent.CLICK, clickTimeReward);
			ui.celebrity.addEventListener(MouseEvent.CLICK, clickRank);
			BajieDispatcher.getInstance().addEventListener(BajieDispatcher.SCENE_LOADING_INTO, sceneLoadingIntoHandler);
			GlobalData.navigation.addEventListener(ParamEvent.UPDATE_ONLINE_TIME, updateTimeReward);
			
			GlobalData.navigation.getOnlineTime();
			myTime.addEventListener(TimerEvent.TIMER,onTimer);
		}
		private var myTime:Timer = new Timer(1000);
		private var second:int = 0;
		private var minute:int = 0;
		private var hour:int = 0;
		private var timeStep:int = 0;
		/**
		 * 更新在线奖励时间
		 * @param	o
		 */
		private function updateTimeReward(e:ParamEvent):void {
			var o:Object = e.Param;
			if (o.timer>0) {
				second = o.timer % 60;
				minute = int(o.timer / 60) % 60;
				hour = int(o.timer / 3600) % 60;
			}
			if (o.enable == 2) {//可以领取
				ui.btn_reward.mouseEnabled = true;
				ui.txt_rewardTime.text = "可以领取";
				myTime.reset();
			}else if(o.enable == 1){//不可以领取
				ui.btn_reward.mouseEnabled = false;
				myTime.start();
			}else if (o.enable == 3) {//已领取完
				ui.btn_reward.mouseEnabled = false;
				ui.txt_rewardTime.text = "已经领完";
				myTime.reset();
			}
		}
		private function onTimer(e:TimerEvent):void {
			timeStep++;
			if (timeStep>=10) {
				GlobalData.navigation.updateOnlineTime();
				timeStep = 0;
			}
			if (second>0) {
				second--;
			}else {
				if (minute>0) {
					second = 59;
					minute--;
				}else {
					if (hour > 0) {
						minute = 59;
						second = 59;
						hour--;
					}else {
						GlobalData.navigation.getOnlineTime();
						myTime.reset();
					}
				}
			}
			var txtHour:String = (hour>=10)?hour.toString():("0"+hour.toString());
			var txtMinute:String = (minute>=10)?minute.toString():("0"+minute.toString());
			var txtSecond:String = (second>=10)?second.toString():("0"+second.toString());
			ui.txt_rewardTime.text = txtHour + ":" + txtMinute + ":" + txtSecond;
		}
		/**
		 * 获取在线奖励
		 * @param	e
		 */
		private function clickTimeReward(e:MouseEvent):void {
			GlobalData.navigation.getOnlineAward();
		}
		
		private function sceneLoadingIntoHandler(e:ParamEvent):void
		{
			
		}
		
		private function hallClickHandler(e:MouseEvent):void
		{
			SetModuleUtils.addMod(ModuleType.HALL, funHallHandler);
			/*GlobalAPI.loaderAPI.loadSwf(GlobalAPI.pathManager.getModulePath(ModuleType.HALL), _loaderReady, 0);
			function _loaderReady(loader:ILoader):void
			{	
				var hallSp:Hall = new Hall();
				hallSp.initEvent();
				SetModuleUtils.addModule(hallSp);
				GlobalData.hallInfo.enterHall(GlobalData.playerid);
				GlobalData.playerInfo.getSimplePlayer();
				SetModuleUtils.setModuleTop(ChatPanel.getInstance());
				SetModuleUtils.setModuleTop(BottomMenu.getInstance());
			}*/
			//loader.loadSync();
		}
		
		private function funHallHandler(cl:Class):void
		{
			GlobalData.playerInfo.addEventListener(ParamEvent.GET_SIMPLE_PLAYER_INFO, getSimpleInfoHandler, false, 0, true);
			GlobalData.playerInfo.getSimplePlayer();
		}
		
		private function getSimpleInfoHandler(e:ParamEvent):void
		{
			GlobalData.playerInfo.removeEventListener(ParamEvent.GET_SIMPLE_PLAYER_INFO, getSimpleInfoHandler);
			hallSp = new Hall;
			hallSp.initEvent();
			SetModuleUtils.addModule(hallSp, null, false, false, ModuleType.HALL);
			hallSp.getSimpleInfoHandler(e);
			GlobalData.hallInfo.enterHall(GlobalData.playerid);
			
			SetModuleUtils.setModuleTop(ChatPanel.getInstance());
			SetModuleUtils.setModuleTop(BottomMenu.getInstance());
		}
		
		private function shopClickHandler(e:MouseEvent):void
		{
			SetModuleUtils.addMod(ModuleType.STORE, funShopHandler);
		}
		private function funShopHandler(cl:Class) {
			var shop:Shop = new Shop();
			SetModuleUtils.addModule(shop, null, true, false, ModuleType.STORE);
		}
		
		//private function classicSaoLeiHandler(e:MouseEvent):void
//		{
//			classicSp = Classic.getInstance();
//			classicSp.initEvent();
//			classicSp.x = 120;
//			classicSp.y = 80;
//			SetModuleUtils.addModule(classicSp,null, true);
//		}
		
		/*private function btnClickHandler(e:MouseEvent):void
		{
			trace("~~~");
			TestSocketHandler.send();
		}*/
		
		private function emailClickHandler(e:MouseEvent):void {
			SetModuleUtils.addMod(ModuleType.MAIL, funEmailHandler);
		}
		private function funEmailHandler(cl:Class):void {
			var email:Email = new Email();
			SetModuleUtils.addModule(email, null, true, false, ModuleType.MAIL);
		}
		private function signClickHandler(e:MouseEvent):void {
			SetModuleUtils.addMod(ModuleType.SIGN, funSignHandler);
		}
		private function funSignHandler(cl:Class):void {
			var sign:Sign = new Sign();
			SetModuleUtils.addModule(sign, null, true, false, ModuleType.SIGN);
		}
		private function clickRank(e:MouseEvent):void {
			SetModuleUtils.addMod(ModuleType.RANK, funRankHandler);
		}
		private function funRankHandler(cl:Class):void {
			var rank:Rank = new Rank();
			SetModuleUtils.addModule(rank, null, false, false, ModuleType.RANK);
		}
	}
	
}
