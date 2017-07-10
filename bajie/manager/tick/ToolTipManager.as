package bajie.manager.tick
{
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import bajie.constData.CommonConfig;
	import flash.filters.GlowFilter;
	import flash.filters.BitmapFilterQuality;
	import bajie.ui.tip.TipBg;
	import bajie.core.data.bag.BagItemInfo;
	import flash.display.Bitmap;
	import bajie.core.data.GlobalAPI;
	import flash.display.BitmapData;
	import bajie.constData.SourceClearType;
	import bajie.utils.SaoLeiTool;
	import bajie.core.data.GlobalData;

	public class ToolTipManager extends Sprite
	{
		private var _bg:TipBg;
		private var _stage:Stage;
		private var _parentObject:DisplayObject;

		private var _tf:TextField;//名称
		private var _jiaImg:Bitmap;//加号
		private var _levelImg:Bitmap;//level
		private var _infoImg:Bitmap;//缩略图
		private var _bindField:TextField;//是否绑定
		private var _goodsTypeField:TextField;//类型
		private var _goodsTypeSubField:TextField;//子类型
		private var _lastNumField:TextField;//剩余数量
		private var _attField:TextField;//属性
		private var _skillField:TextField;//技能-附加描述
		private var _needLevelField:TextField;//使用等级
		private var _useLastTimeField:TextField;//使用剩余时间
		private var _cf:TextField;//描述
		private var _attackScaleField:TextField;//攻击范围
		private var _cdTimeField:TextField;//冷却时间
		private var _chufaField:TextField;//触发概率

		private var _contentContainer:Sprite;
		private var _titleColor:uint = 0xffbf00;
		private var _bindColor:uint = 0xff0000;
		private var _attColor:uint = 0xffffff;
		private var _skillColor:uint = 0x00ff00;
		private var _needLevelColor:uint = 0xffffff;
		private var _lastTimeColor:uint = 0x00ff00;
		private var _contentColor:uint = 0x999999;
		
		private var _titleFormat:TextFormat = new TextFormat("",18,0xffd800);
		private var _bindFormat:TextFormat = new TextFormat("",14,0xffd800);
		private var _attFormat:TextFormat = new TextFormat("",14,0xffffff);
		private var _additAttFormat:TextFormat = new TextFormat("", 14, 0xffd800);
		private var _skillFormat:TextFormat = new TextFormat("", 14, 0x00ff00);
		private var _contentFormat:TextFormat = new TextFormat("", 14, 0xb7b48d);
		
		private var _stylesheet:StyleSheet;
		private var _styleOverride:Boolean = false;
		private var _titleOverride:Boolean = false;
		private var _contentOverride:Boolean = false;
		private var _titleEmbed:Boolean = false;
		private var _contentEmbed:Boolean = false;
		private var _defaultWidth:int = 220;
		private var _defaultHeight:int;
		private var _buffer:Number = 10;
		private var _align:String = "center";
		private var _cornerRadius:Number = 12;
		private var _bgColors:Array;
		private var _autoSize:Boolean = false;
		private var _hookSize:Number = 10;
		private var _hookEnabled:Boolean = false;
		private var _delay:Number = 100;
		private var _border:Number;
		private var _borderSize:Number = 1;
		private var _bgAlpha:Number = 0.6;
		private var _offSet:Number = 10;
		private var _hookOffSet:Number;
		private var _timer:Timer;
		private static var tp:ToolTipManager;

		public function ToolTipManager()
		{
			this._contentContainer = new Sprite();
			this._bgColors = [9973697,9613239];
			_bg = new TipBg  ;
			if (tp)
			{
				throw new Error("Singleton Error");
			}

			this.mouseEnabled = false;
			this.buttonMode = false;
			this.mouseChildren = false;
			this.addChild(_bg);
			this._timer = new Timer(this._delay,1);
			this._timer.addEventListener("timer", this.timerHandler);
			//this._textFormat = new TextFormat("",12,0xff00ff);
			//this.initContentFormat();
			return;
		}

		/*public function setContent(param1:String, param2:String = null):void
		{
		this.graphics.clear();
		this.addCopy(param1, param2);
		this.setOffset();
		this.drawBG();
		return;
		}*/

		//param1目标对象 bagItemInfo显示对象/s纯文字展示
		public function show(param1:DisplayObject, bagItemInfo:BagItemInfo = null, s:String = ""):void
		{
			this._stage = param1.stage;
			this._parentObject = param1;
			for(var j:int = this._contentContainer.numChildren; j > 0; j--)
			{
				this._contentContainer.removeChildAt(j-1);
			}
			
			for(var i:int = this.numChildren; i > 0; i--)
			{
				this.removeChildAt(i-1);
			}
			this.addChild(_bg);
			var _loc_4:* = this.addToStage(this._contentContainer);
			if (! _loc_4)
			{
				this.addChild(this._contentContainer);
			}
			if (bagItemInfo != null)
			{
				if (bagItemInfo.type == 1 || bagItemInfo.type == 5)
				{//道具 宝石
					this.addCopy(1, bagItemInfo);
				}
				else if (bagItemInfo.type == 2 || bagItemInfo.type == 3)
				{//武器 装备
					this.addCopy(2, bagItemInfo);
				}
				else if (bagItemInfo.type == 4)
				{//时装
					this.addCopy(3, bagItemInfo);
				}
				else if (bagItemInfo.type == 6)
				{//技能
					this.addCopy(4, bagItemInfo);
				}
			}
			else
			{
				if (s.length > 40)
				{
					_bg.width = 220;
				}
				else
				{
					_bg.width = 220;
				}
				this.addCopy(0, null, s);
				this.setOffset();
				this.drawBG();
				this.bgGlow();
			}


			var _loc_5:Point = new Point(this._parentObject.mouseX,this._parentObject.mouseY);
			var _loc_6:Point = new Point(GlobalAPI.sp.mouseX, GlobalAPI.sp.mouseY);//param1.localToGlobal(_loc_5);
			this.x = _loc_6.x //+ this._offSet;
			this.y = _loc_6.y //- this.height/2 - 70;
			if((this.x + this.width) > GlobalAPI.sp.width)
			{
				this.x = GlobalAPI.sp.width - this._defaultWidth;
			}
			if((this.y + this.height) > GlobalAPI.sp.height)
			{
				this.y = GlobalAPI.sp.height - this.height;
			}
			if((this.y - this.height) < 0)
			{
				this.y = 0;
			}
			this.alpha = 1;
			this._stage.addChild(this);
			this.addEventListener(MouseEvent.ROLL_OUT, this.onMouseOut);
			this.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
			this._parentObject.addEventListener(MouseEvent.ROLL_OUT, this.onMouseOut);
			this._parentObject.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
			param1.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoveFromStage);
			/*this.follow(true);
			this._timer.start();*/
		}

		private function onRemoveFromStage(e:Event):void
		{
			this._timer.stop();
			this._timer.reset();
			if (this._parentObject.stage)
			{
			}
			if (this._tf)
			{
				this.cleanUp();
			}
			if (this._parentObject.hasEventListener(Event.REMOVED_FROM_STAGE))
			{
				this._parentObject.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoveFromStage);
			}
		}


		public function hide():void
		{
			this.animate(false);
		}

		private function timerHandler(e:TimerEvent):void
		{
			this.animate(true);
		}

		private function onMouseOut(event:MouseEvent):void
		{
			event.currentTarget.removeEventListener(event.type, arguments.callee);
			this.hide();
		}

		private function follow(param1:Boolean):void
		{
			if (param1)
			{
				addEventListener(Event.ENTER_FRAME, this.eof);
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, this.eof);
			}
		}

		private function eof(e:Event):void
		{
			this.position();
		}

		private function position():void
		{
			var _loc_1:int = 3;
			var _loc_2:Point = new Point(this._parentObject.mouseX,this._parentObject.mouseY);
			var _loc_3:Point = this._parentObject.localToGlobal(_loc_2);
			var _loc_4:Number = _loc_3.x + this._offSet;
			var _loc_5:Number = _loc_3.y - this.height - 10;
			var _loc_6:Number = this._defaultWidth + _loc_4;
			if (_loc_6 > stage.stageWidth)
			{
				_loc_4 = stage.stageWidth - this._defaultWidth;
			}
			if (_loc_4 < 0)
			{
				_loc_4 = 0;
			}
			if (_loc_5 < 0)
			{
				_loc_5 = 0;
			}
			this.x = this.x + (_loc_4 - this.x) / _loc_1;
			this.y = this.y + (_loc_5 - this.y) / _loc_1;
			this._timer.reset();
		}

		/**
		type:0纯文字
		type:1道具宝石
		type:2装备武器
		type:3时装
		type:4技能
		*/
		private function addCopy(type:int = 0, bagItemInfo:BagItemInfo = null, param2:String = null):void
		{
			//var _loc_3:* = null;
			var _loc_4:* = NaN;
			
			
			switch (type)
			{
				case 0 ://文字
					if (param2 != null)
					{
						
						if (this._cf == null)
						{
							this._cf = this.createField(this._contentEmbed);
						}


						if (! this._styleOverride)
						{
							this._cf.setTextFormat(this._contentFormat);
						}
						this._cf.defaultTextFormat = this._contentFormat;
						this._cf.text = param2;
						this._cf.textColor = _contentColor;
						//_loc_3 = this.getBounds(this);
						this._cf.x = this._buffer;
						this._cf.y = 40;
						this.textGlow(this._cf);
						if (this._autoSize)
						{
							_loc_4 = this._cf.textWidth + 4 + this._buffer * 2;
							this._defaultWidth = _loc_4 > this._defaultWidth ? (_loc_4) : this._defaultWidth;
						}
						else
						{
							this._cf.width = this._defaultWidth - this._buffer * 2;
						}
						this._contentContainer.addChild(this._cf);
					}
					break;
				case 1 ://道具宝石
					_bg.height = 250;
					if(this._tf == null)//标题
						this._tf = this.createField(this._contentEmbed);
					this._tf.text = "";
					this._tf.setTextFormat(this._titleFormat);
					this._tf.multiline = false;
					this._tf.textColor = _titleColor;
					this._tf.text = bagItemInfo.template.name;
					this._tf.x = 10;
					this._tf.y = 10;
					this._contentContainer.addChild(this._tf);
					
					if(this._goodsTypeField == null)//物品类型
						this._goodsTypeField = this.createField(this._contentEmbed);
					this._goodsTypeField.text = "";
					this._goodsTypeField.setTextFormat(this._attFormat);
					this._goodsTypeField.textColor = _attColor;
					this._goodsTypeField.text = bagItemInfo.template.typeName;
					this._goodsTypeField.x = 10;
					this._goodsTypeField.y = 35;
					this._contentContainer.addChild(this._goodsTypeField);
					
					if(this._lastNumField == null)//剩余数量
						this._lastNumField = this.createField(this._contentEmbed);
					this._lastNumField.text = "";
					this._lastNumField.setTextFormat(this._attFormat);
					this._lastNumField.textColor = _lastTimeColor;
					this._lastNumField.text = "剩余个数:" + bagItemInfo.number.toString();
					this._lastNumField.x = 10;
					this._lastNumField.y = 60;
					this._contentContainer.addChild(this._lastNumField);
					
					if(this._attField == null)//属性
						this._attField = this.createField(this._contentEmbed);
					this._attField.setTextFormat(this._attFormat);
					this._attField.htmlText = "";
					if(bagItemInfo.energy != 0)
						this._attField.htmlText = "能量+" + bagItemInfo.energy + "<br/>";
					if(bagItemInfo.lucky != 0)
						this._attField.htmlText += "幸运+" + bagItemInfo.lucky + "<br/>";
					if(bagItemInfo.dex != 0)
						this._attField.htmlText += "灵巧" + bagItemInfo.dex;
					this._attField.textColor = _attColor;
					this._attField.x = 10;
					this._attField.y = 90;
					this._contentContainer.addChild(this._attField);
					
					if(this._cf == null)//描述
						this._cf = this.createField(this._contentEmbed);
					this._cf.text = "";
					this._cf.setTextFormat(this._contentFormat);
					this._cf.textColor = _contentColor;
					this._cf.width = 195;
					if(bagItemInfo.template.description != null)
						this._cf.text = bagItemInfo.template.description;
					this._cf.x = 10;
					this._cf.y = 140;
					this._contentContainer.addChild(_cf);
					
					break;
				case 2 ://装备武器
					_bg.height = 250;
					if(this._tf == null)
						this._tf = this.createField(this._contentEmbed);
					this._tf.text = "";
					this._tf.setTextFormat(this._titleFormat);
					this._tf.textColor = _titleColor;
					//this._tf.multiline = false;
					this._tf.wordWrap = false;
					this._tf.text = bagItemInfo.template.name;
					this._tf.x = 10;
					this._tf.y = 10;
					this._contentContainer.addChild(this._tf);
					
					if(bagItemInfo.level > 0)
					{
						var jiaPath:String = GlobalAPI.pathManager.getItemInfoPicPath("jia");
						GlobalAPI.loaderAPI.getPicFile(jiaPath, function (e:BitmapData):void
													{
														var boundSprite:Sprite = new Sprite;
														boundSprite.x = (_tf).x + (_tf).width;
														boundSprite.y = (_tf).y;
														addChild(boundSprite);
														_jiaImg = new Bitmap(e);
														boundSprite.addChild(_jiaImg);
													}, SourceClearType.NEVER);
					
						var levelPath:String = GlobalAPI.pathManager.getItemInfoPicPath(bagItemInfo.level.toString());
						GlobalAPI.loaderAPI.getPicFile(levelPath, function (e:BitmapData):void
												   {
													   var boundSprite2:Sprite = new Sprite;
													   boundSprite2.x = (_tf).x + (_tf).width + 20;
													   boundSprite2.y = (_tf).y;
													   addChild(boundSprite2);
													   _levelImg = new Bitmap(e);
													   boundSprite2.addChild(_levelImg);
												   }, SourceClearType.NEVER);
					}
					   
					if(this._goodsTypeField == null)//物品类型
						this._goodsTypeField = this.createField(this._contentEmbed);
					this._goodsTypeField.text = "";
					this._goodsTypeField.setTextFormat(this._attFormat);
					this._goodsTypeField.textColor = _attColor;
					this._goodsTypeField.text = bagItemInfo.template.typeName;
					this._goodsTypeField.x = 10;
					this._goodsTypeField.y = 35;
					this._contentContainer.addChild(this._goodsTypeField);
					
					if(this._goodsTypeSubField == null)//物品分属类
						this._goodsTypeSubField = this.createField(this._contentEmbed);
					this._goodsTypeSubField.text = "";
					this._goodsTypeSubField.setTextFormat(this._contentFormat);
					if(bagItemInfo.classify == 1)
						this._goodsTypeSubField.textColor = 0xff0000;
					else if(bagItemInfo.classify  == 2)
						this._goodsTypeSubField.textColor = 0xffff00;
					else if(bagItemInfo.classify == 3)
						this._goodsTypeSubField.textColor = 0x0000ff;
					this._goodsTypeSubField.text = "【" + bagItemInfo.classify + "】";
					this._goodsTypeSubField.x = this._goodsTypeField.x + this._goodsTypeField.width;
					this._goodsTypeSubField.y = this._goodsTypeField.y;
					this._contentContainer.addChild(this._goodsTypeSubField);
					
					if(this._attField == null)//属性
						this._attField = this.createField(this._contentEmbed);
					this._attField.text = "";
					this._attField.setTextFormat(this._attFormat);
					if(bagItemInfo.energy != 0)
						this._attField.htmlText = "能量+" + bagItemInfo.energy + "<br/>";
					if(bagItemInfo.lucky != 0)
						this._attField.htmlText += "幸运+" + bagItemInfo.lucky + "<br/>";
					if(bagItemInfo.dex != 0)
						this._attField.htmlText += "灵巧" + bagItemInfo.dex;
					this._attField.textColor = _attColor;
					this._attField.x = 10;
					this._attField.y = 70;
					this._contentContainer.addChild(this._attField);
					
					if(this._skillField == null)//附加技能描述
						this._skillField = this.createField(this._contentEmbed);
					this._skillField.text = "";
					this._skillField.setTextFormat(this._contentFormat);
					this._skillField.textColor = _lastTimeColor;
					this._skillField.htmlText = bagItemInfo.template.additional_description;
					this._skillField.x = 10;
					this._skillField.y = 120;
					this._contentContainer.addChild(this._skillField);
					
					if(this._needLevelField == null)//使用等级
						this._needLevelField = this.createField(this._contentEmbed);
					this._needLevelField.text = "";
					this._needLevelField.setTextFormat(this._attFormat);
					this._needLevelField.textColor = _attColor;
					this._needLevelField.htmlText = "使用等级:" + bagItemInfo.useLevel + "级";
					this._needLevelField.x = 10;
					this._needLevelField.y = 140;
					this._contentContainer.addChild(this._needLevelField);
					
					if(this._cf == null)//描述
						this._cf = this.createField(this._contentEmbed);
					this._cf.text = "";
					this._cf.setTextFormat(this._contentFormat);
					this._cf.htmlText = bagItemInfo.template.description;
					this._cf.x = 10;
					this._cf.y = 160;
					this._cf.width = 195;
					this._contentContainer.addChild(this._cf);
					break;
				case 3 ://时装
					_bg.height = 250;
					if(this._tf == null)
						this._tf = this.createField(this._contentEmbed);
					this._tf.text = "";
					this._tf.setTextFormat(this._titleFormat);
					this._tf.textColor = _titleColor;
					//this._tf.multiline = false;
					this._tf.wordWrap = false;
					this._tf.text = bagItemInfo.template.name;
					this._tf.x = 10;
					this._tf.y = 10;
					this._contentContainer.addChild(this._tf);
												   
					if(this._goodsTypeField == null)//物品类型
						this._goodsTypeField = this.createField(this._contentEmbed);
					this._goodsTypeField.text = "";
					this._goodsTypeField.setTextFormat(this._attFormat);
					this._goodsTypeField.textColor = _attColor;
					this._goodsTypeField.text = bagItemInfo.template.typeName;
					this._goodsTypeField.x = 10;
					this._goodsTypeField.y = 35;
					this._contentContainer.addChild(this._goodsTypeField);
					
					if(this._attField == null)//属性
						this._attField = this.createField(this._contentEmbed);
					this._attField.text = "";
					this._attField.setTextFormat(this._attFormat);
					if(bagItemInfo.energy != 0)
						this._attField.htmlText = "能量+" + bagItemInfo.energy + "<br/>";
					if(bagItemInfo.lucky != 0)
						this._attField.htmlText += "幸运+" + bagItemInfo.lucky + "<br/>";
					if(bagItemInfo.dex != 0)
						this._attField.htmlText += "灵巧" + bagItemInfo.dex;
					this._attField.textColor = _attColor;
					this._attField.x = 10;
					this._attField.y = 70;
					this._contentContainer.addChild(this._attField);
					
					if(this._skillField == null)//附加技能描述
						this._skillField = this.createField(this._contentEmbed);
					this._skillField.text = "";
					this._skillField.setTextFormat(this._contentFormat);
					this._skillField.textColor = _lastTimeColor;
					this._skillField.htmlText = bagItemInfo.template.additional_description;
					this._skillField.x = 10;
					this._skillField.y = 120;
					this._contentContainer.addChild(this._skillField);
					
					if(this._needLevelField == null)//使用等级
						this._needLevelField = this.createField(this._contentEmbed);
					this._needLevelField.htmlText = "";
					this._needLevelField.setTextFormat(this._attFormat);
					this._needLevelField.textColor = _attColor;
					this._needLevelField.htmlText = "使用等级:" + bagItemInfo.useLevel + "级";
					this._needLevelField.x = 10;
					this._needLevelField.y = 140;
					this._contentContainer.addChild(this._needLevelField);
					
					if(bagItemInfo.lastUseTime > 0)
					{
						if(this._useLastTimeField == null)
							this._useLastTimeField = this.createField(this._contentEmbed);
						this._useLastTimeField.htmlText = "";
						this._useLastTimeField.setTextFormat(this._attFormat);
						this._useLastTimeField.textColor = _attColor;
						this._useLastTimeField.htmlText = "剩余时间：<br/>" + "<font color='" + _lastTimeColor + "'" + SaoLeiTool.SecondTurnToTimeString(bagItemInfo.lastUseTime) + "</font>";
						this._useLastTimeField.x = 10;
						this._useLastTimeField.y = 170;
						this._contentContainer.addChild(this._useLastTimeField);
					}
					
					break;
				case 4 ://技能
					if(this._tf == null)//标题
						this._tf = this.createField(this._contentEmbed);
					this._tf.text = "";
					this._tf.setTextFormat(this._titleFormat);
					this._tf.textColor = _titleColor;
					this._tf.multiline = false;
					this._tf.text = bagItemInfo.template.name;
					this._tf.x = 10;
					this._tf.y = 10;
					this._contentContainer.addChild(this._tf);
					
					if(this._goodsTypeField == null)//物品类型
						this._goodsTypeField = this.createField(this._contentEmbed);
					this._goodsTypeField.setTextFormat(this._attFormat);
					this._goodsTypeField.textColor = _attColor;
					this._goodsTypeField.text = bagItemInfo.template.typeName;
					this._goodsTypeField.x = 10;
					this._goodsTypeField.y = 35;
					this._contentContainer.addChild(this._goodsTypeField);
					
					if(this._attackScaleField == null)//攻击范围
						this._attackScaleField = this.createField(this._contentEmbed);
					this._attackScaleField.setTextFormat(this._attFormat);
					this._attackScaleField.text = "";
					this._attackScaleField.textColor = _attColor;
					this._attackScaleField.text = "攻击范围：" + GlobalData.skillTemplateList.getTemplate(bagItemInfo.templateId, bagItemInfo.level).radius;
					this._attackScaleField.x = 10;
					this._attackScaleField.y = 70;
					this._contentContainer.addChild(this._attackScaleField);
					
					if(this._cdTimeField == null)//冷却时间
						this._cdTimeField = this.createField(this._contentEmbed);
					this._cdTimeField.setTextFormat(this._attFormat);
					this._cdTimeField.text = "";
					this._cdTimeField.textColor = _attColor;
					this._cdTimeField.text = "冷却时间：" + SaoLeiTool.SecondTurnToTimeString(int(GlobalData.skillTemplateList.getTemplate(bagItemInfo.templateId, bagItemInfo.level).coolTimer));
					this._cdTimeField.x = 10;
					this._cdTimeField.y = 105;
					this._contentContainer.addChild(this._cdTimeField);
					
					if(this._chufaField == null)//触发概率
						this._chufaField = this.createField(this._contentEmbed);
					this._chufaField.setTextFormat(this._attFormat);
					this._chufaField.text = "";
					this._chufaField.textColor = _attColor;
					this._chufaField.text = "触发概率："+ int(GlobalData.skillTemplateList.getTemplate(bagItemInfo.templateId, bagItemInfo.level).touch)/1000 + "%";
					this._chufaField.x = 10;
					this._chufaField.y = 140;
					this._contentContainer.addChild(this._chufaField);
					
					if(this._needLevelField == null)//学习下一级需要等级
						this._needLevelField = this.createField(this._contentEmbed);
					this._needLevelField.setTextFormat(this._contentFormat);
					this._needLevelField.htmlText = "";
					this._needLevelField.htmlText = "学习下一级需要等级:" + GlobalData.skillTemplateList.getTemplate(bagItemInfo.templateId, bagItemInfo.level).useLevel;
					this._needLevelField.x = 10;
					this._needLevelField.y = 170;
					this._contentContainer.addChild(this._needLevelField);
					
					if(this._cf == null)//描述
						this._cf = this.createField(this._contentEmbed);
					this._cf.text = "";
					this._cf.setTextFormat(this._contentFormat);
					this._cf.textColor = _contentColor;
					if(bagItemInfo.template.description != null)
						this._cf.text = bagItemInfo.template.description;
					this._cf.x = 10;
					this._cf.y = 70;
					this._contentContainer.addChild(_cf);
					break;
			}

			//this._tf.defaultTextFormat = this._titleFormat;
			//this._cf.defaultTextFormat = this._contentFormat;
		}

		private function createField(param1:Boolean):TextField
		{
			var _loc_2:TextField = new TextField();
			_loc_2.embedFonts = param1;
			_loc_2.gridFitType = "pixel";
			_loc_2.autoSize = TextFieldAutoSize.LEFT;
			_loc_2.selectable = false;
			_loc_2.wordWrap = true;
			if (this._styleOverride)
			{
				_loc_2.styleSheet = this._stylesheet;
			}
			_loc_2.defaultTextFormat = this._contentFormat;
			if (! this._autoSize)
			{
				_loc_2.multiline = true;
				_loc_2.wordWrap = true;
			}
			return _loc_2;
		}

		private function drawBG():void
		{
			var _loc_9:Number = NaN;
			var _loc_10:Number = NaN;
			var _loc_11:Number = NaN;
			this.graphics.clear();

			var _loc_1:Rectangle = this.getBounds(this);
			var _loc_2:* = isNaN(this._defaultHeight) ? (_loc_1.height + this._buffer * 2) : this._defaultHeight;
			var _loc_3:* = GradientType.LINEAR;
			var _loc_4:Array = [this._bgAlpha,this._bgAlpha];
			var _loc_5:Array = [0,255];
			var _loc_6:Matrix = new Matrix();
			var _loc_7:Number = 90 * Math.PI / 180;
			_loc_6.createGradientBox(this._defaultWidth, _loc_2, _loc_7, 0, 0);

			var _loc_8:* = SpreadMethod.PAD;
			if (! isNaN(this._border))
			{
				this.graphics.lineStyle(this._borderSize, this._border, 1);
			}
			this.graphics.beginGradientFill(_loc_3, this._bgColors, _loc_4, _loc_5, _loc_6, _loc_8);
			if (this._hookEnabled)
			{
				_loc_9 = 0;
				_loc_10 = 0;
				_loc_11 = this._defaultWidth;
				this.graphics.moveTo(_loc_9 + this._cornerRadius, _loc_10);
				this.graphics.lineTo(_loc_9 + _loc_11 - this._cornerRadius, _loc_10);
				this.graphics.curveTo(_loc_9 + _loc_11, _loc_10, _loc_9 + _loc_11, _loc_10 + this._cornerRadius);
				this.graphics.lineTo(_loc_9 + _loc_11, _loc_10 + _loc_2 - this._cornerRadius);
				this.graphics.curveTo(_loc_9 + _loc_11, _loc_10 + _loc_2, _loc_9 + _loc_11 - this._cornerRadius, _loc_10 + _loc_2);
				this.graphics.lineTo(_loc_9 + this._hookOffSet + this._hookSize, _loc_10 + _loc_2);
				this.graphics.lineTo(_loc_9 + this._hookOffSet, _loc_10 + _loc_2 + this._hookSize);
				this.graphics.lineTo(_loc_9 + this._hookOffSet - this._hookSize, _loc_10 + _loc_2);
				this.graphics.lineTo(_loc_9 + this._cornerRadius, _loc_10 + _loc_2);
				this.graphics.curveTo(_loc_9, _loc_10 + _loc_2, _loc_9, _loc_10 + _loc_2 - this._cornerRadius);
				this.graphics.lineTo(_loc_9, _loc_10 + this._cornerRadius);
				this.graphics.curveTo(_loc_9, _loc_10, _loc_9 + this._cornerRadius, _loc_10);
				this.graphics.endFill();
			}
			else
			{
				this.graphics.drawRoundRect(0, 0, this._defaultWidth, _loc_2, this._cornerRadius);
			}
		}

		private function animate(param1:Boolean):void
		{
			if (! this._parentObject)
			{
				return;
			}
			if (! this._parentObject.stage)
			{
				return;
			}
			if (this._parentObject.stage)
			{

			}
			if (! this._parentObject.parent)
			{
				return;
			}

			var _loc_2:Number = param1 == true ? 1:0;
			this.alpha = _loc_2;
			if (! param1)
			{
				this.alpha = _loc_2;
				this._timer.reset();
			}
		}

		private function onTweenComplete():void
		{
			this.cleanUp();
		}

		public function set buffer(param1:Number):void
		{
			this._buffer = param1;
		}

		public function get buffer():Number
		{
			return this._buffer;
		}

		public function set bgAlpha(param1:Number):void
		{
			this._bgAlpha = param1;
		}

		public function get bgAlpha():Number
		{
			return this._bgAlpha;
		}

		public function set tipWidth(param1:Number):void
		{
			this._defaultWidth = param1;
		}

		public function set stylesheet(param1:StyleSheet):void
		{
			this._stylesheet = param1;
			this._styleOverride = true;
		}

		public function set align(param1:String):void
		{
			var _loc_2:* = param1.toLowerCase();
			var _loc_3:String = "right left center";
			if (_loc_3.indexOf(param1) == -1)
			{
				throw new Error((this + ": Invalid Align Property, options are: \'right\', \'left\' & \'center\'"));
			}
			this._align = _loc_2;
		}

		public function set delay(param1:Number):void
		{
			this._delay = param1;
			this._timer.delay = param1;
		}

		public function set hook(param1:Boolean):void
		{
			this._hookEnabled = param1;
		}

		public function set hookSize(param1:Number):void
		{
			this._hookSize = param1;
		}

		public function set cornerRadius(param1:Number):void
		{
			this._cornerRadius = param1;
		}

		public function set colors(param1:Array):void
		{
			this._bgColors = param1;
		}

		public function set autoSize(param1:Boolean):void
		{
			this._autoSize = param1;
		}

		public function set border(param1:Number):void
		{
			this._border = param1;
		}

		public function set borderSize(param1:Number):void
		{
			this._borderSize = param1;
		}

		public function set tipHeight(param1:Number):void
		{
			this._defaultHeight = param1;
		}

		public function set titleEmbed(param1:Boolean):void
		{
			this._titleEmbed = param1;
		}

		private function textGlow(param1:TextField):void
		{
			var _loc_2:Number = 0;
			var _loc_3:Number = 0.35;
			var _loc_4:Number = 2;
			var _loc_5:Number = 2;
			var _loc_6:Number = 1;
			var _loc_7:Boolean = false;
			var _loc_8:Boolean = false;
			var _loc_9:Number = BitmapFilterQuality.HIGH;
			var _loc_10:GlowFilter = new GlowFilter(_loc_2,_loc_3,_loc_4,_loc_5,_loc_6,_loc_9,_loc_7,_loc_8);
			var _loc_11:Array = [];
			_loc_11.push(_loc_10);
			param1.filters = _loc_11;
		}

		private function bgGlow():void
		{
			var _loc_1:Number = 0;
			var _loc_2:Number = 0.2;
			var _loc_3:Number = 5;
			var _loc_4:Number = 5;
			var _loc_5:Number = 1;
			var _loc_6:Boolean = false;
			var _loc_7:Boolean = false;
			var _loc_8:Number = BitmapFilterQuality.HIGH;
			var _loc_9:GlowFilter = new GlowFilter(_loc_1,_loc_2,_loc_3,_loc_4,_loc_5,_loc_8,_loc_6,_loc_7);
			var _loc_10:Array = [];
			filters = _loc_10;
		}

		//private function initContentFormat():void
