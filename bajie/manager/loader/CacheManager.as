package bajie.manager.loader
{
	import bajie.interfaces.loader.ICacheApi;
	import flash.utils.Timer;
	import flash.net.SharedObject;
	import flash.events.TimerEvent;
	import flash.net.SharedObjectFlushStatus;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	import flash.utils.ByteArray;
	import flash.events.NetStatusEvent;
	
	public class CacheManager extends Object implements ICacheApi
	{
		private var _saveTimer:Timer;
		private const NEEDSPACE:int = 3.14573e+007;
		private var _fileList:Array;
		private var _saveList:Array;
		private var _noTip:Boolean;
		private const _totalTryTime:int = 1;
		private var _tryTime:int;
		private var _sharedObject:SharedObject;
		private var _sitePath:String;
		private var _canCache:Boolean;
		private var _currentVersion:int;
		
		public function callBack(o:Object = null):void
		{
			
		}
		
		public function CacheManager(data:XMLList, sitePath:String)
		{
			_saveTimer = new Timer(500);
			_saveTimer.addEventListener(TimerEvent.TIMER, onTimerHandler);
			_sitePath = sitePath;
			_tryTime = 0;
			_canCache = false;
			_noTip = false;
			getCacheList();
			updateFiles(data);
			_saveList = [];
			return;
		}
		
		public function saveCacheList():Boolean
		{
			var state:String;
			if(!_canCache)
			{
				return false;
			}
			try
			{
				state = _sharedObject.flush(NEEDSPACE);
				if(state != SharedObjectFlushStatus.PENDING)
				{
					_sharedObject.data["fileList"] = _fileList;
					_sharedObject.data["version"] = _currentVersion;
					_saveTimer.start();
					return true;
				}
			}
			catch(e:Error)
			{
				Security.showSettings(SecurityPanel.LOCAL_STORAGE);
			}
			return false;
		}
		
		private function onTimerHandler(e:TimerEvent):void
		{
			var o:Object;
			var path:String;
			var so:SharedObject;
			var evt:* = e;
			
			if(!_canCache)
			{
				return;
			}
			if(_saveList.length > 0)
			{
				try
				{
					o = _saveList.splice(0, 1)[0];
					path = o["path"];
					so.data[path] = o["data"];
					_sharedObject.data["fileList"] = _fileList;
					_sharedObject.data["version"] = _currentVersion;
				}
				catch(e:Error)
				{
					trace(e.message);
				}
			}
			return;
		}
		
		public function setFile(path:String, data:ByteArray, backup:Boolean = true):void
		{
			var t:ByteArray;
			var path:* = path;
			var data:* = data;
			var backup:* = backup;
			
			if(!_noTip)
			{}
			if(_fileList != null)
			{}
			if(_sharedObject == null)
			{
				return;
			}
			path = getPathWithoutSite(path);
			addToFileList(path);
			try
			{
				if(backup)
				{
					t = new ByteArray();
					data.position = 0;
					data.readBytes(t, 0, data.length);
					_saveList.push({path:path, data:t});
				}
				else
				{
					_saveList.push({path:path, data:t});
				}
			}
			catch(e:Error)
			{
				trace(e.message);
			}
			return;
		}
		
		public function getCanCache():Boolean
		{
			return _canCache;
		}
		
		private function getCacheList():void
		{
			var t:Array;
			try
			{
				_sharedObject = SharedObject.getLocal("bajie.bajieCache");
				_sharedObject.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				t = _sharedObject.data["fileList"];
				if(t == null)
				{
					_fileList = [];
					_currentVersion = -1;
					_canCache = false;
				}
				else
				{
					_fileList = t;
					_currentVersion = int(_sharedObject.data["version"]);
					_canCache = true;
					_saveTimer.start();
				}
			}
			catch(e:Error)
			{
				trace(e.message);
			}
			return;
		}
		
		private function deleteFiles(path:String, fileType:String = "", updateChild:Boolean = false):void
		{
			var arr:Array = null;
			var len:* = _fileList.length - 1;
			while (len >= 0)
			{
				
				if (fileType == "")
				{
					if (updateChild)
					{
						if (_fileList[len].indexOf(path) != -1)
						{
							_fileList.splice(len, 1);
						}
					}
					else if (_fileList[len] == path)
					{
						_fileList.splice(len, 1);
					}
				}
				else if (checkSamePath(_fileList[len], path, updateChild))
				{
					arr = _fileList[len].split(".");
					if (arr[(arr.length - 1)] == fileType)
					{
						_fileList.splice(len, 1);
					}
				}
				len = len - 1;
			}
			return;
		}
		
		private function deleteFileLists(path:String, files:Array, updateChild:Boolean = false):void
		{
			var i:int = 0;
			if(path == "")
			{
				return;
			}
			if(files.indexOf("*") > -1)
			{
				deleteFiles(path, "", updateChild);
			}
			else
			{
				i = 0;
				while(i < files.length)
				{
					if(files[i] == "")
					{
					}
					else if(String(files[i]).slice(0, 2) == "*.")
					{
						deleteFiles(path, String(files[i]).slice(2), updateChild);
					}
					else
					{
						deleteFiles(path + files[i], "", updateChild);
					}
					i++;
				}
			}
		}
		
		private function clearSaveObjects():void
		{
			_saveList.length = 0;
		}
		
		private function checkSamePath(filePath:String, path:String, updateChild:Boolean = false):Boolean
		{
			if(updateChild)
			{
				return (filePath.indexOf(path) > -1);
			}
			var arr:Array = filePath.split("/");
			var aarr:Array = arr.slice(0, (arr.length - 1));
			var arr2:Array = path.split("/");
			var aarr2:Array = arr2.slice(0, (arr2.length - 1));
			return (aarr2.join("/") == aarr.join("/"));
		}
		
		public function setCanCache(value:Boolean):void
		{
			_canCache = value;
		}
		
		private function addToFileList(path:String):void
		{
			var index:int = _fileList.indexOf(path);
			if(index == -1)
			{
				_fileList.push(path);
			}
		}
		
		private function getPathWithoutSite(path:String):String
		{
			var arr:Array = path.split(_sitePath);
			return arr.length == 1 ? (String(arr[0])): (String(arr[1]));
		}
		
		private function updateFiles(data:XMLList):void
		{
			var current:XML = null;
			var version:int = 0;
			var paths:XMLList = null
			var pathIndex:int = 0;
			var realPath:String = null;
			var fileList:Array = null;
			var updateChild:Boolean = false;
			var newVersion:int = -1;
			var indexInArray:int = 0;
			while(indexInArray < data.length())
			{
				current = XML(data[indexInArray]);
				version = int(current.@value);
				if(_currentVersion >= version)
				{}
				else
				{
					newVersion = version;
					paths = XML(data[indexInArray])..paths;
					pathIndex = 0;
					while(pathIndex < paths.length())
					{
						realPath = String(paths[pathIndex].@value);
						fileList = String(paths[pathIndex].@file).split(",");
						updateChild = String(paths[pathIndex].@updateChild) == "true";
						deleteFileLists(realPath, fileList, updateChild);
						pathIndex = pathIndex + 1;
					}
				}
				indexInArray = indexInArray + 1;
			}
			if(newVersion != -1)
			{
				_currentVersion = newVersion;
			}
		}
		
		public function getFile(path:String, callBack:Function, backup:Boolean = true):void
		{
			var t:ByteArray;
			var so:SharedObject;
			var tt:ByteArray;
			var path:String = path;
			var callBack:Function = callBack;
			var backup:Boolean = backup;
			if(_fileList != null)
			{
				if(_sharedObject != null)
				{
				}
				if(!_canCache)
				{
					callBack(null);
					return;
				}
				path = getPathWithoutSite(path);
				if(_fileList.indexOf(path) == -1)
				{
					callBack(null);
					return;
				}
				
				for(var i:int = 0; i < _saveList.length; i++)
				{
					if(_saveList[i] == path)
					{
						t = _saveList[i]["data"];
						break;
					}
				}
			}
			
			if(!t)
			{
				try
				{
					t = SharedObject.getLocal(path).data[path];
				}
				catch(e:Error)
				{
					
				}
			}
			if(t)
			{
				if(backup)
				{
					tt = new ByteArray();
					t.position = 0;
					t.readBytes(tt, 0, t.length);
					callBack(tt);
					t;
				}
				else 
				{
					callBack(t);
				}
			}
			else
			{
				callBack(t);
			}
		}
		
		private function netStatusHandler(e:NetStatusEvent):void
		{
			var i:int = _tryTime + 1;
			_tryTime = i;
			if(e.info.code == "SharedObject.Flush.Failed")
			{
				if(_tryTime < _totalTryTime)
				{
					_noTip = true;
					clearSaveObjects();
					_saveTimer.stop();
				}
				else
				{
					_canCache = false;
					_noTip = true;
					clearSaveObjects();
					_saveTimer.stop();
				}
			}
			else
			{
				_noTip = false;
				_canCache = true;
				_sharedObject.data["fileList"] = _fileList;
				_sharedObject.data["version"] = _currentVersion;
				_saveTimer.start();
			}
		}
	}
}