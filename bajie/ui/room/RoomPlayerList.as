package bajie.ui.room 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import bajie.core.data.GlobalData;
	import bajie.core.data.GlobalAPI;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author azjune
	 */
	public class RoomPlayerList extends MovieClip 
	{
		private var mc:*;
		
		public var teamid:int = -1;
		public var index:int = -1;
		
		private var _avatar:String = "";
		private var _captain:int = -1;
		private var _dexterity:int = -1;
		private var _energy:int = -1;
		private var _exp:int = -1;
		private var _level:int = -1;
		private var _lucky:int = -1;
		private var _me:int = -1;
		private var _name:String = "";
		private var _playerid:int = -1;
		private var _ready:int = -1;
		private var _sex:int = -1;
		private var _skill:int = -1;
		private var _vip:int = -1;
		private var _weapon:int = -1;
		
		private var _openState:int = -1;
		
		private var _isControl:Boolean = false;
		
		private var _filter:GlowFilter;
		
		public function RoomPlayerList() 
		{
			mc = GlobalAPI.loaderAPI.getObjectByClassPath("roomPlayerList");
			addChild(mc);
			initEvent();
		}/**
		 * 初始化用户信息
		 * @param	isclose 是否为关闭状态
		 * @param	o
		 */
		public function initMC(isOpen:Boolean, o:Object = null ):void {
			initInfo();
			if (!isOpen) {
				mc.gotoAndStop(2);
				mc.mc_close.gotoAndStop(2);
				_openState = 0;
				return;
			}else {
				mc.gotoAndStop(1);
				mc.mc_close.gotoAndStop(1);
				_openState = 1;
			}
			if (o == null) {
				return;
			}else {
				mc.gotoAndStop(3);
				_openState = 2;
			}
			_avatar = o.avatar;
			_captain = o.captain;
			_dexterity = o.dexterity;
			_energy = o.energy;
			_exp = o.exp;
			_level = o.level;
			_lucky = o.lucky;
			_me = o.me;
			_name = o.name;
			_playerid = o.playerid;
			_ready = o.ready;
			_sex = o.sex;
			_skill = o.skill;
			_vip = o.vip;
			_weapon = o.weapon;
			
			if (_captain == 1) {
				mc.mc_backGround.gotoAndStop(2);
				mc.isHost.gotoAndStop(2);
			}else {
				mc.mc_backGround.gotoAndStop(1);
				if (_ready == 1) {
					mc.isHost.gotoAndStop(3);
				}
				else {
					mc.isHost.gotoAndStop(1);
				}
			}
			//设置我的特殊显示
			if (_me == 1) {
				mc.mc_backGround.filters = [filter];
			}else {
				mc.mc_backGround.filters = null;
			}
			
			//填充个人信息
			try {
				mc.playerMC.playerName.text = _name;
				mc.playerMC.playerShap.gotoAndStop(_sex);
			}catch (err:Error) {
				trace(err);
			}
			
			
		}
		
		private function initInfo():void {
			_avatar = "";
			_captain = -1;
			_dexterity = -1;
			_energy = -1;
			_exp = -1;
			_level = -1;
			_lucky = -1;
			_me = -1;
			_name = "";
			_playerid = -1;
			_ready = -1;
			_sex = -1;
			_skill = -1;
			_vip = -1;
			_weapon = -1;
			_openState = -1;
			_isControl = false;
			mc.closeBtn.visible = false;
			mc.mc_backGround.gotoAndStop(1);
			mc.mc_backGround.filters = null;
			//mc.playerMC.playerName.text = "";
		}
		private function initEvent():void {
			mc.closeBtn.addEventListener(MouseEvent.CLICK, kickPlayer);
			this.addEventListener(MouseEvent.CLICK, setOpen);
		}
		/**
		 * 踢人的方法
		 * @param	e
		 */
		private function kickPlayer(e:MouseEvent):void {
			if ((_openState == 2)&&_isControl) {
				GlobalData.hallInfo.hostKickPlayer(teamid, index);
			}
		}
		/**
		 * 是否可以踢人
		 * @param	boo
		 */
		public function setKickEnable(boo:Boolean):void {
			if (boo) {
				if (_openState == 2) mc.closeBtn.visible = true;	
				else mc.closeBtn.visible = false;
			}else {
				mc.closeBtn.visible = false;
			}
			
		}
		/**
		 * 是否允许打开关闭
		 * @param	boo
		 */
		public function setOpen(e:MouseEvent):void {
			if ((_openState != 2)&&_isControl) {
				GlobalData.hallInfo.ocRoomSite(teamid, index);
			}
		}
		public function removeMC():void {
			mc.closeBtn.removeEventListener(MouseEvent.CLICK, kickPlayer);
			this.removeEventListener(MouseEvent.CLICK, setOpen);
		}
		
		public function set isControl(boo:Boolean):void {
			mc.mc_close.visible = boo;
			if (_me == 1) mc.mc_close.visible = false;
			if(openState==2)mc.mc_close.visible = false;
			_isControl = boo;
		}
		public function get me():int {
			return _me;
		}
		public function get captain():int {
			return _captain;
		}
		public function get ready():int {
			return _ready;
		}
		/**
		 * 获取打开状态 0未打开1打开2有人
		 */
		public function get openState():int {
			return _openState;
		}
		
		public function get filter():GlowFilter {
			if (_filter == null) {
				_filter = new GlowFilter(0x00ff00,1,5,5,3);
			}
			return _filter;
		}
	}

}