//		{
//			this._textFormat = new TextFormat();
//			this._textFormat.font = CommonConfig.DEFAULT_FONT;
//			this._textFormat.bold = false;
//			this._textFormat.size = 12;
//			this._textFormat.color = 16777215;
//		}

		private function addToStage(param1:DisplayObject):Boolean
		{
			var _loc_2:Stage = param1.stage;
			return _loc_2 == null ? false : true;
		}

		private function setOffset():void
		{
			switch (this._align)
			{
				case "left" :
					this._offSet =  -  this._defaultWidth + this._buffer * 3 + this._hookSize;
					this._hookOffSet = this._defaultWidth - this._buffer * 3 - this._hookSize;
					break;
				case "right" :
					this._offSet =  -  this._buffer * 3 - this._hookSize;
					this._hookOffSet = this._buffer * 3 + this._hookSize;
					break;
				case "center" :
					this._offSet =  -  this._defaultWidth / 2;
					this._hookOffSet = this._defaultWidth / 2;
					break;
				default :
					this._offSet =  -  this._defaultWidth / 2;
					this._hookOffSet = this._defaultWidth / 2;
					break;
			}
		}

		private function cleanUp():void
		{
			if (! this._tf)
			{
				return;
			}
			this._parentObject.removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
			this.follow(false);
			this._tf.filters = [];
			this.filters = [];
			this._contentContainer.removeChild(this._tf);
			this._tf = null;
			if (this._cf != null)
			{
				this._cf.filters = [];
				//this._contentContainer.removeChild(this._cf);
			}
			this.graphics.clear();
			removeChild(this._contentContainer);
			parent.removeChild(this);
		}

		public function get defaultWidth():Number
		{
			return this._defaultWidth;
		}

		public function set defaultWidth(param1:Number):void
		{
			this._defaultWidth;
		}

		public function get defaultHeight():Number
		{
			return this._defaultHeight;
		}

		public function set defaultHeight(param1:Number):void
		{
			this._defaultHeight = param1;
		}

		public static function getInstance():ToolTipManager
		{
			if (! tp)
			{
				tp = new ToolTipManager  ;
			}
			return tp;
		}
	}
}