package bajie.ui.hall
{

	import bajie.constData.CommonConfig;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.room.vo.RoomVO;
	import bajie.events.ParamEvent;
	import bajie.ui.createRoom.SelMapSubItem;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	
	import flashx.textLayout.formats.TextAlign;
	import bajie.constData.ModuleType;


	public class CreateRoomPanel extends MovieClip
	{
		//创建房间对象
		private var _roomInfo:RoomVO = new RoomVO;
		private var _createRoomPanel:*;


		
		public function CreateRoomPanel()
		{
			// constructor code
			_createRoomPanel = GlobalAPI.loaderAPI.getObjectByClassPath("CreateRoomPanel");
			addChild(_createRoomPanel);
			initEvent();
			initData();
		}
		
		private function initData():void
		{
			juniorLevelHandler(new MouseEvent("xx"));
			propModelHandler(new MouseEvent("xx"));
			_roomInfo.map = 1;
			_createRoomPanel.roomName.text = GlobalData.playerInfo.userVO.name + "的房间";
			trace(GlobalData.playerInfo.userVO.name + "的房间");
		}

		private function initEvent():void
		{
			_createRoomPanel.createPwdText.mouseEnabled = false;
			_createRoomPanel.classicModelBtn.buttonMode = true;
			_createRoomPanel.propModelBtn.buttonMode = true;
			_createRoomPanel.noPropModelBtn.buttonMode = true;
			_createRoomPanel.juniorLevel.buttonMode = true;
			_createRoomPanel.normalLevel.buttonMode = true;
			_createRoomPanel.highLevel.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, thisClickHandler);
			_createRoomPanel.closeBtn.addEventListener(MouseEvent.CLICK, closeHandler);
			//经典模式;
			_createRoomPanel.classicModelBtn.addEventListener(MouseEvent.CLICK, classicModelHandler);
			_createRoomPanel.classicModelBtn.addEventListener(MouseEvent.MOUSE_OVER, classicMouseOverHandler);
			_createRoomPanel.classicModelBtn.addEventListener(MouseEvent.MOUSE_OUT, classicMouseOutHandler);
			//道具模式;
			_createRoomPanel.propModelBtn.addEventListener(MouseEvent.CLICK, propModelHandler);
			_createRoomPanel.propModelBtn.addEventListener(MouseEvent.MOUSE_OVER, propMouseOverHandler);
			_createRoomPanel.propModelBtn.addEventListener(MouseEvent.MOUSE_OUT, propMouseOutHandler);
			//非道具模式;
			_createRoomPanel.noPropModelBtn.addEventListener(MouseEvent.CLICK, noPropModelHandler);
			_createRoomPanel.noPropModelBtn.addEventListener(MouseEvent.MOUSE_OVER, noPropMouseOverHandler);
			_createRoomPanel.noPropModelBtn.addEventListener(MouseEvent.MOUSE_OUT, noPropMouseOutHandler);
			//上一图
			_createRoomPanel.preMap.addEventListener(MouseEvent.CLICK, preMapHandler);
			//下一图
			_createRoomPanel.nexMap.addEventListener(MouseEvent.CLICK, nexMapHandler);
			//选择地图;
			_createRoomPanel.selectMap.gotoAndStop(1);
			_createRoomPanel.selectMap.addEventListener(MouseEvent.MOUSE_OVER, selectMapMouseOverHandler);
			_createRoomPanel.selectMap.addEventListener(MouseEvent.MOUSE_OUT, selectMapMouseOutHandler);

			_createRoomPanel.roomName.addEventListener(FocusEvent.FOCUS_IN, roomNameFocusInHandler);
			//创建密码复选框;
			_createRoomPanel.createPwdCheckBox.addEventListener(MouseEvent.CLICK, createPwdCheckBoxClickHandler);
			TextField(_createRoomPanel.createPwdText).mouseEnabled = false;
			_createRoomPanel.createPwdCheckBox.right.visible = false;
			//初级地图;
			_createRoomPanel.juniorLevel.addEventListener(MouseEvent.CLICK, juniorLevelHandler);
			_createRoomPanel.juniorLevel.addEventListener(MouseEvent.MOUSE_OVER, juniorLevelMouseOverHandler);
			_createRoomPanel.juniorLevel.addEventListener(MouseEvent.MOUSE_OUT, juniorLevelMouseOutHandler);
			//中级地图;
			_createRoomPanel.normalLevel.addEventListener(MouseEvent.CLICK, normalLevelHandler);
			_createRoomPanel.normalLevel.addEventListener(MouseEvent.MOUSE_OVER, normalLevelMouseOverHandler);
			_createRoomPanel.normalLevel.addEventListener(MouseEvent.MOUSE_OUT, normalLevelMouseOutHandler);
			//高级地图;
			_createRoomPanel.highLevel.addEventListener(MouseEvent.CLICK, highLevelHandler);
			_createRoomPanel.highLevel.addEventListener(MouseEvent.MOUSE_OVER, highLevelMouseOverHandler);
			_createRoomPanel.highLevel.addEventListener(MouseEvent.MOUSE_OUT, highLevelMouseOutHandler);

			_createRoomPanel.confirmBtn.addEventListener(MouseEvent.CLICK, confirmHandler);

			_createRoomPanel.cancelBtn.addEventListener(MouseEvent.CLICK, cancelBtnHandler);
		}

		private function removeEvent():void
		{
			this.removeEventListener(MouseEvent.CLICK, thisClickHandler);
			_createRoomPanel.closeBtn.removeEventListener(MouseEvent.CLICK, closeHandler);
			//经典模式;3
			_createRoomPanel.classicModelBtn.removeEventListener(MouseEvent.CLICK, classicModelHandler);
			_createRoomPanel.classicModelBtn.removeEventListener(MouseEvent.MOUSE_OVER, classicMouseOverHandler);
			_createRoomPanel.classicModelBtn.removeEventListener(MouseEvent.MOUSE_OUT, classicMouseOutHandler);
			//道具模式;1
			_createRoomPanel.propModelBtn.removeEventListener(MouseEvent.CLICK, propModelHandler);
			_createRoomPanel.propModelBtn.removeEventListener(MouseEvent.MOUSE_OVER, propMouseOverHandler);
			_createRoomPanel.propModelBtn.removeEventListener(MouseEvent.MOUSE_OUT, propMouseOutHandler);
			//非道具模式;2
			_createRoomPanel.noPropModelBtn.removeEventListener(MouseEvent.CLICK, noPropModelHandler);
			_createRoomPanel.noPropModelBtn.removeEventListener(MouseEvent.MOUSE_OVER, noPropMouseOverHandler);
			_createRoomPanel.noPropModelBtn.removeEventListener(MouseEvent.MOUSE_OUT, noPropMouseOutHandler);
			
			//上一图
			_createRoomPanel.preMap.removeEventListener(MouseEvent.CLICK, preMapHandler);
			//下一图
			_createRoomPanel.nexMap.removeEventListener(MouseEvent.CLICK, nexMapHandler);
			
			//选择地图;
			
			_createRoomPanel.selectMap.removeEventListener(MouseEvent.MOUSE_OVER, selectMapMouseOverHandler);
			_createRoomPanel.selectMap.removeEventListener(MouseEvent.MOUSE_OUT, selectMapMouseOutHandler);

			_createRoomPanel.roomName.removeEventListener(FocusEvent.FOCUS_IN, roomNameFocusInHandler);
			//创建密码复选框;
			_createRoomPanel.createPwdCheckBox.removeEventListener(MouseEvent.CLICK, createPwdCheckBoxClickHandler);

			//初级地图;
			_createRoomPanel.juniorLevel.removeEventListener(MouseEvent.CLICK, juniorLevelHandler);
			_createRoomPanel.juniorLevel.removeEventListener(MouseEvent.MOUSE_OVER, juniorLevelMouseOverHandler);
			_createRoomPanel.juniorLevel.removeEventListener(MouseEvent.MOUSE_OUT, juniorLevelMouseOutHandler);
			//中级地图;
			_createRoomPanel.normalLevel.removeEventListener(MouseEvent.CLICK, normalLevelHandler);
			_createRoomPanel.normalLevel.removeEventListener(MouseEvent.MOUSE_OVER, normalLevelMouseOverHandler);
			_createRoomPanel.normalLevel.removeEventListener(MouseEvent.MOUSE_OUT, normalLevelMouseOutHandler);
			//高级地图;
			_createRoomPanel.highLevel.removeEventListener(MouseEvent.CLICK, highLevelHandler);
			_createRoomPanel.highLevel.removeEventListener(MouseEvent.MOUSE_OVER, highLevelMouseOverHandler);
			_createRoomPanel.highLevel.removeEventListener(MouseEvent.MOUSE_OUT, highLevelMouseOutHandler);

			_createRoomPanel.confirmBtn.removeEventListener(MouseEvent.CLICK, confirmHandler);
			_createRoomPanel.cancelBtn.removeEventListener(MouseEvent.CLICK, cancelBtnHandler);
		}

		private function preMapHandler(e:MouseEvent):void
		{
			_roomInfo.map = 1;
		}
		
		private function nexMapHandler(e:MouseEvent):void
		{
			_roomInfo.map = 1;
		}
		
		private function roomNameFocusInHandler(e:FocusEvent):void
		{
//			_createRoomPanel.roomName.setSelection(_createRoomPanel.roomName.selectionBeginIndex, _createRoomPanel.roomName.selectionEndIndex);
//			if(GlobalData.playerInfo.userVO.name == "" || GlobalData.playerInfo.userVO.name == null)
//			{
//				_createRoomPanel.roomName.text = "开始战斗吧";
//			}
//			else
//			{
//				_createRoomPanel.roomName.text = GlobalData.playerInfo.userVO.name + "的房间";
//			}
			_createRoomPanel.roomName.text = "";
		}

		private function thisClickHandler(e:MouseEvent):void
		{
			selectMapMouseOutHandler(e);
			e.stopImmediatePropagation();
		}

		private function closeHandler(e:MouseEvent):void
		{
			removeEvent();
			SetModuleUtils.removeModule(this, ModuleType.CREATE_ROOM);
		}
		

		//经典模式--------------------------begin-----------
		private function classicModelHandler(e:MouseEvent):void
		{
			_roomInfo.mode = CommonConfig.CLASSIC_ROOM;
			_createRoomPanel.classicModelBtn.gotoAndStop(3);
			_createRoomPanel.propModelBtn.gotoAndStop(1);
			_createRoomPanel.noPropModelBtn.gotoAndStop(1);
			if(_roomInfo.mode != 0)
			{
				_createRoomPanel.classicModelBtn.removeEventListener(MouseEvent.MOUSE_OVER, classicMouseOverHandler);
				_createRoomPanel.classicModelBtn.removeEventListener(MouseEvent.MOUSE_OUT, classicMouseOutHandler);
				
				if(!_createRoomPanel.propModelBtn.hasEventListener(MouseEvent.MOUSE_OVER))
					_createRoomPanel.propModelBtn.addEventListener(MouseEvent.MOUSE_OVER, propMouseOverHandler);
				
				if(!_createRoomPanel.propModelBtn.hasEventListener(MouseEvent.MOUSE_OUT))
					_createRoomPanel.propModelBtn.addEventListener(MouseEvent.MOUSE_OUT, propMouseOutHandler);
				
				if(!_createRoomPanel.noPropModelBtn.hasEventListener(MouseEvent.MOUSE_OVER))
					_createRoomPanel.noPropModelBtn.addEventListener(MouseEvent.MOUSE_OVER, noPropMouseOverHandler);
				if(!_createRoomPanel.noPropModelBtn.hasEventListener(MouseEvent.MOUSE_OUT))
					_createRoomPanel.noPropModelBtn.addEventListener(MouseEvent.MOUSE_OUT, noPropMouseOutHandler);
			}
		}

		private function classicMouseOverHandler(e:MouseEvent):void
		{
			_createRoomPanel.classicModelBtn.gotoAndStop(2);
		}

		private function classicMouseOutHandler(e:MouseEvent):void
		{
			_createRoomPanel.classicModelBtn.gotoAndStop(1);
		}
		//经典模式--------------------------end--------------

		//道具模式--------------------------begin------------
		private function propModelHandler(e:MouseEvent):void
		{
			_roomInfo.mode = CommonConfig.PROP_ROOM;
			_createRoomPanel.classicModelBtn.gotoAndStop(1);
			_createRoomPanel.propModelBtn.gotoAndStop(3);
			_createRoomPanel.noPropModelBtn.gotoAndStop(1);
			if(_roomInfo.mode != 0)
			{
				_createRoomPanel.propModelBtn.removeEventListener(MouseEvent.MOUSE_OVER, propMouseOverHandler);
				_createRoomPanel.propModelBtn.removeEventListener(MouseEvent.MOUSE_OUT, propMouseOutHandler);
				
				if(!_createRoomPanel.classicModelBtn.hasEventListener(MouseEvent.MOUSE_OVER))
					_createRoomPanel.classicModelBtn.addEventListener(MouseEvent.MOUSE_OVER, classicMouseOverHandler);
				if(!_createRoomPanel.classicModelBtn.hasEventListener(MouseEvent.MOUSE_OUT))
					_createRoomPanel.classicModelBtn.addEventListener(MouseEvent.MOUSE_OUT, classicMouseOutHandler);
				if(!_createRoomPanel.noPropModelBtn.hasEventListener(MouseEvent.MOUSE_OVER))
					_createRoomPanel.noPropModelBtn.addEventListener(MouseEvent.MOUSE_OVER, noPropMouseOverHandler);
				if(!_createRoomPanel.noPropModelBtn.hasEventListener(MouseEvent.MOUSE_OUT))
					_createRoomPanel.noPropModelBtn.addEventListener(MouseEvent.MOUSE_OUT, noPropMouseOutHandler);
			}
		}

		private function propMouseOverHandler(e:MouseEvent):void
		{
			_createRoomPanel.propModelBtn.gotoAndStop(2);
		}

		private function propMouseOutHandler(e:MouseEvent):void
		{
			_createRoomPanel.propModelBtn.gotoAndStop(1);
		}
		//道具模式--------------------------end-------------

		//非道具模式-----------------------begin------------
		private function noPropModelHandler(e:MouseEvent):void
		{
			_roomInfo.mode = CommonConfig.NO_PROP_ROOM;
			_createRoomPanel.classicModelBtn.gotoAndStop(1);
			_createRoomPanel.propModelBtn.gotoAndStop(1);
			_createRoomPanel.noPropModelBtn.gotoAndStop(3);
			if(_roomInfo.mode != 0)
			{
				_createRoomPanel.noPropModelBtn.removeEventListener(MouseEvent.MOUSE_OVER, noPropMouseOverHandler);
				_createRoomPanel.noPropModelBtn.removeEventListener(MouseEvent.MOUSE_OUT, noPropMouseOutHandler);
				
				if(!_createRoomPanel.classicModelBtn.hasEventListener(MouseEvent.MOUSE_OVER))
					_createRoomPanel.classicModelBtn.addEventListener(MouseEvent.MOUSE_OVER, classicMouseOverHandler);
				if(!_createRoomPanel.classicModelBtn.hasEventListener(MouseEvent.MOUSE_OUT))
					_createRoomPanel.classicModelBtn.addEventListener(MouseEvent.MOUSE_OUT, classicMouseOutHandler);
				if(!_createRoomPanel.propModelBtn.hasEventListener(MouseEvent.MOUSE_OVER))
					_createRoomPanel.propModelBtn.addEventListener(MouseEvent.MOUSE_OVER, propMouseOverHandler);
				if(!_createRoomPanel.propModelBtn.hasEventListener(MouseEvent.MOUSE_OUT))
					_createRoomPanel.propModelBtn.addEventListener(MouseEvent.MOUSE_OUT, propMouseOutHandler);
			}
		}

		private function noPropMouseOverHandler(e:MouseEvent):void
		{
			_createRoomPanel.noPropModelBtn.gotoAndStop(2);
		}

		private function noPropMouseOutHandler(e:MouseEvent):void
		{
			_createRoomPanel.noPropModelBtn.gotoAndStop(1);
		}
		//非道具模式----------------------end---------------

		private function selectMapMouseOverHandler(e:MouseEvent):void
		{
			_createRoomPanel.selectMap.gotoAndStop(2);
		}

		private function selectMapMouseOutHandler(e:MouseEvent):void
		{
			_createRoomPanel.selectMap.gotoAndStop(1);
		}

		//选择地图-------------------------end----------------------

		//创建密码checkbox------------------begin-------------------
		private var pwdEnable:Boolean = false;
		private function createPwdCheckBoxClickHandler(e:MouseEvent):void
		{
			pwdEnable = !pwdEnable;
			_createRoomPanel.createPwdCheckBox.right.visible = pwdEnable;
			TextField(_createRoomPanel.createPwdText).mouseEnabled = pwdEnable;	
			if(pwdEnable)
			{
				TextField(_createRoomPanel.createPwdText).setSelection(TextField(_createRoomPanel.createPwdText).selectionBeginIndex, TextField(_createRoomPanel.createPwdText).selectionEndIndex);
				_createRoomPanel.createPwdText.text = "";
			}
			else TextField(_createRoomPanel.createPwdText).text = "";
		}
		//创建密码checkbox-----------------end---------------------

		//初级地图按钮---------------------begin-------------------
		private function juniorLevelHandler(e:MouseEvent):void
		{
			_roomInfo.grade = CommonConfig.JUNIOR_LEVEL;
			_createRoomPanel.juniorLevel.check.gotoAndStop(2);
			_createRoomPanel.normalLevel.check.gotoAndStop(1);
			_createRoomPanel.highLevel.check.gotoAndStop(1);
		}

		private function juniorLevelMouseOverHandler(e:MouseEvent):void
		{

		}

		private function juniorLevelMouseOutHandler(e:MouseEvent):void
		{

		}
		//初级地图按钮-------------------end-----------------------

		//中级地图按钮-------------------begin---------------------
		private function normalLevelHandler(e:MouseEvent):void
		{
			_roomInfo.grade = CommonConfig.NORMAL_LEVEL;
			_createRoomPanel.juniorLevel.check.gotoAndStop(1);
			_createRoomPanel.normalLevel.check.gotoAndStop(2);
			_createRoomPanel.highLevel.check.gotoAndStop(1);
		}

		private function normalLevelMouseOverHandler(e:MouseEvent):void
		{

		}

		private function normalLevelMouseOutHandler(e:MouseEvent):void
		{

		}
		//中级地图按钮------------------end-----------------------

		//高级地图按钮------------------begin---------------------
		private function highLevelHandler(e:MouseEvent):void
		{
			_roomInfo.grade = CommonConfig.HIGH_LEVEL;
			_createRoomPanel.juniorLevel.check.gotoAndStop(1);
			_createRoomPanel.normalLevel.check.gotoAndStop(1);
			_createRoomPanel.highLevel.check.gotoAndStop(2);
		}

		private function highLevelMouseOverHandler(e:MouseEvent):void
		{

		}

		private function highLevelMouseOutHandler(e:MouseEvent):void
		{

		}
		//高级地图按钮-------------------end---------------------

		//确认--------------------------begin-------------------
		private function confirmHandler(e:MouseEvent):void
		{
			if(_createRoomPanel.roomName.text != "")
			{
				_roomInfo.name = _createRoomPanel.roomName.text;
				_roomInfo.password = _createRoomPanel.createPwdText.text;
			
				GlobalData.hallInfo.createRoom(_roomInfo);
				closeHandler(e);
			} 
			
		}
		//确认------------------------end------------------------

		//取消-----------------------begin-----------------------
		private function cancelBtnHandler(e:MouseEvent):void
		{
			closeHandler(e);
		}
		//取消-----------------------end------------------------

	}
}