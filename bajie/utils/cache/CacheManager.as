package bajie.utils.cache
{
	import bajie.interfaces.loader.ICacheApi;
	
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.utils.*;
	
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
		
		public function callBack(obj:Object = null):void 
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
			updateFiles(data);		//YAY
			_saveList = [];
			return;
		}// end function
		
		public function saveCacheList() : Boolean
		{
			var state:String;
			if (!_canCache)
			{
				return false;
			}
			try
			{
				state = _sharedObject.flush(NEEDSPACE);
				if (state != SharedObjectFlushStatus.PENDING)
				{
					_sharedObject.data["fileList"] = _fileList;
					_sharedObject.data["version"] = _currentVersion;
					_saveTimer.start();
					return true;
				}
			}
			catch (e:Error)
			{
				Security.showSettings(SecurityPanel.LOCAL_STORAGE);
			}
			return false;
		}// end function
		
		private function onTimerHandler(event:TimerEvent) : void
		{
			var o:Object;
			var path:String;
			var so:SharedObject;
			var evt:* = event;
			if (!_canCache)
			{
				return;
			}
			if (_saveList.length > 0)
			{
				try
				{
					o = _saveList.splice(0, 1)[0];
					path = o["path"];
					so = SharedObject.getLocal(path);
					so.data[path] = o["data"];
					o;
					_sharedObject.data["fileList"] = _fileList;
					_sharedObject.data["version"] = _currentVersion;
				}
				catch (e:Error)
				{
					trace(e);
				}
			}
			return;
		}// end function
		
		public function setFile(path:String, data:ByteArray, backup:Boolean = true) : void
		{
			var t:ByteArray;
			var path:* = path;
			var data:* = data;
			var backup:* = backup;
			if (!_noTip)
			{
			}
			if (_fileList != null)
			{
			}
			if (_sharedObject == null)
			{
				return;
			}
			path = getPathWithoutSite(path);
			addToFileList(path);
			try
			{
				if (backup)
				{
					t = new ByteArray();
					data.position = 0;
					data.readBytes(t, 0, data.length);
					_saveList.push({path:path, data:t});
				}
				else
				{
					_saveList.push({path:path, data:data});
				}
			}
			catch (e:Error)
			{
				trace(e.message);
			}
			return;
		}// end function
		
		public function getCanCache() : Boolean
		{
			return _canCache;
		}// end function
		
		private function getCacheList() : void
		{
			var t:Array;
			try
			{
				_sharedObject = SharedObject.getLocal("dzhz/dzhzCache");
				_sharedObject.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				t = _sharedObject.data["fileList"]; 
				if (t == null)
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
			catch (e:Error)
			{
				trace(e.message);
			}
			return;
		}// e nd function
		
		private function deleteFiles(path:String, fileType:String = "", updateChild:Boolean = false) : void
		{
			var _loc_5:Array = null;
			var _loc_4:* = _fileList.length - 1;
			while (_loc_4 >= 0)
			{
				
				if (fileType == "")
				{
					if (updateChild)
					{
						if (_fileList[_loc_4].indexOf(path) != -1)
						{
							_fileList.splice(_loc_4, 1);
						}
					}
					else if (_fileList[_loc_4] == path)
					{
						_fileList.splice(_loc_4, 1);
					}
				}
				else if (checkSamePath(_fileList[_loc_4], path, updateChild))
				{
					_loc_5 = _fileList[_loc_4].split(".");
					if (_loc_5[(_loc_5.length - 1)] == fileType)
					{
						_fileList.splice(_loc_4, 1);
					}
				}
				_loc_4 = _loc_4 - 1;
			}
			return;
		}// end function
		
		private function deleteFileLists(path:String, files:Array, updateChild:Boolean = false) : void
		{
			var _loc_4:int = 0;
			if (path == "")
			{
				return;
			}
			if (files.indexOf("*") > -1)
			{
				deleteFiles(path, "", updateChild);
			}
			else
			{
				_loc_4 = 0;
				while (_loc_4 < files.length)
				{
					
					if (files[_loc_4] == "")
					{
					}
					else if (files[_loc_4].slice(0, 2) == "*.")
					{
						deleteFiles(path, files[_loc_4].slice(2), updateChild);
					}
					else
					{
						deleteFiles(path + files[_loc_4], "", updateChild);
					}
					_loc_4 = _loc_4 + 1;
				}
			}
			return;
		}// end function
		
		private function clearSaveObjects() : void
		{
			_saveList.length = 0;
			return;
		}// end function
		
		private function checkSamePath(filePath:String, path:String, updateChild:Boolean = false) : Boolean
		{
			if (updateChild)
			{
				return filePath.indexOf(path) > -1;
			}
			var _loc_4:* = filePath.split("/");
			var _loc_5:* = _loc_4.slice(0, (_loc_4.length - 1));
			var _loc_6:* = path.split("/");
			var _loc_7:* = _loc_6.slice(0, (_loc_6.length - 1));
			return _loc_7.join("/") == _loc_5.join("/");
		}// end function
		
		public function setCanCache(value:Boolean) : void
		{
			_canCache = value;
			return;
		}// end function
		
		private function addToFileList(path:String) : void
		{
			var _loc_2:* = _fileList.indexOf(path);
			if (_loc_2 == -1)
			{
				_fileList.push(path);
			}
			return;
		}// end function
		
		private function getPathWithoutSite(path:String) : String
		{
			var _loc_2:* = path.split(_sitePath);
			return _loc_2.length == 1 ? (String(_loc_2[0])) : (String(_loc_2[1]));
		}// end function
		
		private function updateFiles(data:XMLList) : void
		{
			var current:XML = null;
			var version:int = 0;
			var paths:XMLList = null;
			var pathIndex:int = 0;
			var realPath:String = null;
			var fileList:Array = null;
			var updateChild:Boolean = false;
			var newVersion:int = -1;
			var indexInArray:int = 0;
			while (indexInArray < data.length())
			{
				
				current = XML(data[indexInArray]);
				version = int(current.@value);
				if (_currentVersion >= version)
				{
				}
				else
				{
					newVersion = version;
					paths = XML(data[indexInArray])..paths;
					pathIndex = 0;
					while (pathIndex < paths.length())
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
			if (newVersion != -1)
			{
				_currentVersion = newVersion;
			}
			return;
		}// end function
		
		public function getFile(path:String, callBack:Function, backup:Boolean = true) : void
		{
			var t:ByteArray;
			var so:SharedObject;
			var tt:ByteArray;
			var path:* = path;
			var callBack:* = callBack;
			var backup:* = backup;
			if (_fileList != null)
			{
				if (_sharedObject != null)
				{
				}
				if (!_canCache)
				{
					callBack(null);
					return;
				}
				path = getPathWithoutSite(path);
				if (_fileList.indexOf(path) == -1)
				{
					callBack(null);
					return;
				}
				
				for(var i:int = 0; i < _saveList.length; i++) {
					if(_saveList[i] == path) {
						t = _saveList[i]["data"];
						break;
					}
				} 
			}
			
			
			if (!t)
			{
				try
				{ 
					t = SharedObject.getLocal(path).data[path]; 
				}
				catch (e:Error)
				{
//					trace(e.message);
				}
			}
			if (t)
			{
				if (backup)
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
				callBack(null);
			}
			return;
		}// end function
		
		private function netStatusHandler(event:NetStatusEvent) : void
		{
			var _loc_3:* = _tryTime + 1;
			_tryTime = _loc_3;
			if (event.info.code == "SharedObject.Flush.Failed")
			{
				if (_tryTime < _totalTryTime)
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
			return;
		}// end function
	}
}
