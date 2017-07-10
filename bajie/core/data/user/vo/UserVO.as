package bajie.core.data.user.vo {
	
	/**
	 *玩家自身信息 
	 * @author liuxinglu
	 * 
	 */	
	public class UserVO {
		/**
		 *用户唯一id 
		 */		
		public var playerid:int = 0;
		
		/**
		 *用户登录ip 
		 */		
		public var ip:String = "";
		
		/**
		 *昵称 
		 */		
		public var name:String = "";
		
		/**
		 *性别 1男， 2女 
		 */		
		public var sex:int = 1;
		
		/**
		 *能量 
		 */		
		public var energy:uint = 1;
		
		/**
		 *幸运 
		 */		
		public var lucky:uint = 1;
		
		/**
		 * 灵巧
		 */		
		public var dexterity:uint = 1;
		
		/**
		社交头像-绝对路径
		*/
		public var avatar:String = "";
		
		/**
		附加能量
		*/
		public var additEnergy:uint = 0;
		/**
		附加幸运
		*/
		public var additLucky:uint = 0;
		/**
		附加灵巧
		*/
		public var additDexterity:uint = 0;
		/**
		灵巧buffer
		*/
		public var bufferDexterity:uint = 0;
		/**
		能量buffer
		*/
		public var bufferEnergy:uint = 0;
		/**
		经验buffer
		*/
		public var bufferExp:uint = 0;
		/**
		幸运buffer
		*/
		public var bufferLucky:uint = 0;
		/**
		技能buffer
		*/
		public var bufferSkill:uint = 0;
		/**
		VIPbuffer
		*/
		public var bufferVip:uint = 0;
		/**
		金币
		*/
		public var gold:uint = 0;
		/**
		银币
		*/
		public var silver:uint = 0;
		/**
		可分配点数
		*/
		public var lastPoints:uint = 0;
		/**
		当前升级所需要的总经验
		*/
		public var needExp:uint = 0;
		/**
		当前经验
		*/
		public var exp:uint = 0;
		/**
		当前等级
		*/
		public var level:uint = 0;
		/**
		军衔或军衔id
		*/
		public var title:String = "";
		
		public function UserVO() {
			// constructor code
		}

	}
	
}
