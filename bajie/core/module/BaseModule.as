package bajie.core.module
{
	import flash.display.Sprite;
	import bajie.interfaces.module.IModule;

	public class BaseModule extends Sprite implements IModule
	{
		protected var moduleInfo:ModuleInfo;
		
		public function BaseModule()
		{
			super();
		}
		
		public function get moduleId():int
		{
			return 0;
		}
		
		public function setup(prev:IModule, data:Object=null):void
		{
			moduleInfo = ModuleList.getInfo(moduleId);
			initEvent();
		}
		
		protected function initEvent():void
		{
		}
		protected function removeEvent():void
		{
		}
		
		public function free(next:IModule):void
		{
			dispose();
		}
		
		public function configure(data:Object):void
		{
		}
		
		public function getBackTo():int
		{
			return 0;
		}
		
		public function getBackToParam():Object
		{
			return null;
		}
		
		public function dispose():void
		{
			removeEvent();
			moduleInfo = null;
			if(parent)parent.removeChild(this);
			dispatchEvent(new ModuleEvent(ModuleEvent.MODULE_DISPOSE));
		}

	}
}