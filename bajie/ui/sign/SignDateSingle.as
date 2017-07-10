package bajie.ui.sign 
{
	import flash.display.MovieClip;
	import bajie.core.data.GlobalAPI;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class SignDateSingle extends MovieClip 
	{
		private var dateMC:*;
		public var year:int = -1;
		public var month:int = -1;
		public var day:int = -1;
		/**
		 * 是否可以补签
		 */
		public var enableRemedy:Boolean;
		public function SignDateSingle() 
		{
			dateMC = GlobalAPI.loaderAPI.getObjectByClassPath("dateMc");;
			addChild(dateMC);
			dateMC.gotoAndStop(1);
			this.mouseChildren = false;
			
			setDate();
			selected = false;
		}
		/**
		 * 日期的状态 1不在本月2本月工作日3本月周末日
		 */
		private function set dayState(value:int):void {
			dateMC.gotoAndStop(value);
			if (value == 1) {
				this.mouseEnabled = false;
				this.buttonMode = false;
				dateMC.txt_date.textColor = 0x000000;
			}else {
				this.mouseEnabled = true;
				this.buttonMode = true;
				if (value == 2) dateMC.txt_date.textColor = 0x000000;
				if (value == 3) dateMC.txt_date.textColor = 0xff0000;
				
			}
		}
		public function set selected(boo:Boolean):void {
			dateMC.selectedMC.visible = boo;
		}
		public function set signOn(boo:Boolean):void {
			dateMC.signOn.visible = boo;
			if (boo) dateMC.txt_date.text = "";
		}
		/**
		 * 设置日期显示
		 * @param	state  是否为当前月日期
		 * @param	boo	 是否为当前月份日期
		 */
		public function setDate(tmpDate:int = -1, tmpMonth:int = -1, tmpYear:int = -1,state:Boolean=false):void {
			if (tmpDate == -1||tmpMonth==-1||tmpYear==-1) {
				dayState = 1;
				dateMC.txt_date.text = "";
			}else {
				dateMC.txt_date.text = tmpDate.toString();
				if (!state) {
					dayState = 1;
				}
				else {
					var tmpday:Date = new Date(tmpYear, tmpMonth, tmpDate);
					if (tmpday.getDay() == 0 || tmpday.getDay() == 6) dayState = 3;
					else dayState = 2;
				}
				year = tmpYear;
				month = tmpMonth;
				day = tmpDate;
			}
			signOn = false;
			enableRemedy = false;
		}
	}

}