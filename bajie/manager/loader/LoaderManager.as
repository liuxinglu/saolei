package bajie.manager.loader
{
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.events.Event;
	import flash.net.URLRequest;
	import bajie.interfaces.loader.ILoaderApi;
	import bajie.utils.loader.resource.DataFileManager;
	import bajie.utils.loader.resource.DisplayFileManager;
	import bajie.utils.loader.resource.PngPackageManager;
	import bajie.utils.loader.newResource.PicLoaderManager;
	import bajie.utils.loader.newResource.PacckageLoaderManager;
	import bajie.interfaces.loader.ICacheApi;
	import bajie.interfaces.decode.IDecode;
	import bajie.interfaces.tick.ITickManager;
	import flash.system.ApplicationDomain;
	import bajie.interfaces.loader.ILoader;
	import bajie.utils.loader.ModuleLoader;
	import bajie.utils.loader.ZipLoader;
	import bajie.utils.loader.QueueLoader;
	import bajie.utils.loader.WebserviceLoader;
	import bajie.manager.module.ModuleLoaderManager;

	public class LoaderManager implements ILoaderApi
	{
		public static var localCache:ICacheApi;
        public static var decode:IDecode;
        public static var tickManager:ITickManager;
        public static var domain:ApplicationDomain;
        public static var version:int;

        private var _dataFileManager:DataFileManager;
        private var _displayFileManager:DisplayFileManager;
        private var _pngPackageManager:PngPackageManager;
        private var _picFileManager:PicLoaderManager;
        private var _packageFileManager:PacckageLoaderManager;
		
		public function LoaderManager()
		{
			
		}
		
		/**
		加载配置文件
		*/
		public static function createUrlLoader(path:String, func:Function, format:String = URLLoaderDataFormat.TEXT):void
		{
			var urlLoader:URLLoader = new URLLoader;
			urlLoader.dataFormat = format;
			
			function onComplete(e:Event):void
			{
				urlLoader.removeEventListener(Event.COMPLETE, onComplete);
				func(urlLoader.data);
			}
			
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.load(new URLRequest(path));
		}
		



        public static function addRandomCode(path:String):String{
            if (path.indexOf("?") == -1){
                return (((path + "?") + version));
            };
            return (((path + "&rnd=") + version));
        }

        public static function addVersionCode(path:String):String{
            if (path.indexOf("?") == -1){
                return (((path + "?") + version));
            };
            return (((path + "&rnd=") + version));
        }


        public function setup(domain:ApplicationDomain, dec:IDecode=null, cache:ICacheApi=null, version:int=1000):void{
            LoaderManager.domain = domain;
            LoaderManager.version = version;
            decode = dec;
            localCache = cache;
            this._pngPackageManager = new PngPackageManager();
            this._dataFileManager = new DataFileManager();
            this._displayFileManager = new DisplayFileManager();
            this._picFileManager = new PicLoaderManager();
            this._packageFileManager = new PacckageLoaderManager();
        }

        public function setTickManager(manager:ITickManager):void{
            tickManager = manager;
            tickManager.addTick(this._picFileManager);
            tickManager.addTick(this._packageFileManager);
        }

        public function loadSwf(path:String, callback:Function, tryTime:int=1, hadCryptType:int=0):ILoader{
            var loader:ModuleLoader = new ModuleLoader(path, callback, tryTime, hadCryptType);
           
			loader.loadSync();
			
            return (loader);
        }

        public function loadZip(path:String, callback:Function, tryTime:int=1, decodeType:int=1):ILoader{
            var loader:ZipLoader = new ZipLoader(path, callback, tryTime, decodeType);
            loader.loadSync();
            return (loader);
        }

        public function loadQueueLoader(loaders:Array, callback:Function=null):ILoader{
            var loader:QueueLoader = new QueueLoader(loaders, callback);
            loader.loadSync();
            return (loader);
        }
		public function createSwfLoader(path:String, callback:Function, tryTime:int=1, hadCryptType:int=0):ILoader{
            return (new ModuleLoader(path, callback, tryTime, hadCryptType));
        }

        public function createZipLoader(path:String, callback:Function, tryTime:int=1, decodeType:int=1):ILoader{
            return (new ZipLoader(path, callback, tryTime, decodeType));
        }

        public function createQueueLoader(loaders:Array, callback:Function=null):ILoader{
            return (new QueueLoader(loaders, callback));
        }

        public function loadRequest(path:String, param:Object=null, callback:Function=null, isCompress:Boolean=false, tryTime:int=1):ILoader{
            var loader:WebserviceLoader = new WebserviceLoader(path, param, callback, isCompress, tryTime);
            loader.loadSync();
            return (loader);
        }

        public function createRequestLoader(path:String, param:Object=null, callback:Function=null, isCompress:Boolean=false, tryTime:int=1):ILoader{
            return (new WebserviceLoader(path, param, callback, isCompress, tryTime));
        }

        public function getHadDefined(path:String):Boolean{
            return (domain.hasDefinition(path));
        }

        public function getClassByPath(path:String):Class{
            var path:String = path;
            return ((domain.getDefinition(path) as Class));
//            e = e;
            return (null);
        }

        public function getObjectByClassPath(path:String):Object{
            var path:String = path;
            var cl:Class = this.getClassByPath(path);
            if (cl){
                return (new (cl)());
//                e = e;
            };
            return (null);
        }

        public function pathHadLoaded(path:String):Boolean{
            return (ModuleLoaderManager.getPathHadLoaded(path));
        }

        public function loadConfig(path:String, callback:Function, tryTime:int=1, decodeType:int=0):ILoader{
            return (null);
        }

        public function loadData(path:String, callback:Function, tryTime:int=1, decodeType:int=0):ILoader{
            return (null);
        }

        public function createConfigLoader(path:String, callback:Function, tryTime:int=1, decodeType:int=0):ILoader{
            return (null);
        }

        public function getDisplayFile(path:String, classPath:String, callback:Function, clearType:int):void{
            this._displayFileManager.getFile(path, classPath, callback, clearType);
        }

        public function removeDisplayFile(path:String, callback:Function):void{
            this._displayFileManager.removeQuote(path, callback);
        }

        public function displayTimeclear(path:String, checkQuote:Boolean=false):void{
            this._displayFileManager.timeclear(path, checkQuote);
        }

        public function getDataFile(path:String, callback:Function, clearType:int):void{
        }

        public function getDataSourceFile(path:String, callback:Function, clearType:int):void{
            this._dataFileManager.getDataSourceFile(path, callback, clearType);
        }
		
		public function removeDataFile(path:String, callback:Function):void{
            this._dataFileManager.removeQuote(path, callback);
        }

        public function dataTimeClear(path:String, checkQuote:Boolean=false):void{
        }

        public function getPngPackageFile(path:String, id:int, layerType:String, playerSex:int, callback:Function, clearType:int):void{
            this._pngPackageManager.getFile(path, id, layerType, playerSex, callback, clearType);
        }

        public function removePngPackageFile(path:String, callback:Function):void{
            this._pngPackageManager.removeQuote(path, callback);
        }

        public function changeSceneClear():void{
            this._dataFileManager.changeSceneClear();
            this._displayFileManager.changeSceneClear();
            this._pngPackageManager.changeSceneClear();
            this._picFileManager.changeSceneClear();
            this._packageFileManager.changeSceneClear();
        }

        public function getPicFile(path:String, callback:Function, clearType:int, clearTime:int=214783647):void{
            this._picFileManager.getFile(path, callback, clearType, clearTime);
        }

        public function removeAQuote(path:String):void{
            this._picFileManager.removeAQuote(path);
        }

        public function getPackageFile(path:String, callback:Function, clearType:int, clearTime:int=214783647):void{
            this._packageFileManager.getFile(path, callback, clearType, clearTime);
        }

        public function removePackageAQuote(path:String):void{
            this._packageFileManager.removeAQuote(path);
        }

	}
}