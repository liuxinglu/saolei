package bajie.ui.fight.regard
{
	import bajie.constData.GoodsType;
	import bajie.constData.ModuleType;
	import bajie.constData.SourceClearType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.bag.ItemTemplateList;
	import bajie.core.data.fight.regard.vo.PrizeVO;
	import bajie.core.data.fight.regard.vo.RankVO;
	import bajie.events.ParamEvent;
	import bajie.ui.Fight;
	import bajie.ui.fight.regard.Puke;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.setTimeout;

	public class Regard extends MovieClip
	{
		private static var _regardMC:Regard;
		private static var _regard:*;
		private var rankList:Array = [];
		private var prizeList:Array = [];
		private var picPathList:Array = [];
		private var picList:Array = new Array(Bitmap,Bitmap,Bitmap,Bitmap,Bitmap);
		private var timer:Timer = new Timer(50,100);
		private var timeFlag:int = 1;
		private var roomid:String = "";
		private var key:String = "";
		private var curPukeName:String = "";
		private var hadPrize:Boolean = false;

		public static function getInstance():Regard
		{
			if (_regardMC == null)
			{
				_regardMC = new Regard();
			}
			return _regardMC;
		}

		public function Regard()
		{
			// constructor code
			initView();
			initEvent();
		}

		private function initView():void
		{
			_regard = GlobalAPI.loaderAPI.getObjectByClassPath("regard");
			_regard.mt.stop();
			addChild(_regard);

			//var puke:Puke;
			/*for(var i:int = 0; i < 5; i++)
			{
			puke = new Puke;
			puke.x = i * 150;
			puke.y = 0;
			puke.name = "puke" + i;
			_regard.mt..addChild(puke);
			}*/

			if (GlobalData.fightInfo.rankO != null)
			{
				initData(GlobalData.fightInfo.rankO);
			}
			else
			{
			}
			SetModuleUtils.removeLoading();
		}

		private function initEvent():void
		{
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			
			GlobalData.fightInfo.addEventListener("GAMERESULT", gameResultHandler);
		}

		private function removeEvent():void
		{
			for (var j:int = 1; j <= prizeList.length; j++)
			{
				_regard.mt["p" + j].removeEventListener(MouseEvent.CLICK, pukeClickHandler);
			}
			timer.removeEventListener(TimerEvent.TIMER, timerHandler);
			GlobalData.fightInfo.removeEventListener("GAMERESULT", gameResultHandler);
		}
		
		private function gameResultHandler(e:ParamEvent):void
		{
			var o:Object = e.Param;
			for (var j:int = 1; j <= prizeList.length; j++)
			{
				_regard.mt["p" + j].mouseEnabled = true;
			}
			if(curPukeName == "")
			{
				curPukeName = "p1";
			}
			_regard.mt[curPukeName].pk.gotoAndStop(1);
			var s:String = GlobalData.itemTemplateList.getTemplate(o.openid).name;
			//MovieClip(_regard.mt)[curPukeName].pk.iconInfo = new TextField;
//			MovieClip(_regard.mt)[curPukeName].pk.iconContent = new MovieClip;
			MovieClip(_regard.mt)[curPukeName].pk.iconInfo.text = s;
			_regard.mt[curPukeName].play();
			//_regard.mt[curPukeName].pk.gotoAndStop(1);
			var iconPath:String = GlobalAPI.pathManager.getDisplayPicPath(GlobalData.itemTemplateList.getTemplate(o.openid).type, o.openid);
			resultImg(iconPath);
		}
		
		private var rsultimg:Bitmap;
		private function resultImg(imgPath:String):void
		{
			var boundSprite:Sprite;
			var bitmap:Bitmap;
			rsultimg = new Bitmap;
			GlobalAPI.loaderAPI.getPicFile(imgPath, function (e:BitmapData):void
				{
					boundSprite = new Sprite;
					bitmap = new Bitmap(e);
					rsultimg = bitmap;
					insertimg();
				}, SourceClearType.NEVER);
				
		}
		
		private function insertimg():void
		{
			
			MovieClip(_regard.mt)[curPukeName].pk.iconContent.addChild(rsultimg);
			if(hadPrize == false)
			{
				SetModuleUtils.removeModuleByName("fight", null, false, ModuleType.FIGHT);
				removeEvent();
				//GlobalData.hallInfo.enterRoom(int(roomid));
				SetModuleUtils.removeModule(this, ModuleType.REGARD);
			}
		}

		private function timerHandler(e:TimerEvent):void
		{
			_regard.progressBar.gotoAndStop(timeFlag++);
			if (timeFlag == 99)
			{
				timer.reset();
				if(hadPrize == false)
				{
					GlobalData.fightInfo.sendPrizeRequest(roomid, key, "0");
				}
				//Fight(GlobalAPI.layerManager.getModuleLayer().getChildByName("fight")).removeEvent();
				else
				{
					SetModuleUtils.removeModuleByName("fight", null, false, ModuleType.FIGHT);
					removeEvent();
					GlobalData.hallInfo.enterRoom(int(roomid));
					SetModuleUtils.removeModule(this, ModuleType.REGARD);
				}
				
			}
		}

		/**
		 *排名
		{teamid--队伍id,ranking{}--排名列表, key, prizelist--奖品列表}
		排名详细信息
		{no， name-玩家名称, title--军衔, bomCount--排雷个数, timer--耗时，exp--获取经验, silver--获取银币, vip--是否vip， vipsilver}
		奖品列表详细信息
		{type--物品类型, openid--模板id, quantity--数量} 
		 * @param o
		 * 
		 */
		public function initData(o:Object):void
		{
			
			roomid = o.teamid;
			key = o.key;
			var oo:Object = o.ranking;
			var rankVO:RankVO;
			for (var i:int = 0; i < oo.length; i++)
			{
				rankVO = new RankVO  ;
				rankVO.no = oo[i].no;
				rankVO.name = oo[i].name;
				rankVO.title = oo[i].title;
				rankVO.bomCount = oo[i].bomCount;
				rankVO.timer = oo[i].timer;
				rankVO.exp = oo[i].exp;
				rankVO.silver = oo[i].silver;
				rankVO.vip = oo[i].vip;
				rankVO.vipSilver = oo[i].vipsilver;
				rankList.push(rankVO);
			}

			var oo2:Object = o.prizelist;
			var prizeVO:PrizeVO;
			var picPath:String;
			for (var j:int = 0; j < oo2.length; j++)
			{
				prizeVO = new PrizeVO  ;
				prizeVO.type = oo2[j].type;
				prizeVO.templateid = oo2[j].openid;
				prizeVO.quantity = oo2[j].quantity;
				picPath = GlobalAPI.pathManager.getDisplayPicPath(GlobalData.itemTemplateList.getTemplate(prizeVO.templateid).type,prizeVO.templateid.toString());
				prizeList.push(prizeVO);
				picPathList.push(picPath);
			}
			var flag:int = 0;
			for (var k:int = 0; k < picPathList.length; k++)
			{
				switch (k)
				{
					case 0 :

						GlobalAPI.loaderAPI.getPicFile(picPathList[0], function t0(e:BitmapData):void{
						picList[0] = new Bitmap(e);
						flag++;
						if(flag == 5)
						{
							updateView();
						}

						}, SourceClearType.NEVER);
						break;
					case 1 :
						GlobalAPI.loaderAPI.getPicFile(picPathList[1], function t1(e:BitmapData):void{
						picList[1] = new Bitmap(e);
						flag++;
						if(flag == 5)
						{
							updateView();
						}
						}, SourceClearType.NEVER);
						break;
					case 2 :
						GlobalAPI.loaderAPI.getPicFile(picPathList[2], function t2(e:BitmapData):void{
						picList[2] = new Bitmap(e);
						flag++;
						if(flag == 5)
						{
							updateView(); 
						}
						}, SourceClearType.NEVER);
						break;
					case 3 :
						GlobalAPI.loaderAPI.getPicFile(picPathList[3], function t3(e:BitmapData):void{
						picList[3] = new Bitmap(e);
						flag++;
						if(flag == 5)
						{
							updateView();
						}
						}, SourceClearType.NEVER);
						break;
					case 4 :
						GlobalAPI.loaderAPI.getPicFile(picPathList[4], function t4(e:BitmapData):void{
						picList[4] = new Bitmap(e);
						flag++;
						if(flag == 5)
						{
							updateView();
						}
						}, SourceClearType.NEVER);
						break;
				}
			}
		}

		private function updateView():void
		{
			var rank:RankVO;
			var prize:PrizeVO;
			var boundSprite:Sprite;
			for (var i:int = 0; i < rankList.length; i++)
			{
				rank = rankList[i];
				_regard["rank" + (i + 1)].text = rank.no;
				_regard["nick" + (i + 1)].text = rank.name;
				_regard["level" + (i + 1)].text = rank.title;
				_regard["clearNum" + (i + 1)].text = rank.bomCount;
				_regard["time" + (i + 1)].text = rank.timer;
				_regard["exp" + (i + 1)].text = rank.exp;
				_regard["sliver" + (i + 1)].text = rank.silver;
			}
			for (var j:int = 0; j < prizeList.length; j++)
			{
				prize = prizeList[j];
				_regard.mt["p" + (j + 1)].pk.iconInfo.text = GlobalData.itemTemplateList.getTemplate(prize.templateid).name;
				_regard.mt["p" + (j + 1)].pk.iconContent.addChild(picList[j]);
			}
			_regard.mt.play();
			
				setTimeout(function tt():void{
						   for (var k:int = 1; k <= prizeList.length; k++)
							{
								_regard.mt["p" + k].mouseEnabled = true;
								if(!_regard.mt["p" + k].hasEventListener(MouseEvent.CLICK))
								{
									_regard.mt["p" + k].addEventListener(MouseEvent.CLICK, pukeClickHandler);
								}
								
					
							}
							timer.start();
				},4000);
		}


		private function pukeClickHandler(e:MouseEvent):void
		{
			curPukeName = e.currentTarget.name;
			GlobalData.fightInfo.sendPrizeRequest(roomid, key, curPukeName.charAt(1));
			//timer.reset();
			hadPrize = true;
			_regard.mt[curPukeName].removeEventListener(MouseEvent.CLICK, pukeClickHandler);
		}

	}

}