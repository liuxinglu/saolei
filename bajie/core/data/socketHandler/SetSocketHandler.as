package bajie.core.data.socketHandler 
{
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.socketHandler.alert.AlertSocketHandler;
	import bajie.core.data.socketHandler.alert.ConfirmWindowSocketHandler;
	import bajie.core.data.socketHandler.alert.TopAttantionSocketHandler;
	import bajie.core.data.socketHandler.bag.BagInfoSocketHandler;
	import bajie.core.data.socketHandler.bag.ChangeEquipSiteSocketHandler;
	import bajie.core.data.socketHandler.bag.ChangeFashionSiteSocketHandler;
	import bajie.core.data.socketHandler.bag.ChangePropSiteSocketHandler;
	import bajie.core.data.socketHandler.bag.EquipEquipSocketHandler;
	import bajie.core.data.socketHandler.bag.EquipFashionSocketHandler;
	import bajie.core.data.socketHandler.bag.EquipPropSocketHandler;
	import bajie.core.data.socketHandler.bag.GetBagEquipSocketHandler;
	import bajie.core.data.socketHandler.bag.GetBagFashionSocketHandler;
	import bajie.core.data.socketHandler.bag.GetBagPlayerInfoSocketHandler;
	import bajie.core.data.socketHandler.bag.GetBagPropSocketHandler;
	import bajie.core.data.socketHandler.bag.GetEquipDetailInfoSocketHandler;
	import bajie.core.data.socketHandler.bag.GetFashionDetailInfoSocketHandler;
	import bajie.core.data.socketHandler.bag.GetPropDetailInfoSocketHandler;
	import bajie.core.data.socketHandler.bag.SetAttSocketHandler;
	import bajie.core.data.socketHandler.bag.SortBagEquipSocketHandler;
	import bajie.core.data.socketHandler.bag.SortBagFashionSocketHandler;
	import bajie.core.data.socketHandler.bag.SortBagPropSocketHandler;
	import bajie.core.data.socketHandler.bag.UnsnachEquipSocketHandler;
	import bajie.core.data.socketHandler.bag.UnsnachFashionSocketHandler;
	import bajie.core.data.socketHandler.bag.UnsnachPropSocketHandler;
	import bajie.core.data.socketHandler.clearmines.ClearMinesSocketHandler;
	import bajie.core.data.socketHandler.clearmines.GameApplyPropSocketHandler;
	import bajie.core.data.socketHandler.clearmines.GameInvertTimeSocketHandler;
	import bajie.core.data.socketHandler.clearmines.GameOverFailSocketHandler;
	import bajie.core.data.socketHandler.clearmines.GameOverPrizeSocketHandler;
	import bajie.core.data.socketHandler.clearmines.GameOverRankSocketHandler;
	import bajie.core.data.socketHandler.clearmines.GameOverSuccessSocketHandler;
	import bajie.core.data.socketHandler.clearmines.GamePrizeListSocketHandler;
	import bajie.core.data.socketHandler.clearmines.GamePropMaxEffectSocketHandler;
	import bajie.core.data.socketHandler.clearmines.GamePropMinEffectSocketHandler;
	import bajie.core.data.socketHandler.clearmines.GameUserStateSocketHandler;
	import bajie.core.data.socketHandler.clearmines.GetPlateDetailsInfoSocketHandler;
	import bajie.core.data.socketHandler.email.*;
	import bajie.core.data.socketHandler.friends.*;
	import bajie.core.data.socketHandler.hall.HallInfoSocketHandler;
	import bajie.core.data.socketHandler.login.LoginEnterGameSocketHandler;
	import bajie.core.data.socketHandler.login.LoginHeartDanceSocketHandler;
	import bajie.core.data.socketHandler.main.*;
	import bajie.core.data.socketHandler.player.GetSimplePlayerInfoSocketHandler;
	import bajie.core.data.socketHandler.rank.*;
	import bajie.core.data.socketHandler.register.RandomAttSocketHandler;
	import bajie.core.data.socketHandler.register.RegisterPanelSocketHandler;
	import bajie.core.data.socketHandler.register.RegisterPlayerSocketHandler;
	import bajie.core.data.socketHandler.room.CreateRoomSocketHandler;
	import bajie.core.data.socketHandler.room.EnterRoomSocketHandler;
	import bajie.core.data.socketHandler.room.HostKickPlayerSocketHandler;
	import bajie.core.data.socketHandler.room.OCRoomSiiteSocketHandler;
	import bajie.core.data.socketHandler.room.SearchRoomSocketHandler;
	import bajie.core.data.socketHandler.room.UserExitRoomSocketHandler;
	import bajie.core.data.socketHandler.room.UserStartGameSocketHandler;
	import bajie.core.data.socketHandler.skill.AssemblySkillListSocketHandler;
	import bajie.core.data.socketHandler.skill.CarrayRolesSkillSocketHandler;
	import bajie.core.data.socketHandler.skill.GetSkillListSocketHandler;
	import bajie.core.data.socketHandler.skill.StripRolesSkillSocketHandler;
	import bajie.core.data.socketHandler.skill.UpgradeSkillLevelSocketHandler;
	import bajie.core.data.socketHandler.strengthen.*;
	import bajie.core.data.socketHandler.task.*;
	import bajie.core.data.socketHandler.userSet.EnterUserSetSocketHandler;
	import bajie.core.data.socketHandler.userSet.UserSetSocketHandler;
	import bajie.core.data.socketHandler.sign.*;
	import bajie.core.data.socketHandler.clearmines.GamePrizeResultSocketHandler;
	
	public class SetSocketHandler 
	{
		private static var _instance:SetSocketHandler;
		
		public static function setHandlers():void
		{
			if(!_instance)
			{
				_instance = new SetSocketHandler();
			}
		}

		public function SetSocketHandler() {
			// constructor code
			with(GlobalAPI.socketManager)
			{
				//首次登陆
				addSocketHandler(new TestSocketHandler);
				//登陆游戏
				addSocketHandler(new LoginEnterGameSocketHandler);
				addSocketHandler(new LoginHeartDanceSocketHandler);
				//加载主界面数据
				addSocketHandler(new MainPanelSocketHandler);
				//注册面板数据
				addSocketHandler(new RegisterPanelSocketHandler);
				//随机属性
				addSocketHandler(new RandomAttSocketHandler);
				//注册用户
				addSocketHandler(new RegisterPlayerSocketHandler);
				//大厅数据
				addSocketHandler(new HallInfoSocketHandler);
				//进入房间
				addSocketHandler(new EnterRoomSocketHandler);
				//创建房间
				addSocketHandler(new CreateRoomSocketHandler);
				//查找房间
				addSocketHandler(new SearchRoomSocketHandler);
				//警告
				addSocketHandler(new AlertSocketHandler);
				//确认
				addSocketHandler(new ConfirmWindowSocketHandler);
				//浮动提示
				addSocketHandler(new TopAttantionSocketHandler);
				//用户设置
				addSocketHandler(new UserSetSocketHandler);
				//获取用户设置
				addSocketHandler(new EnterUserSetSocketHandler);
				//获取邮件列表信息
				addSocketHandler(new GetEmailListSocketHandler);
				//获取邮件装备详细信息
				addSocketHandler(new GetEquipEmailDetailsSocketHandler);
				//获取邮件内道具
				addSocketHandler(new MailReceivePropsSocketHandler);
				//删除邮件
				addSocketHandler(new RemoveEmailSocketHandler);
				//房主开始
				addSocketHandler(new UserStartGameSocketHandler);
				//房主踢人
				addSocketHandler(new HostKickPlayerSocketHandler);
				//关闭房间位
				addSocketHandler(new OCRoomSiiteSocketHandler);
				//退出房间
				addSocketHandler(new UserExitRoomSocketHandler);
				//打开背包
				addSocketHandler(new BagInfoSocketHandler);
				//获取背包道具
				addSocketHandler(new GetBagPropSocketHandler);
				//获取背包装备
				addSocketHandler(new GetBagEquipSocketHandler);
				//获取背包时装
				addSocketHandler(new GetBagFashionSocketHandler);
				//获取背包人物信息
				addSocketHandler(new GetBagPlayerInfoSocketHandler);
				//交换背包内装备位置
				addSocketHandler(new ChangeEquipSiteSocketHandler);
				//交换背包内时装位置
				addSocketHandler(new ChangeFashionSiteSocketHandler);
				//交换背包内道具位置
				addSocketHandler(new ChangePropSiteSocketHandler);
				//装配装备
				addSocketHandler(new EquipEquipSocketHandler);
				//装配时装
				addSocketHandler(new EquipFashionSocketHandler);
				//装配道具
				addSocketHandler(new EquipPropSocketHandler);
				//整理装备
				addSocketHandler(new SortBagEquipSocketHandler);
				//整理时装
				addSocketHandler(new SortBagFashionSocketHandler);
				//整理道具
				addSocketHandler(new SortBagPropSocketHandler);
				//卸下装备
				addSocketHandler(new UnsnachEquipSocketHandler);
				//卸下时装
				addSocketHandler(new UnsnachFashionSocketHandler);
				//卸下道具
				addSocketHandler(new UnsnachPropSocketHandler);
				//获取技能列表
				addSocketHandler(new GetSkillListSocketHandler);
				//获取已装备技能
				addSocketHandler(new AssemblySkillListSocketHandler);
				//卸下技能
				addSocketHandler(new StripRolesSkillSocketHandler);
				//装备技能
				addSocketHandler(new CarrayRolesSkillSocketHandler);
				//技能升级
				addSocketHandler(new UpgradeSkillLevelSocketHandler);
				//获取单个装备详细信息
				addSocketHandler(new GetEquipDetailInfoSocketHandler);
				//获取单个时装详细信息
				addSocketHandler(new GetFashionDetailInfoSocketHandler);
				//获取单个道具详细信息
				addSocketHandler(new GetPropDetailInfoSocketHandler);
				//获取强化道具
				addSocketHandler(new GetUpdateMaterialSocketHandler);
				//获取强化基础信息
				addSocketHandler(new UpgradeEquipInfoSocketHandler);
				//强化装备
				addSocketHandler(new UpgradeEquipLevelSocketHandler);
				//获取用户简单信息
				addSocketHandler(new GetSimplePlayerInfoSocketHandler);
				//设置玩家属性点
				addSocketHandler(new SetAttSocketHandler);
				//排雷
				addSocketHandler(new ClearMinesSocketHandler);
				//游戏倒计时
				addSocketHandler(new GameInvertTimeSocketHandler);
				//游戏胜利
				addSocketHandler(new GameOverSuccessSocketHandler);
				//游戏失败
				addSocketHandler(new GameOverFailSocketHandler);
				//游戏棋盘
				addSocketHandler(new GetPlateDetailsInfoSocketHandler);
				//用户扫雷情况
				addSocketHandler(new GameUserStateSocketHandler);
				//游戏结束时排名
				addSocketHandler(new GameOverRankSocketHandler);
				//游戏结束后抽奖
				addSocketHandler(new GameOverPrizeSocketHandler);
				//抽奖结果推送
				addSocketHandler(new GamePrizeResultSocketHandler);
				//获取奖品列表
				addSocketHandler(new GamePrizeListSocketHandler);
				//游戏中使用道具
				addSocketHandler(new GameApplyPropSocketHandler);
				//道具小效果
				addSocketHandler(new GamePropMinEffectSocketHandler);
				//道具大效果
				addSocketHandler(new GamePropMaxEffectSocketHandler);
				
				//普通任务
				addSocketHandler(new TaskDailyListSocketHandler);
				//成就任务
				addSocketHandler(new TaskEffortListSocketHandler);
				//领取任务奖励
				addSocketHandler(new TaskReceiveSocketHandler);
				
				//签到
				addSocketHandler(new SignSureDaySocketHandler);
				addSocketHandler(new SignGetInfoSocketHandler);
				addSocketHandler(new SignGetAwardSocketHandler);
				addSocketHandler(new SignSupplementDaySocketHandler);
				
				//好友
				addSocketHandler(new GetFriendsListSocketHandler);
				addSocketHandler(new GetBlackListSocketHandler);
				addSocketHandler(new AddFriendSocketHandler);
				addSocketHandler(new AddBlackSocketHandler);
				
				//在线奖励
				addSocketHandler(new GetOnlineAwardSocketHandler);
				addSocketHandler(new GetOnlineTimeSocketHandler);
				addSocketHandler(new UpdateOnlineTimeSocketHandler);
				
				//排行榜
				addSocketHandler(new GetRankInfoSocketHandler);
				addSocketHandler(new GetMyRankSocketHandler);
			}
		}

	}
	
}
