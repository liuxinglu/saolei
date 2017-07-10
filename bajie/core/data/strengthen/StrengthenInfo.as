package bajie.core.data.strengthen 
{
	import bajie.core.data.bag.BagItemInfo;
	import bajie.ui.strengthen.Strengthen;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import bajie.core.data.socketHandler.strengthen.*;
	import bajie.core.data.GlobalData;
	import bajie.events.ParamEvent;
	import bajie.core.data.GlobalAPI;
	import bajie.utils.module.SetModuleUtils;
	import bajie.interfaces.loader.ILoader;
	import bajie.constData.ModuleType;
	/**
	 * ...
	 * @author azjune
	 */
	public class StrengthenInfo extends EventDispatcher
	{
		
		public function StrengthenInfo() 
		{
			
		}
		public function enterStrengthen(info:BagItemInfo):void {
			GlobalAPI.loaderAPI.loadSwf(GlobalAPI.pathManager.getModulePath(ModuleType.STRENGTHEN), _loaderReady, 0);
			function _loaderReady(loader:ILoader):void
			{
				var strengthen:Strengthen = new Strengthen(info);
				SetModuleUtils.addModule(strengthen, null, true, false, ModuleType.STRENGTHEN);
			}
		}
		public function getUpgradeInfo(idx:int,index:int):void {
			UpgradeEquipInfoSocketHandler.send(GlobalData.playerid,idx,index);
		}
		public function showUpgradeInfo(o:Object):void {
			this.dispatchEvent(new ParamEvent(ParamEvent.GET_UPDATE_INFO, o));
		}
		//public function getUpdateMaterial(index:int):void {
			//GetUpdateMaterialSocketHandler.send(GlobalData.playerid,index);
		//}
		public function showUpdateMaterial(o:Object):void {
			this.dispatchEvent(new ParamEvent(ParamEvent.GET_UPDATE_MATERIAL, o));
		}
		public function updateStrengthenItem():void {
			this.dispatchEvent(new Event("updateStrengthenItem"));
		}
		public function upgradeLevel(idx:int,luckynumber:int,brustnumber:int,index:int):void {
			UpgradeEquipLevelSocketHandler.send(GlobalData.playerid, idx, luckynumber, brustnumber, index);
		}
		public var strengthenType:int = 0;
		
		public var useLucky:int = 0;
		public var totalLucky:int = 0;
		public var useExplosion:int = 0;
		public var totalExplosion:int = 0;
		
		public var useStone:int = 0;
		public var mustStone:int = 0;
		public var totalStone:int = 0;
	}

}