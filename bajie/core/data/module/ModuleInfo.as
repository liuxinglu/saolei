package bajie.core.data.module
{
	public class ModuleInfo
	{
		public var moduleId:int;
		public var hasModel:Boolean = false;
		
		public function ModuleInfo(moduleId:int, hasModel:Boolean)
		{
			this.moduleId = moduleId;
			this.hasModel = hasModel;
		}
	}

}