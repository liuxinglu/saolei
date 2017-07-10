package bajie.manager.module
{
	import bajie.interfaces.module.IModule;
	import bajie.interfaces.module.IModuleManager;
	import bajie.interfaces.layer.ILayerManager;
	import bajie.interfaces.loader.ILoaderApi;
	import bajie.interfaces.loader.IWaitLoading;
	import bajie.interfaces.path.IPathManager;
	import bajie.interfaces.loader.ILoader;
	import bajie.events.ModuleEvent;
	import flash.utils.Dictionary;
	import bajie.utils.module.ModuleCreator;
	import bajie.utils.module.ModuleTransitionView;
	import flash.display.DisplayObject;
	import bajie.constData.DecodeType;
	import flash.ui.Mouse;
	import bajie.module.ModuleEventDispatcher;
	import bajie.events.BajieDispatcher;
	import bajie.events.ParamEvent;

	public class ModuleManager extends Object implements IModuleManager
    {
        private var _addModules:Dictionary;
        private var _currentModule:IModule;
        private var _loadingPanel:IWaitLoading;
        private var _pathManager:IPathManager;
        private var _moduleCreator:ModuleCreator;
        private var _loaderapi:ILoaderApi;
        private var _tranview:ModuleTransitionView;
        private var _layerManager:ILayerManager;

        public function ModuleManager()
        {
            return;
        }// end function

        private function createModuleSync(moduleId:int, complateHandler:Function, progressHandler:Function = null) : void
        {
            if (_loaderapi.getHadDefined(_pathManager.getModuleClassPath(moduleId)))
            {
                complateHandler(moduleId);
            }
            else
            {
                _moduleCreator.create(moduleId, complateHandler, progressHandler);
            }
            return;
        }// end function

        public function setup(layermanager:ILayerManager, pathManager:IPathManager, loaderapi:ILoaderApi, loadingPanel:IWaitLoading) : void
        {
            _layerManager = layermanager;
            _pathManager = pathManager;
            _loaderapi = loaderapi;
            _loadingPanel = loadingPanel;
            _addModules = new Dictionary();
            _tranview = new ModuleTransitionView(_layerManager.getTipLayer());
            _moduleCreator = new ModuleCreator(_loaderapi, _pathManager);
            return;
        }// end function

        public function getCurrentModule() : IModule
        {
            return _currentModule;
        }// end function

        private function showChanging(moduleId:int, data:Object = null) : void
        {
            var startChange:Function;
            var moduleId:* = moduleId;
            var data:* = data;
            startChange = function () : void
            {
                setModuleImmediately(moduleId, data);
                return;
            }// end function
            ;
            _tranview.start(startChange);
            return;
        }// end function

        public function removeModule(module:IModule) : void
        {
            if (_addModules[module.moduleId] != null)
            {
                delete _addModules[module.moduleId];
            }
            module.free(null);
            return;
        }// end function

        private function addModuleImmediately(moduleId:int, data:Object = null, addToStage:Boolean = false) : void
        {
            if (_addModules[moduleId] != null)
            {
                (_addModules[moduleId] as IModule).configure(data);
                return;
            }
            var _loc_4:IModule = newModule(moduleId);
            if (_loc_4 == null)
            {
                return;
            }
            _loc_4.addEventListener(ModuleEvent.MODULE_DISPOSE, addModuleDisposeHandler);
            _addModules[moduleId] = _loc_4;
            if (addToStage)
            {
                _layerManager.getPopLayer().addChild(_loc_4 as DisplayObject);
            }
            _loc_4.setup(null, data);
            return;
        }// end function

        private function newModule(moduleId:int) : IModule
        {
            var _loc_2:* = _loaderapi.getClassByPath(_pathManager.getModuleClassPath(moduleId));
            if (_loc_2)
            {
                return new _loc_2 as IModule;
            }
            return null;
        }// end function
		
		/**
		 *	注册多一个功能 
		 * @param moduleId
		 * @param data
		 * @param addToStage
		 * @param assetNeeds
		 * @param showLoading
		 * 
		 */		
        public function addModule(moduleId:int, data:Object = null, addToStage:Boolean = false, assetNeeds:Array = null, showLoading:Boolean = true) : void
        {
            var add:Boolean = addToStage;
            var totalLen:int;
            var check:Function;
            var assetLoadComplete:Function;
            var loadingCancel:Function;
            var moduleId:* = moduleId;
            var data:* = data;
            var addToStage:* = addToStage;
            var assetNeeds:* = assetNeeds;
            var showLoading:* = showLoading;
            check = function (moduleId:int) : void
            {
                var _loc_2:String = null;
                if (!add)
                {
                    return;
                }
                if (totalLen == 0)
                {
                    loadComplete();
                }
                else
                {
                    for each (_loc_2 in assetNeeds)
                    {
                        
                        if (_loaderapi.pathHadLoaded(_loc_2))
                        {
                            var _loc_6:* = totalLen - 1;
                            totalLen = _loc_6;
                            continue;
                        }
                        _loaderapi.loadSwf(_loc_2, assetLoadComplete, 3, DecodeType.CLIENT_DECODE);
                    }
                    checkAllAssetComplete();
                }
                return;
            }// end function
            ;
            assetLoadComplete = function (loader:ILoader) : void
            {
                if (loader)
                {
                    loader.dispose();
                }
                var _loc_3:* = totalLen - 1;
                totalLen = _loc_3;
                checkAllAssetComplete();
                return;
            }// end function
            ;
            var checkAllAssetComplete:* = function () : void
            {
                if (totalLen == 0)
                {
                    loadComplete();
                }
                return;
            }// end function
            ;
            loadingCancel = function () : void
            {
                add = false;
                if (_moduleCreator)
                {
                    _moduleCreator.cancelLoad(moduleId);
                }
                return;
            }// end function
            ;
            var loadComplete:* = function () : void
            {
                if (add)
                {
                    addModuleImmediately(moduleId, data, addToStage);
                }
                return;
            }// end function
            ;
            add = addToStage;
            totalLen = assetNeeds == null ? (0) : (assetNeeds.length);
            if (_loaderapi.getHadDefined(_pathManager.getModuleClassPath(moduleId)))
            {
                check(moduleId);
            }
            else if (showLoading)
            {
                _loadingPanel.showModuleLoading(moduleId, loadingCancel);
                createModuleSync(moduleId, check, _loadingPanel.setProgress);
            }
            else
            {
                createModuleSync(moduleId, check);
            }
            return;
        }// end function

        private function setModuleImmediately(moduleId:int, data:Object = null) : void
        {
            if (_currentModule)
            {
	            if (_currentModule.moduleId == moduleId)
	            {
	                _currentModule.configure(data);
	                return;
	            }
			}
            var _loc_3:* = newModule(moduleId);
            if (!_loc_3)
            {
                return;
            }
            if (_currentModule != null)
            {
                _currentModule.free(_loc_3);
            }
            _currentModule = _loc_3;
            _layerManager.getModuleLayer().addChild(_loc_3 as DisplayObject);
            _loc_3.setup(_currentModule, data);
            Mouse.show();
            ModuleEventDispatcher.dispatchModuleEvent(new ModuleEvent(ModuleEvent.MODULE_CHANGE, moduleId));
            return;
        }// end function

/**
		 *	添加或添加唯一的功能. 
		 * @param moduleId
		 * @param moduleNeed
		 * @param data
		 * @param assetNeeds
		 * @param modulePres
		 * @param showChange
		 * @param cancelAble
		 * 
		 */		
        public function setModule(moduleId:int, moduleNeed:Array = null, data:* = null, assetNeeds:Array = null, modulePres:Array = null, showChange:Boolean = true, cancelAble:Boolean = true) : void
        {
/*            var modules:Array;
            var loaded:int;
            var assetLoaded:int;
            var assetTotal:int;
            var toId:int;
            var goto:Boolean = true;
            var targetModule:int;
            var loadingCancel:Function;
            var check:Function;
            var assetLoadComplete:Function;
            var moduleId:* = moduleId;
            var moduleNeed:* = moduleNeed;
            var data:* = data;
            var assetNeeds:* = assetNeeds;
            var modulePres:* = modulePres;
            var showChange:* = showChange;
            var cancelAble:* = cancelAble;
            var loadNext:* = function () : void
            {
                var _loc_1:Function = null;
                if (!_loaderapi.getHadDefined(_pathManager.getModuleClassPath(modules[loaded])))
                {
                    _loc_1 = cancelAble ? (loadingCancel) : (null);
                    _loadingPanel.showModuleLoading(moduleId, _loc_1);
                    createModuleSync(modules[loaded], check, _loadingPanel.setProgress);
                }
                else
                {
                    check(modules[loaded]);
                }
                return;
            }// end function
            ;
            loadingCancel = function () : void
            {
                goto = false;
                if (_moduleCreator)
                {
                    _moduleCreator.cancelLoad(moduleId);
                }
                return;
            }// end function
            ;
            check = function (moduleId:int) : void
            {
                if (loaded == 0)
                {
                    targetModule = toId;
                }
                var _loc_3:* = loaded + 1;
                loaded = _loc_3;
                if (loaded == modules.length)
                {
                    checkAsset();
                }
                else
                {
                    loadNext();
                }
                return;
            }// end function
            ;
            var checkAsset:* = function () : void
            {
                var _loc_1:String = null;
                if (assetTotal == 0)
                {
                    allLoadComplete();
                }
                else
                {
                    for each (_loc_1 in assetNeeds)
                    {
                        
                        if (_loaderapi.pathHadLoaded(_loc_1))
                        {
							allLoadComplete();
                            continue;
                        }
                        _loaderapi.loadSwf(_loc_1, assetLoadComplete, 3, DecodeType.RESOURCE_DECODE);
                    }
                }
                return;
            }// end function
            ;
            assetLoadComplete = function (loader:ILoader) : void
            {
                var _loc_3:* = assetLoaded + 1;
                assetLoaded = _loc_3;
                if (assetLoaded >= assetTotal)
                {
                    allLoadComplete();
                }
                loader.dispose();
                return;
            }// end function
            ;
            var allLoadComplete:* = function () : void
            {
                var _loc_1:ILoader = null;
                if (modulePres != null)
                {
	                if (modulePres.length > 0)
	                {
	                    for each (_loc_1 in modulePres)
	                    { 
	                        _loc_1.loadSync();
	                    }
	                }
				}
                //_loadingPanel.hide();
                if (!goto)
                {
                    return;
                }
                if (showChange)
                {
                    changeMethod(targetModule, data);
                }
                else
                {
                    setModuleImmediately(targetModule, data);
                }
                return;
            }// end function
            ;
			modules = new Array();
            loaded;
            assetLoaded;
            assetTotal = assetNeeds == null ? (0) : (assetNeeds.length);
            toId = moduleId;
            goto;
            var changeMethod:* = showChanging;
            modules.push(moduleId);
            if (moduleNeed != null)
            {
                modules = moduleNeed;
            }
            loadNext();
            return;*/
			BajieDispatcher.getInstance().dispatchEvent(new ParamEvent(BajieDispatcher.SCENE_LOADING_INTO));
        }// end function

        private function addModuleDisposeHandler(event:ModuleEvent) : void
        {
            var _loc_2:* = event.currentTarget as IModule;
            _loc_2.removeEventListener(ModuleEvent.MODULE_DISPOSE, addModuleDisposeHandler);
            delete _addModules[_loc_2.moduleId];
            return;
        }// end function
	}
}