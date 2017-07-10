package bajie.constData
{  
	
	public class ProtocolType
	{
		//用户登录
		public static const ACCOUNT_GETIN:uint = 1001;											//用户登录验证					
		public static const AOCCUNT_GETOUT:uint = 1002;										//退出
		
		//注册
		public static const REGISTER_PALNE:uint = 1005;											//创建角色面板
		public static const RANDOM_ATT:uint = 1006;												//	创建时随机角色属性
		public static const CREATE_PLAYER:uint = 1008;												//	创建角色
		public static const PROPS_USE_RENAME:uint = 1067;									//角色重命名
		
		
		//模块显示
		public static const MAIN_INFO:uint = 1009;													//大厅显示数据模块
		
		public static const GET_USER_SETTING:uint = 1010;										//获取用户配置信息-设置面板
		public static const MODIFY_USER_SETTING:uint = 1011;								//修改用户配置信息-设置面板
		
		
		//大厅
		public static const USER_INFO_IN_HALL:uint = 1061;									//获取大厅内角色信息
		public static const USER_ENTER_HALL:uint = 1012;										//进入竞技大厅获取房间列表
		public static const USER_CREATE_ROOM:uint = 1013;									//	用户创建房间
		public static const USER_ENTER_ROOM:uint = 1014;										//用户进入房间
		public static const USER_SEARCH_ROOM:uint = 1015;									//用户查找房间
		public static const USER_ENTER_ROOM_WITH_PASSWORD:uint = 1016;		//用户进入房间输入密码
		
		//等待房间
		public static const USER_EXIT_ROOM:uint = 1017;											//用户退出房间
		public static const REMOVE_CENTER_USER:uint = 1018;								//用户掉线或退出游戏
		public static const USER_READY_CANCEL:uint = 1021;									//用户取消准备
		public static const START_INVERT_TIMING:uint = 1022;									//房主开始倒计时
		public static const END_INVERT_TIMING:uint = 1023;									//取消房主倒计时
		public static const OPEN_CLOSE_ROOM_SITE:uint = 1024;							//关闭开放房间位置
		public static const HOST_KICK_PLAYER:uint = 1025;										//房主踢人
		public static const HOST_START_GAME:uint = 1026;										//房主开始游戏
		public static const GET_SIMPLE_PLAYER_INFO:uint = 1061;							//获取用户简单信息
		
		//战斗
		public static const GET_PLATE_DETAILS_INFO:uint = 1063;								//获取雷盘详细信息
		public static const GAME_DIG_GRID:uint = 1062;										//排查--排雷
		public static const GAME_OVER_SUCCESS:uint = 1064;									//游戏胜利
		public static const GAME_OVER_FAIL:uint = 1065;										//游戏失败
		public static const GAME_INVERT_TIME:uint = 1066;									//游戏倒计时
		public static const GAME_USER_STATE:uint = 1107;									//用户扫雷情况
		public static const GAME_OVER_RANKING:uint = 1100;									//游戏结束时排名
		public static const GAME_OVER_PRIZE:uint = 1101;									//游戏结束后抽奖
		public static const GAME_PRIZE_RESULT:uint = 1102;									//发送抽奖结果(推送)
		public static const GAME_PRIZE_LIST:uint = 1103;									//获取奖品列表
		public static const GAME_APPLY_PROP:uint = 1104;									//游戏中使用道具
		public static const GAME_PROP_MIN_EFFECT:uint = 1105;								//道具小效果
		public static const GAME_PROP_MAX_EFFECT:uint = 1106;								//道具大效果
		
		//邮件
		public static const GET_MALL_DETAILS:uint = 1032;										//获取邮件详细信息
		public static const MAIL_RECEIVE_PROPS:int = 1028;										/// 邮件确认获取道具
		public static const MAIL_RECEIVE_WEAPONS:int = 1029;								/// 邮件确认获取装备
		public static const MAIL_RECEIVE_DRESS:int = 1030;										/// 邮件确认获取时装
		public static const GET_MAIL_LIST:int = 1031;												/// 获取邮件列表
        public static const GET_EQUIPT_EMAIL_DETAILS:int = 1073;					// 获取邮件装备详细信息
		public static const REMOVE_EMAIL:int = 1087;								//删除邮件
		
		//背包
		public static const BAG_IN:uint = 1039;															//进入背包
		public static const GET_BAG_PLAYER_INFO:uint = 1038;								//获取背包角色信息
		public static const GET_BAG_PROP:uint = 1027;												//获取背包道具
		public static const GET_BAG_EQUIP:uint = 1033;											//获取背包装备
		public static const GET_BAG_FASHION:uint = 1034;										//获取背包时装
		
		public static const USE_PROP:uint = 1068;												//使用道具
		public static const EQUIP_PROP:uint = 1035;							 						//携带道具
		public static const UNSNACH_PROP:uint = 1040;											//卸下道具
		public static const SORT_BAG_PROP:uint = 1043;											//整理背包内道具
		public static const CHANGE_PROP_SITE:uint = 1046;										//交换道具位置
		
		public static const EQUIP_EQUIP:uint = 1036;												//装备装备
		public static const UNSNACH_EQUIP:uint = 1041;											//卸下装备
		public static const SORT_BAG_EQUIP:uint = 1044;											//整理背包内装备
		public static const CHANGE_EQUIP_SITE:uint = 1047;									//交换装备位置
		
		public static const EQUIP_FASHION:uint = 1037;											//装备时装
		public static const UNSNACH_FASHION:uint = 1042;									//卸下时装
		public static const SORT_BAG_FASHION:uint = 1045;									//整理背包内时装
		public static const CHANGE_FASHION_SITE:uint = 1048;								//交换时装位置
		
		public static const GET_EQUIP_DETAILS_INFO:uint = 1070;								//获取装备详细信息
		public static const GET_FASHION_DETAILS_INFO:uint = 1071;							//获取时装详细信息
		public static const GET_PROP_DETAILS_INFO:uint = 1069;								//获取道具详细信息
		
		public static const SELL_PROP:uint = 1075;											//出售道具
		public static const SELL_EQUIP:uint = 1076;											//出售装备
		public static const SELL_FASHION:uint = 1077;										//出售时装
		
		public static const REPAIR_EQUIP:uint = 1078;										//修复装备
		
		public static const SET_ATT:uint = 1079;											//分配人物属性
		
		public static const GET_ONLINE_TIME:uint = 1080;									//获取在线时间
		public static const UPDATE_ONLINE_TIME:uint = 1081;									//更新在线时间
		public static const GET_ONLINE_AWARD:uint = 1082;									//领取在线奖励
		
		//签到
		public static const GET_SIGN_INFO:uint = 1083;										//获取签到信息
		public static const SIGN_SURE_DAY:uint = 1084;										//用户签到
		public static const GET_SIGN_AWARD:uint = 1085;										//领取签到奖励
		public static const SIGN_SUPPLEMENT_DAY:int = 1108;										//用户补签
		
		public static const GET_EQUIP_ROLE_DETAIL:uint = 1086;								//获取人物身上装备详情
		
		//警告
		public static const RISK_MESSAGE:uint = 6001;												//浮动提示文字
		public static const ALERT_MESSAGE:uint = 6002;											//弹框警告
		public static const CONFIRM_MESSAGE:uint = 6003;										//确认弹框
		
		//技能
        public static const GET_SKILL_LIST:int = 1049;			// 获取技能列表
        public static const ASSEMBLY_SKILL_LIST:int = 1050;			// 获取已经装备的技能
        public static const CARRAY_ROLES_SKILL:int = 1051;			// 装配技能
        public static const STRIP_ROLES_SKILL:int = 1052;			// 卸载技能
        public static const UPGRADE_SKILL_LEVEL:int = 1053;				// 技能升级
		
		//强化
        public static const UPGRADE_EQUIPT_LEVEL:int = 1054;			// 装备升级
        public static const GET_UPGRADE_MATERIAL:int = 1055;			// 获取强化材料
		public static const UPGRADE_EQUIPT_INFO:int = 1089;				//装备强化信息
		
        //商城
        public static const MALL_BUY_GOLD:int = 1090;						// 金币购买
        public static const MALL_BUY_SILVER:int = 1091;					// 银币购买
        
		//任务
        public static const TASK_DAILY_LIST:int = 1092;						// 日常任务列表
        public static const TASK_EFFORT_LIST:int = 1093;						// 成就任务列表
        public static const TASK_RECEIVE_PRIZE:int = 1094;						// 领取任务奖励
		
		//好友
        public static  const GET_FRIENDS_LIST:int = 1057;							// 获取好友列表
        public static  const GET_BLACK_LIST:int = 1058;								// 获取黑名单列表
        public static  const ADD_FRIEND_LIST:int = 1059;							// 添加好友
        public static  const ADD_BLACK_LIST:int = 1060;								// 加入黑名单
		//排行榜
		public static const GET_RANK_INFO:int = 1109;							//排行榜列表
		public static const GET_MYRANK:int = 1110;								//我的排行
	}
}