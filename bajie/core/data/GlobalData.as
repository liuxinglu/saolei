package bajie.core.data
{
	import bajie.core.data.alert.AlertInfo;
	import bajie.core.data.bag.BagInfo;
	import bajie.core.data.bag.ItemTemplateList;
	import bajie.core.data.chat.ChatInfo;
	import bajie.core.data.email.EmailInfo;
	import bajie.core.data.fashion.FashionTemplateList;
	import bajie.core.data.fight.FightInfo;
	import bajie.core.data.friends.friendInfo;
	import bajie.core.data.hall.HallInfo;
	import bajie.core.data.im.ImPlayerList;
	import bajie.core.data.mall.MallInfo;
	import bajie.core.data.navigation.Navigation;
	import bajie.core.data.rank.RankInfo;
	import bajie.core.data.skill.SkillInfo;
	import bajie.core.data.skill.SkillTemplateList;
	import bajie.core.data.strengthen.StrengthenInfo;
	import bajie.core.data.task.TaskItemInfo;
	import bajie.core.data.task.TaskTemplateList;
	import bajie.core.data.user.PlayerInfo;
	import bajie.core.data.userSet.UserSetInfo;
	import bajie.interfaces.dispose.IDispose;
	import bajie.core.data.sign.SignInfo;
	
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;

	public class GlobalData
	{
		public static var layer:Sprite;
		public static var domain:ApplicationDomain;
		public static var tmpUserName:String;
		public static var tmpPassword:String;
		public static var tmpId:String;
		public static var tmpSite:String;
		public static var tmpTime:uint;
		public static var tmpCM:String;
		public static var tmpRoleCreatePanel:IDispose;
		public static var tmpSign:String;
		public static var guest:Boolean;
		/**
		 *游戏ip 
		 */		
		public static var ip:String;
		/**
		 *端口号 
		 */		
		public static var port:int;
		/**
		 *sessionKey 
		 */		
		public static var sessionKey:String;
		
		/**
		 *玩家id 
		 */		
		public static var playerid:uint = 0;
		/**
		 *流水号 
		 */		
		public static var numberCode:String;
		
		/**
		是否首次登陆
		*/
		public static var isFirstLogin:Boolean;
		
		/**
		 *版本号 
		 */		
		public static var version:Number = 1;
		
		/**
		 *背景音乐 
		 */		
		public static var music:int = 1;
		
		/**
		 *游戏音效 
		 */		
		public static var sound:int = 1;
		
		/**
		 *接受邀请 
		 */		
		public static var invite:int = 1;
		
		/**
		 *引导功能 
		 */		
		public static var guide:int = 1;
		
		/**
		 *上线提示
		 */		
		public static var prompt:int = 1;
		
		/**
		 *屏蔽私聊 
		 */		
		public static var whisper:int = 0;
		
		/**
		 *允许加为好友 
		 */		
		public static var friends:int = 1;
		
		/**
		 *允许快速加入 
		 */		
		public static var rapid:int = 1;
		
		/**
		 *是否显示时装 
		 */		
		public static var fashion:int = 1;
		
		/**
		能否用技能
		*/
		public static var canUseSkill:Boolean;
		
		/**
		能否用道具
		*/
		public static var canUseProp:Boolean;
		/**
		系统时间
		*/
		public static var systemDate:SystemDateInfo = new SystemDateInfo();
		
		/**
		累计在线时间
		*/
		public static var onLineTime:int = 0;
		
		/**
		 *玩家信息 
		 */		
		public static var playerInfo:PlayerInfo = new PlayerInfo();
		
		/**
		 *大厅数据 
		 */		
		public static var hallInfo:HallInfo = new HallInfo();
		
		/**
		 *战斗界面数据 
		 */		
		public static var fightInfo:FightInfo = new FightInfo();
		
		/**
		 *游戏设置信息
		 */		
		public static var userSetInfo:UserSetInfo = new UserSetInfo();
		/**
		商城数据
		*/
		public static var mallInfo:MallInfo = new MallInfo();
		
		/**
		背包数据
		*/
		public static var bagInfo:BagInfo = new BagInfo();
		
		//public static var topPanelInfo:TopPanelInfo = new TopPanelInfo;
		
		/**
		 *物品的静态数据列表 
		 */		
		public static var itemTemplateList:ItemTemplateList = new ItemTemplateList;
		
		/**
		 *技能的静态数据列表 
		 */		
		public static var skillTemplateList:SkillTemplateList = new SkillTemplateList;
		
		/**
		 *时装静态数据列表 
		 */		
		public static var fashionTempleteList:FashionTemplateList = new FashionTemplateList;
		
		/**
		 * 任务静态配置列表
		 * */
		public static var taskTempleteList:TaskTemplateList = new TaskTemplateList;
		
		/**
		聊天记录
		*/
		public static var chatInfo:ChatInfo = new ChatInfo();
		/**
		 * 导航图
		 */
		public static var navigation:Navigation = new Navigation();
		/**
		任务数据
		*/
		public static var taskItemsInfo:TaskItemInfo = new TaskItemInfo();
		
		/**
		im好友数据
		*/
		public static var imPlayerList:ImPlayerList = new ImPlayerList();
		
		/**
		技能数据
		*/
		public static var skillInfo:SkillInfo = new SkillInfo();
		
		/**
		邮件数据
		*/
		public static var emailInfo:EmailInfo = new EmailInfo();
		/*
		 * 强化装备数据
		 */
		public static var strengthenInfo:StrengthenInfo = new StrengthenInfo();
		
		/**
		 *弹框数据 
		 */		
		public static var alertInfo:AlertInfo = new AlertInfo;
		
		/**
		 * 签到数据
		 */
		public static var signInfo:SignInfo =  new SignInfo();
		/**
		 * 好友数据
		 */
		public static var friendsInfo:friendInfo = new friendInfo();
		/**
		 * 排行榜数据
		 */
		public static var rankInfo:RankInfo = new RankInfo();
		 
		public static var tmpIP:String = "";
		
		public static var tmpPort:int = 10069;
		
	}
}