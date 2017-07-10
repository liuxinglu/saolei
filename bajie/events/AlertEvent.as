package bajie.events
{
	
	public class AlertEvent extends ParamEvent
	{
		public static const SUBMIT:String = "submit";
		public static const CANCEL:String = "cancel";
		public static const CLOSE:String = "close";
		public static const NORMAL_CLOSE:String = "normal_close";
		public static const FAIL_CLOSE:String = "FAIL_CLOSE";
		
		public function AlertEvent(type:String, param:Object = null, bubbles:Boolean = false, cancelEnable:Boolean = false) {
			// constructor code
			super(type, param, 0, bubbles, cancelEnable);
		}
	}
}