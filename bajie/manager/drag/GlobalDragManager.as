package bajie.manager.drag
{
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.drag.GlobalDragItemInfo;
	import bajie.events.BajieDispatcher;
	import bajie.ui.base.item.BaseItem;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.display.DisplayObject;

	/**
	全局拖拽管理
	*/
	public class GlobalDragManager
	{
		public static const ITEM_DRAG_TO:String = "ITEM_DRAG_TO";
		private static var _g_globalDragItemInfo:GlobalDragItemInfo;//全局拖拽对象信息的存储结构
		private var _m_dragBoxDic:Dictionary;//存贮遍历对象队列的结构
		private var _m_dispatcher:BajieDispatcher;//全局事件接受派发
		private var _m_stage:Stage;	//鼠标监控对象
		private var _m_moveSprite:Sprite;//全局拖拽组件
		private static var _instance:GlobalDragManager;
		
		public static function init(stag:Stage):void
		{
			if(_instance == null)
				_instance = new GlobalDragManager(stag);
		}
		
		public static function getInstance():GlobalDragManager
		{
			return _instance;
		}
		
		
		
		public function GlobalDragManager(stag:Stage)
		{
			_m_stage = stag;
			_g_globalDragItemInfo = new GlobalDragItemInfo;
			_m_dispatcher = BajieDispatcher.getInstance();
			
			_m_dragBoxDic = new Dictionary;
		}
		
		public function startDragItem(e:MouseEvent, obj:Object):void
		{
			if(!(obj is BaseItem))
			{
				return;
			}
			var gridObj:BaseItem = BaseItem(obj);
			//遍历队列进行判断
			if(!isObjInList(gridObj))
			{
				return;
			}
			
			//记录拖拽的图标
			_g_globalDragItemInfo.dragSrcPosX = e.stageX;
			_g_globalDragItemInfo.dragSrcPosY = e.stageY;
			
			_g_globalDragItemInfo.dragSrcType = gridObj.itemType;
			_g_globalDragItemInfo.dragSrcObj = gridObj;
			
			_g_globalDragItemInfo.dragTagObj = null;
			_g_globalDragItemInfo.dragTagType = -1;
			_g_globalDragItemInfo.dragTagPosX = 0;
			_g_globalDragItemInfo.dragTagPosY = 0;
			
			_g_globalDragItemInfo.dragStartMove = false;
			
			//添加stage事件监听
			_m_stage.addEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
			_m_stage.addEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
		}
		
		/**
		 *注册可开始的以及接受拖拽消息处理的对象 
		 * @param obj 需要注册的对象
		 * 
		 */		
		public function registerDragBox(obj:Object):void
		{
			if(obj is BaseItem)
			{
				var tempGrid:BaseItem = BaseItem(obj);
				
				var array:Array = [];
				if(_m_dragBoxDic[tempGrid.itemBaseType] == null)
				{
					_m_dragBoxDic[tempGrid.itemBaseType] = array;
				}
				else
				{
					array = _m_dragBoxDic[tempGrid.itemBaseType];
				}
				
				//将对象注册到队列中
				array.push(obj);
			}
		}
		
		/**
		 * 从注册队列中删除指定对象
		 * */
		public function disRegisterDragBox(obj:Object):void
		{
			if(obj is BaseItem)
			{
				onDelObjInList(BaseItem(obj));
			}
		}
		/**
		 *判断某一对象是否在注册队列中
		 * @param ojb
		 * @return 
		 */		
		private function isObjInList(obj:BaseItem):Boolean
		{
			var isInList:Boolean = false;
			if(_m_dragBoxDic[obj.itemBaseType] == null)
			{
				isInList = false;
			}
			else
			{
				for(var key:* in _m_dragBoxDic)
				{
					//获取对应类型队列
					var array:Array = _m_dragBoxDic[obj.itemBaseType];
					
					for(var i:int = 0; i < array.length; i++)
					{
						if(array[i] == obj)
							return true;
					}
				}
			}
			return isInList;
		}
		
		private function onDelObjInList(obj:BaseItem):void
		{
			if(_m_dragBoxDic[obj.itemBaseType] == null)
				return;
			else
			{
				//获取对应类型队列
				var array:Array = _m_dragBoxDic[obj.itemBaseType];
				
				for(var i:int = array.length; i > 0; i--)
				{
					if(array[i - 1] == obj)
						array.splice(i - 1, 1);
				}
			}
		}
		
		//消息处理函数---------------------------------------------------------------------------------------------------------
		//处理stage鼠标释放消息
		private function _onStageMouseUp(e:MouseEvent):void
		{
			_m_stage.removeEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
			_m_stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
			
			//判断移动物品对象存在时移出移动对象
			if(null != _m_moveSprite && null != _m_moveSprite.parent)
			{
				_m_moveSprite.visible = false;
				_m_moveSprite.parent.removeChild(_m_moveSprite);
				GlobalAPI.layerManager.getModuleLayer().mouseEnabled = true;
			}
			
			//判断事件父亲节点间指定类自雷的对象或未开始拖拽时
			if(!(e.target is DisplayObject) || !_g_globalDragItemInfo.dragStartMove)
			{
				return;
			}
			
			var tempObj:DisplayObject = DisplayObject(e.target);
			while(tempObj != null)
			{
				//判断到准确类型后返回
				if(tempObj is BaseItem)
				{
					break;
				}
				
				if(tempObj == GlobalAPI.layerManager.getModuleLayer())
				{
					break;
				}
				tempObj = tempObj.parent;
			}
			
			//对拖拽开始对象进行处理
			BaseItem(_g_globalDragItemInfo.dragSrcObj).endDragMove(_g_globalDragItemInfo);
			
			if(tempObj != null && tempObj == GlobalAPI.layerManager.getModuleLayer())
			{
				_g_globalDragItemInfo.dragTagObj = null;
				_g_globalDragItemInfo.dragTagType = -1;
				_g_globalDragItemInfo.dragTagPosX = e.stageX;
				_g_globalDragItemInfo.dragTagPosY = e.stageY;
			}
			//对象不在队列中
			if(null == tempObj && isObjInList(BaseItem(tempObj)))
			{
				//设置拖拽处理对象结构体
				_g_globalDragItemInfo.dragTagObj = null;
				_g_globalDragItemInfo.dragTagType = -1;
				_g_globalDragItemInfo.dragTagPosX = e.stageX;
				_g_globalDragItemInfo.dragTagPosY = e.stageY;
				
				BaseItem(_g_globalDragItemInfo.dragSrcObj).dragOut(_g_globalDragItemInfo);
				return;
			}
			else
			{
				//设置拖拽处理对象结构体
				_g_globalDragItemInfo.dragTagObj = tempObj;
				_g_globalDragItemInfo.dragTagType = BaseItem(tempObj).itemType;
				_g_globalDragItemInfo.dragTagPosX = e.stageX;
				_g_globalDragItemInfo.dragTagPosY = e.stageY;
				
				//执行拖拽某一对象时源对象的操作
				BaseItem(_g_globalDragItemInfo.dragSrcObj).dragToGrid(_g_globalDragItemInfo);
				
				//对拖拽目标对象进行处理
				BaseItem(_g_globalDragItemInfo.dragTagObj).acceptDrag(_g_globalDragItemInfo);
			}
			
		}
		
		/**
		 *处理stage鼠标移动消息 
		 */		
		private function _onStageMouseMove(e:MouseEvent):void
		{
			var tempObj:DisplayObject = DisplayObject(e.target);
			if(!_g_globalDragItemInfo.dragStartMove 
				&& (Math.abs(e.stageX - _g_globalDragItemInfo.dragSrcPosX) > 5
				|| Math.abs(e.stageY - _g_globalDragItemInfo.dragSrcPosY) > 5))
			{
				//设置全局判断拖拽是否移动的参数
				_g_globalDragItemInfo.dragStartMove = true;
				
				//当移动范围超出一定限制时, 执行开始拖拽移动的函数
				BaseItem(_g_globalDragItemInfo.dragSrcObj).startDragMove(_g_globalDragItemInfo);
				//在拖拽过程中, 需要绘制拖拽对象的图片
				var grid:BaseItem = BaseItem(_g_globalDragItemInfo.dragSrcObj);
				_m_moveSprite = grid.dragSprite();
				
				//将可移动的组件显示在顶层
				if(null != _m_moveSprite)
				{
					GlobalData.layer.addChild(_m_moveSprite);
					_m_moveSprite.mouseEnabled = _m_moveSprite.mouseChildren = false;
					GlobalAPI.layerManager.getModuleLayer().mouseEnabled = false;
				}
			}
			if(null != _m_moveSprite)
			{
				_m_moveSprite.x = e.stageX - (_m_moveSprite.width / 2);
				_m_moveSprite.y = e.stageY - (_m_moveSprite.height / 2);
			}
		}
	}
}