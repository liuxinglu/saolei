package bajie.ui.sign
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import bajie.ui.sign.SignDateSingle;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class SignDateGird extends MovieClip
	{
		private var row:int = 6;
		private var col:int = 7;
		
		private var _curDay:Date;
		private var _today:Date;
		
		private var dateArr:Array = [];
		
		//补签的回调函数
		private var _remedySignCallBack:Function;
		
		public function SignDateGird()
		{
			_curDay = new Date();
			initGird();
		}
		
		private function initGird():void
		{
			for (var i:int = 0; i < row; i++)
			{
				for (var j:int = 0; j < col; j++)
				{
					var singleDate:SignDateSingle = new SignDateSingle();
					this.addChild(singleDate);
					singleDate.addEventListener(MouseEvent.CLICK, clickDate);
					dateArr.push(singleDate);
					singleDate.x = 60 * j;
					singleDate.y = 23 * i;
				}
			}
		}
		
		/**
		 * 更新日历数据
		 */
		public function updateDate(o:Object):void
		{
			if (curSel)
			{
				curSel.selected = false;
				curSel = null;
			}
			
			_curDay = new Date(o.year, o.month - 1, 1); //当前要显示的日期对象
			var _startIndex:int = _curDay.getDay(); //起始日期的位置
			
			var _curYear:int = _curDay.getFullYear();
			var _curMonth:int = _curDay.getMonth();
			var _day_in_month:int = o.signlist.length;
			
			Number(o.today.substring(0, 4))
			_today = new Date(Number(o.today.substring(0, 4)), Number(o.today.substring(4, 6)) - 1, Number(o.today.substring(6, 8)));
			var _todayIndex:int = _today.getDate() + _startIndex - 1;
			
			//charAt();
			var len:int = dateArr.length;
			for (var i:int = 0; i < len; i++)
			{
				if ((i < _startIndex) || (i > (_startIndex + _day_in_month - 1)))
				{
					dateArr[i].setDate();
				}
				else
				{
					if (_curYear < _today.getFullYear())
					{
						dateArr[i].setDate(i - _startIndex + 1, _curMonth, _curYear, true);
						dateArr[i].enableRemedy = true; //设置可以补签
					}
					else
					{
						if (_curMonth < _today.getMonth())
						{
							dateArr[i].setDate(i - _startIndex + 1, _curMonth, _curYear, true);
							dateArr[i].enableRemedy = true; //设置可以补签
						}
						else
						{
							if (i < _today.getDate() + _startIndex)
							{
								dateArr[i].setDate(i - _startIndex + 1, _curMonth, _curYear, true);
								dateArr[i].enableRemedy = true; //设置可以补签
							}
							else
							{
								dateArr[i].setDate(i - _startIndex + 1, _curMonth, _curYear, false);
								dateArr[i].enableRemedy = false; //设置不可以补签
							}
						}
					}
				}
				if (o.signlist.charAt(i - _startIndex) == 1)
				{
					dateArr[i].signOn = true;
					dateArr[i].enableRemedy = false; //已经签到，不可补签
				}
				else
				{
					dateArr[i].signOn = false;
				}
			}
			dateArr[_todayIndex].enableRemedy = false;
			
			_remedySignCallBack(null);
		}
		/**
		 * 当前选中的日期
		 */
		private var curSel:SignDateSingle;
		
		/**
		 * 点击日期事件
		 * @param	e
		 */
		private function clickDate(e:MouseEvent):void
		{
			if (curSel)
			{
				curSel.selected = false;
			}
			e.currentTarget.selected = true;
			curSel = e.currentTarget as SignDateSingle;
			
			_remedySignCallBack(curSel);
		}
		
		/**
		 * 选择的日期
		 */
		public function get selectDate():SignDateSingle
		{
			if (curSel)
				return curSel;
			else
				return null;
		
		}
		
		public function getRemedySignState(fun:Function):void
		{
			_remedySignCallBack = fun;
		}
		
		/**
		 * 当前月数的时间
		 */
		public function get curDate():Date
		{
			return _curDay;
		}
		
		/**
		 * 今天
		 */
		public function get today():Date
		{
			return _today;
		}
		
		public function removeMC():void
		{
			var len:int = dateArr.length;
			for (var i:int = 0; i < len; i++)
			{
				dateArr[i].removeEventListener(MouseEvent.CLICK, clickDate);
			}
			dateArr = null;
			_curDay = null;
		}
	}

}