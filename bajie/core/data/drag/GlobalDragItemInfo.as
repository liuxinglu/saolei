package bajie.core.data.drag {
	
	public class GlobalDragItemInfo {
		public var dragSrcType:int;//拖拽对象的类型
		public var dragSrcObj:Object;//开始拖拽对象
		public var dragSrcPosX:int;//开始拖拽的x坐标
		public var dragSrcPosY:int;//开始拖拽的y坐标
		
		public var dragTagType:int;//拖拽结束的对象类型
		public var dragTagPosX:int;//结束拖拽的x坐标
		public var dragTagPosY:int;//结束拖拽的y坐标
		public var dragTagObj:Object;//拖拽结束的对象

		public var dragStartMove:Boolean;	//是否确认开始进行拖放操作
		public function GlobalDragItemInfo() {
			// constructor code
		}

	}
	
}
