package bajie.manager.path
{
	import bajie.constData.LayerType;
	import bajie.constData.ModuleType;
	import bajie.interfaces.path.IPathManager;
	
	public class PathManager implements IPathManager
	{
		private var _registerPath:String;
		private var _loginPath:String;

		/**
		 * 网站地址
		 */		
		private var _site:String = "";
		private var _webservicePath:String;
		private var _webservicePath2:String;
		/**
		 *充值地址 
		 */		
		private var _fillPath:String;
		/**
		 *激活码页面 
		 */		
		private var _activityCodePath:String;
		/**
		 *防沉迷地址 
		 */		
		private var _adlsPath:String;
		/**
		 *上传照片地址 
		 */		
		private var _imgPath:String;
		/**
		 *官网 
		 */		
		private var _officalPath:String;
		/**
		 *论坛地址 
		 */		
		private var _bbsPath:String;
		private var _statPath:String;
		/**
		 *排行地址 
		 */		
		private var _rankPath:String;
		
		
		public function PathManager(config:XML = null) {
			// constructor code
			if(config == null)
			{
				return;
			}
			if(config)
			{
				_registerPath = String(config.config.REGISTER_PATH.@value);
				_site = String(config.config.SITE.@value);
				_webservicePath = String(config.config.WEBSERVICE_PATH.@value);
				_webservicePath2 = String(config.config.WEBSERVICE_PATH2.@value);
				_fillPath = String(config.config.FILL_PATH.@value);
				_activityCodePath = String(config.config.ACTIVITYCODE.@value);
				_adlsPath = String(config.config.ADLSPATH.@value);
				_imgPath = String(config.config.IMG_PATH.@value);
				_officalPath = String(config.config.OFFICAL_PATH.@value);
				_bbsPath = String(config.config.BBS.@value);
				_loginPath = String(config.config.LOGIN_PATH.@value);
				_statPath = String(config.config.STAT_PATH.@value);
				_rankPath = String(config.config.RANK_PATH.@value);
			}
		}

		public function getModulePath(moduleId:int):String
		{
			switch(moduleId)
			{
				case ModuleType.SCENE:
					return _site + "panel/scene.swf";
				case ModuleType.HALL:
					return _site + "resource/hall.swf";
				case ModuleType.MAIL:
					return _site + "resource/email.swf";
				case ModuleType.SETTING:
					return _site + "resource/userSet.swf";
				case ModuleType.SKILL:
					return _site + "resource/skill.swf";
				case ModuleType.ROOM:
					return _site + "resource/room.swf";
				case ModuleType.BAG:
					return _site + "resource/bag2.swf";
				case ModuleType.STRENGTHEN:
					return _site + "resource/strengthen.swf";
				case ModuleType.FIGHT:
					return _site + "resource/fight.swf";
				case ModuleType.REGISTER:
					return _site + "resource/register.swf";
				case ModuleType.STORE:
					return _site + "resource/shop.swf";
				case ModuleType.TASK:
					return _site + "resource/task.swf";
				case ModuleType.REGARD:
					return _site + "resource/regard.swf";
				case ModuleType.SIGN:
					return _site + "resource/sign.swf";
				case ModuleType.FRIENDS:
					return _site + "resource/friends.swf";
				case ModuleType.NAVIGATION:
					return _site + "resource/main.swf";
				case ModuleType.RANK:
					return _site + "resource/rank.swf";
			}
			return "";
		}
		
		public function getModuleClassPath(moduleId:int):String
		{
			switch(moduleId)
			{
				case ModuleType.SCENE:
					return "";
			}
			return "";
		}
		
		public function getFillPath():String
		{
			return _fillPath;
		}
		
		public function getActivityCode():String
		{
			return _activityCodePath;
		}
		
		public function getItemPath(path:String, layerType:String, dir:int = 0, action:int = 0):String
		{
			if(layerType == LayerType.SCENE_PLAYER)
			{
				return _site + "resource/player/"+ path + ".swf";
			}
			return "";
		}
		
		public function getRankPath():String
		{
			return _rankPath;
		}
		
		/**
		 *获取图片地址 
		 * @param path 类型
		 * @param templateid id编号
		 * @return 
		 * 
		 */		
		public function getDisplayPicPath(path:String, templateid:String):String
		{
			
			return _site + "resource/image/" + path + "/" + templateid + ".jpg";
		}
		
		public function getItemInfoPicPath(path:String):String
		{
			return _site + "resource/image/num/" + path + ".png";
		}
		
		
		public function getItemClassPath(path:String, layerType:String):String
		{
			return path;
		}
		
		public function getSceneMonsterItemsPath(path:String):String
		{
			return "";
		}
		
		public function getSceneItemsPath(path:String, layerType:String):String
		{
			return "";
		}
		
		public function getScenePetItemPath(path:String, layerType:String):String
		{
			return "";
		}
		
		public function getSceneNpcItemsPath(path:String):String
		{
			return "";
		}
		
		public function getSceneCollectItemPath(path:String):String
		{
			return "";
		}
		
		public function getSceneCarItemPath(path:String):String
		{
			return "";
			
		}
		
		public function getCommonSoundPath():String
		{
			return _site + "sound/sound.swf";
		}
		public function getSoundClassPath(path:String):String
		{
			return "dzhz.sound.S" + path;
		}
		public function getMusicPath(music:int):String
		{
			return _site + "music/" + music + ".mp3";
		}
		
		public function getWaitingPath(type:int):String
		{
			return _site + "img/waitingbg/waitingbg" + type + ".swf";
		}
		public function getWaitingClassPath(type:int):String
		{
			return "mhqy.Waitting" + type;
		}
		
		public function getConfigZipPath():String
		{
			return "sm.txt?" + Math.random();
		}
		
		public function getServerListPath():String
		{
			return  "ServerList.ashx";
		}
		
		public function getWebServicePath(path:String):String
		{
			return  path;
		}
		
		public function getFacePath():String
		{
			//			return _site + "img/face/1.swf";
			return _site + "img/face1/1.swf";
		}
		
		public function getMoviePath(path:String):String
		{
			//			return _site + "img/effects/" + path + ".swf";
			return _site + "movie/effect/" + path + ".swf";
		}
		
		public function getSceneConfigPath(picPath:String):String
		{
			return _site + "img/map/config/" + picPath.toString() + ".mc3m";
		}
		
		public function getScenePreMapPath(path:String):String
		{
			//			return _site + "img/map/" + id + "/pre.swf";
			return _site + "img/map/" + path + "/map.jpg";
		}
		public function getScenePreMapClassPath(id:int):String
		{
			return "dzhz.map" + id + "_pre";
		}
		
		public function getSceneDetailMapPath(path:String,row:int,col:int):String
		{
			//			return _site + "img/map/" + id + "/" + row + "_" + col + ".swf";
			return _site + "img/map/" + path + "/" + row + "_" + col + ".jpg";
		}
		public function getSceneDetailMapClassPath(id:int,row:int,col:int):String
		{
			return "dzhz.map" + id + "_" + row + "_" + col;
		}
		public function getSceneDetailClassPath(id:int,x:int,y:int):String
		{
			return "";
		}
		
		public function getWebLoginPath():String
		{
			return "";
		}
		
		public function getLoginPath():String
		{
			return "";
		}
		
		public function getStatPath():String
		{
			return "";
		}
		
		public function getAssetPath(path:String,moduleId:int,language:String = "common"):String
		{
			return "";
		}
		
		public function getPath(path:String):String
		{
			return "";
		}
		
		
		public function getOfficalPath():String
		{
			return "";
		}
		
		public function getBBSPath():String
		{
			return "";
		}
		
		public function getRegisterPath():String
		{
			return "";
		}

	}
	
	
	
}
