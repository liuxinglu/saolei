package bajie.ui {
	
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.events.ParamEvent;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Rank extends MovieClip {
		
		private var ui:*;
		private var _type:int = 1;
		private var _index:int = 1;
		private var _total:int = 1;;
		
		private const _rankNum:int = 10;
		
		public function Rank() {
			ui = GlobalAPI.loaderAPI.getObjectByClassPath("rank");
			addChild(ui);
			initEvent();
			GlobalData.rankInfo.getMyRank(_type);
			GlobalData.rankInfo.getRankInfo(_index, _type);
		}
		public function initEvent():void {
			ui.btn_close.addEventListener(MouseEvent.CLICK,removeMC);
			ui.btn_pageUp.addEventListener(MouseEvent.CLICK,buttonClick);
			ui.btn_pageDown.addEventListener(MouseEvent.CLICK, buttonClick);
			GlobalData.rankInfo.addEventListener(ParamEvent.UPDATE_RANK_INFO, updateInfo);
			GlobalData.rankInfo.addEventListener(ParamEvent.UPDATE_MYRANK, updateMyRank);
		}
		private function buttonClick(e:MouseEvent):void {
			switch(e.currentTarget.name) {
				case "btn_pageUp":
					if (_index>1) {
					GlobalData.rankInfo.getRankInfo(_index - 1, _type);
					} 
					break;
				case "btn_pageDown":
					if (_index < _total) {
					GlobalData.rankInfo.getRankInfo(_index + 1, _type);
					}
					break;
				default:break;
			}	
		}
		private function updateInfo(e:ParamEvent):void {
			SetModuleUtils.removeLoading();
			
			var o:Object = e.Param;
			_index = o.index;
			_total = o.total;
			
			ui.txt_page.text = _index + "/" + _total;
			
			var list:Array = o.list as Array;
			for (var i:int = 0; i < _rankNum; i++ ) {
				if (list[i]) {
					ui["txt_rank" + i].text = list[i].no;
					ui["txt_nick" + i].text = list[i].name;
					ui["txt_level" + i].text = list[i].level;
					ui["txt_military" + i].text = list[i].ranking;
				}else {
					ui["txt_rank" + i].text = "";
					ui["txt_nick" + i].text = "";
					ui["txt_level" + i].text = "";
					ui["txt_military" + i].text = "";
				}
			}
		}
		private function updateMyRank(e:ParamEvent):void {
			var list:Array = e.Param.list as Array;
			ui.txt_myRank.text = list[0].no;
			ui.txt_myNick.text = list[0].name;
			ui.txt_myLevel.text = list[0].level;
			ui.txt_myMilitary.text = list[0].ranking;
		}
		private function removeMC(e:MouseEvent = null):void {
			ui.btn_close.removeEventListener(MouseEvent.CLICK,removeMC);
			ui.btn_pageUp.removeEventListener(MouseEvent.CLICK,buttonClick);
			ui.btn_pageDown.removeEventListener(MouseEvent.CLICK, buttonClick);
			GlobalData.rankInfo.removeEventListener(ParamEvent.UPDATE_RANK_INFO, updateInfo);
			GlobalData.rankInfo.removeEventListener(ParamEvent.UPDATE_MYRANK, updateMyRank);
			ui = null;
			SetModuleUtils.removeModule(this, ModuleType.RANK);
		}
	}
	
}
