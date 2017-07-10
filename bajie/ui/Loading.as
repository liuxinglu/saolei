package bajie.ui {
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Loading extends MovieClip {

		private var timer:Timer = new Timer(500);
		private var flag:Boolean = false;
		private static var loading:Loading;
		
		public static function getInstance():Loading
		{
			if(loading == null)
			 	loading = new Loading;
			return loading;
		}
		public function Loading() {
			// constructor code
			initEvent();
			initView();
		}
		
		private function initView():void
		{
			loadingText.text = "loading";
			//loadingBar.gotoAndStop(1);
		}
		
		private function initEvent():void
		{
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.start();
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			if(flag == false)
			{
				flag = true;
				loadingText.text = "loading...";
			}
			else
			{
				flag = false;
				loadingText.text = "loading.";
			}
			
		}
		
		public function setCurFrame(i:int):void
		{
			loadingBar.gotoAndStop(i);
		}
		
		public function removeLoading():void
		{
			timer.removeEventListener(TimerEvent.TIMER, timerHandler);
			timer.reset();
		}

	}
	
}
