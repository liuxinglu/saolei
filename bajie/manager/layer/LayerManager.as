package bajie.manager.layer
{
	import bajie.interfaces.layer.ILayerManager;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import bajie.constData.CommonConfig;
	import bajie.interfaces.layer.IPanel;
	import bajie.module.ModuleEventDispatcher;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import bajie.events.ModuleEvent;

	public class LayerManager implements ILayerManager
	{
		private var _container:DisplayObjectContainer;
		private var _moduleLayer:DisplayObjectContainer;
		private var _popLayer:DisplayObjectContainer;
		private var _tipLayer:DisplayObjectContainer;
		
		private var _popPanels:Array;
		private var _changeModuleClosePanels:Array;
		
		public function LayerManager(sp:DisplayObjectContainer)
		{
			_container = sp;
			_popPanels = [];
			_changeModuleClosePanels = [];
			
			_moduleLayer = new Sprite();
			_moduleLayer.name = "LayerManager.ModuleLayer";
			
			_popLayer = new Sprite();
			_popLayer.name = "LayerManager.PopLayer";
			_popLayer.mouseEnabled = false;
			
			_tipLayer = new Sprite();
			_tipLayer.name = "LayerManager.TipLayer";
			_tipLayer.mouseEnabled = false;
			
			_container.addChild(_moduleLayer);
			_container.addChild(_popLayer);
			_container.addChild(_tipLayer);
			
			ModuleEventDispatcher.addModuleEventListener(ModuleEvent.MODULE_CHANGE, moduleChangeHandler);
		}
		
		/**
		放置模块和模块过渡层
		*/
		public function getModuleLayer():DisplayObjectContainer
		{
			return _moduleLayer;
		}
		
		/**
		弹框层
		*/
		public function getPopLayer():DisplayObjectContainer
		{
			return _popLayer;
		}
		
		public function getTipLayer():DisplayObjectContainer
		{
			return _tipLayer;
		}
		
		/**
		居中显示
		*/
		public function setCenter(display:DisplayObject):void
		{
			display.x = (CommonConfig.GAME_WIDTH - display.width)/2;
			display.y = (CommonConfig.GAME_HEIGHT - display.height)/2;
		}
		
		public function addPanel(panel:IPanel, closeWhenModuleChangle:Boolean = true, swapWhenClick:Boolean = true):void
		{
			var n:int = _popPanels.indexOf(panel);
			if(n == -1)
			{
				_popPanels.push(panel);
				panel.addEventListener(Event.CLOSE, panelCloseHandler);
				if(swapWhenClick)
					panel.addEventListener(MouseEvent.MOUSE_DOWN, panelDownHandler);
			}
			_popLayer.addChild(panel as DisplayObject);
			
			if(closeWhenModuleChangle)
			{
				n = _changeModuleClosePanels.indexOf(panel);
				if(n == -1)
					_changeModuleClosePanels.push(panel);
			}
		}
		
		public function getTopPanel():IPanel
		{
			return _popLayer.getChildAt(_popLayer.numChildren - 1) as IPanel;
		}
		
		public function escPress():void
		{
			for(var i:int = _popLayer.numChildren - 1; i >= 0; i--)
			{
				
			}
		}
		
		public function panelCloseHandler(evt:Event):void
		{
			var target:IPanel = evt.currentTarget as IPanel;
			target.removeEventListener(Event.CLOSE, panelCloseHandler);
			target.removeEventListener(MouseEvent.MOUSE_DOWN, panelDownHandler);
			var n:int = _popPanels.indexOf(target);
			if(n != -1)
				_popPanels.splice(n, 1);
			n = _changeModuleClosePanels.indexOf(target);
			if(n != -1)
				_changeModuleClosePanels.splice(n, 1);
		}
		
		private function panelDownHandler(evt:MouseEvent):void
		{
			_popLayer.setChildIndex((evt.currentTarget as DisplayObject), _popLayer.numChildren - 1);
		}
		
		private function moduleChangeHandler(e:MouseEvent):void
		{
			for(var i:int = _changeModuleClosePanels.length - 1; i >= 0; i--)
			{
				_changeModuleClosePanels[i].dispose();
			}
			_changeModuleClosePanels = [];
		}
	}
}