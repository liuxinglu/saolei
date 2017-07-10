package bajie.events {
	
	public class GridEvent extends ParamEvent
	{
		/**
		左键弹起
		*/
		public static const LEFT_UP:String = "LEFT_CLICK";
		
		/**
		 *右键标记 
		 */		
		public static const RIGHT_MARK:String = "RIGHT_MARK";
		
		/**
		 *右键怀疑 
		 */		
		public static const RIGHT_DISTRUST:String = "RIGHT_DISTRUST";		
		/**
		 *右键怀疑 
		 */		
		public static const RIGHT_UNDISTRUST:String = "RIGHT_UNDISTRUST";
		
		/**
		 *左键双击 
		 */		
		public static const DOUBLE_CLICK:String = "DOUBLE_CLICK";
		
		
		public function GridEvent(type:String, param:Object = null, bubbles:Boolean = false, cancelEnable:Boolean = false) {
			// constructor code
			super(type, param, 0, bubbles, cancelEnable);
		}
	}
	
}
