package bajie.ui.friends 
{
	import bajie.ui.menu.PopMenuGroup;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.events.ParamEvent;
	import bajie.utils.module.SetModuleUtils;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.greensock.easing.*;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class Friends extends MovieClip 
	{
		private var ui:*;
		
		private var _style:int;
		//好友的页数
		private var _index:int = 1;
		private var _total:int = 1;
		
		private var friends:Array = [];
		private const friendNum:int = 7;
		
		private var opened:Boolean = false;
		private var addFriendsPan:AddFriends;
		public function Friends() 
		{
			ui = GlobalAPI.loaderAPI.getObjectByClassPath("friendsPan");
			addChild(ui);
			
			addEventListener(Event.ADDED_TO_STAGE, initEvent);
		}
		private function initEvent(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, initEvent);
			for (var i:int = 0; i < friendNum;i++ ) {
				var _friend:FriendList = new FriendList();
				ui["friends" + i].addChild(_friend);
				_friend.mouseEnabled = false;
				_friend.mouseChildren = false;
				_friend.visible = false;
				friends.push(_friend);
				
				ui["friends" + i].mouseEnabled = false;
				ui["friends" + i].addEventListener(MouseEvent.CLICK,onMenu);
			}
			setLableState();
			
			GlobalData.friendsInfo.addEventListener(ParamEvent.GET_FRIENDS_LIST, updateFriendsList);
			GlobalData.friendsInfo.addEventListener(ParamEvent.GET_BLACK_LIST, updateBlackList);
			ui.btn_lable1.addEventListener(MouseEvent.CLICK, flipHandler);
			ui.btn_lable2.addEventListener(MouseEvent.CLICK, flipHandler);
			ui.btn_pageUp.addEventListener(MouseEvent.CLICK, flipHandler);
			ui.btn_pageDown.addEventListener(MouseEvent.CLICK, flipHandler);
			ui.btn_addFriend.addEventListener(MouseEvent.CLICK, addFriend);
			ui.btn_invite.addEventListener(MouseEvent.CLICK, inviteFriend);
			ui.btn_close.addEventListener(MouseEvent.CLICK, removeAnimation);
			
			GlobalData.friendsInfo.getFriendList(1);
			
			SetModuleUtils.removeLoading();
		}
		public function setVisible():void {
			this.visible = true;
			SetModuleUtils.setModuleTop(this);
			TweenLite.to(this, .5, {x:705,ease:Back.easeOut} );
		}
		/**
		 * 弹出菜单事件
		 * @param	e
		 */
		private function onMenu(e:MouseEvent):void {
			
		}
		/**
		 * 翻页按钮事件
		 */
		private function flipHandler(e:MouseEvent):void {
			switch(e.currentTarget.name) {
				case "btn_lable1":
					GlobalData.friendsInfo.getFriendList(1);
					break;
				case "btn_lable2":
					GlobalData.friendsInfo.getBlackList(1);
					break;
				case "btn_pageDown":
					if (_index<_total) {
						if (_style==1) {
							GlobalData.friendsInfo.getFriendList(_index+1);
						}else {
							GlobalData.friendsInfo.getBlackList(_index+1);
						}
					}
					break;
				case "btn_pageUp":
					if (_index>1) {
						if (_style==1) {
							GlobalData.friendsInfo.getFriendList(_index-1);
						}else {
							GlobalData.friendsInfo.getBlackList(_index-1);
						}
					}
					break;
			}
			
		}
		private function updateFriendsList(e:ParamEvent):void {	
			var o:Object = e.Param;
			_style = 1;
			setLableState();
			updateListInfo(o);
		}
		private function updateBlackList(e:ParamEvent):void {
			var o:Object = e.Param;
			_style = 2;
			setLableState();
			updateListInfo(o);
		}
		/**
		 * 更新列表信息
		 * @param	o
		 */
		private function updateListInfo(o:Object):void {
			_index = o.index;
			_total = o.total;
			ui.txt_page.text = _index + "/" + _total;
			
			var _list:Array = o.items as Array;
			for (var i:int = 0; i < friendNum;i++ ) {
				if (_list[i]) {
					friends[i].updateInfo(_list[i]);
					friends[i].visible = true;
					ui["friends" + i].mouseEnabled = true;
				}
				else {
					friends[i].visible = false;
					ui["friends" + i].mouseEnabled = false;
				}
			}
		}
		/**
		 * 添加好友
		 */
		private function addFriend(e:MouseEvent):void {
			var addFriendsPan:AddFriends = new AddFriends();
			SetModuleUtils.addModule(addFriendsPan, null, true, false, ModuleType.ADD_FRIEND);
		}
		/**
		 * 邀请好友
		 */
		private function inviteFriend(e:MouseEvent):void {
			
		}
		/**
		 * 设置标签页的按钮的可点状态
		 */
		private function setLableState():void {
			if (_style == 1) {
				ui.btn_lable1.mouseEnabled = false;
				ui.btn_lable2.mouseEnabled = true;
				ui.lable.gotoAndStop(1);
			}else {
				ui.btn_lable1.mouseEnabled = true;
				ui.btn_lable2.mouseEnabled = false;
				ui.lable.gotoAndStop(2);
			}
		}
		private function removeAnimation(e:MouseEvent = null):void {
			TweenLite.to(this, .5, {x:970,ease:Back.easeIn,onComplete:movePanel});
		}
		private function movePanel():void {
			this.visible = false;
		}
		public function removeMC():void {
			GlobalData.friendsInfo.removeEventListener(ParamEvent.GET_FRIENDS_LIST, updateFriendsList);
			GlobalData.friendsInfo.removeEventListener(ParamEvent.GET_BLACK_LIST, updateBlackList);
			ui.btn_lable1.removeEventListener(MouseEvent.CLICK, flipHandler);
			ui.btn_lable2.removeEventListener(MouseEvent.CLICK, flipHandler);
			ui.btn_pageUp.removeEventListener(MouseEvent.CLICK, flipHandler);
			ui.btn_pageDown.removeEventListener(MouseEvent.CLICK, flipHandler);
			ui.btn_addFriend.removeEventListener(MouseEvent.CLICK, addFriend);
			ui.btn_invite.removeEventListener(MouseEvent.CLICK, inviteFriend);
			ui.btn_close.removeEventListener(MouseEvent.CLICK, removeMC);
			
			
			for (var i:int = 0; i < friendNum;i++ ) {
				friends[i].removeMC();
				ui["friends" + i].removeEventListener(MouseEvent.CLICK,onMenu);
			}
			friends = null;
			SetModuleUtils.removeModule(this, ModuleType.FRIENDS);
		}
	}

}