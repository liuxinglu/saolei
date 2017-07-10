package bajie.interfaces.path
{
	public interface IPathManager
	{
		/**
		 * 模块资源地址和类地址
		 * @param moduleId
		 * @return 
		 * 
		 */		
		function getModulePath(moduleId:int):String;
		function getModuleClassPath(moduleId:int):String;
		/**
		 * 物品资源地址和类地址
		 * @param pic
		 * @param layerType
		 * @param hatType
		 * @return 
		 * 
		 */		
		function getItemPath(path:String,layerType:String,dir:int = 0,action:int = 0):String;
		function getItemClassPath(path:String,layerType:String):String;
		function getSceneItemsPath(path:String,layerType:String):String;
		function getSceneMonsterItemsPath(path:String):String;
		function getSceneNpcItemsPath(path:String):String;
		function getSceneCarItemPath(path:String):String;
		function getSceneCollectItemPath(path:String):String;
		/**
		 * 公用音效（比如按钮点击等等）
		 * @return 
		 * 
		 */		
		function getCommonSoundPath():String;
		function getSoundClassPath(path:String):String;
		function getMusicPath(music:int):String;
		function getFacePath():String;
		/**
		 * 等待loading资源
		 * @return 
		 * 
		 */		
		function getWaitingPath(type:int):String;
		function getWaitingClassPath(type:int):String;
		/**
		 * 压缩配置文件地址
		 * @return 
		 * 
		 */		
		function getConfigZipPath():String;
		/**
		 * 场景路径
		 * @return 
		 * 
		 */		
		function getSceneConfigPath(picPath:String):String;
		function getScenePreMapPath(path:String):String;
		function getScenePreMapClassPath(id:int):String;
		function getSceneDetailMapPath(path:String,row:int,col:int):String;
		function getSceneDetailMapClassPath(id:int,row:int,col:int):String;
		function getScenePetItemPath(path:String,layerType:String):String;
//		function getSceneUnwalkClassPath(picPath:String):String;
//		function getSceneDetailClassPath(id:int,x:int,y:int):String;
		
		/**
		 * 登陆游戏地址
		 * @return 
		 * 
		 */		
		function getLoginPath():String;
		/**
		 * 排行版地址
		 * @return 
		 * 
		 */		
		function getRankPath():String;
		/**
		 * 网站登陆地址
		 * @return 
		 * 
		 */		
		function getWebLoginPath():String;
		/**
		 * 官网地址
		 * @return 
		 * 
		 */		
		function getOfficalPath():String;
		/**
		 * 论坛地址
		 * @return 
		 * 
		 */		
		function getBBSPath():String;
		/**
		 * 注册页面
		 * @return 
		 * 
		 */		
		function getRegisterPath():String;
		/**
		 * 充值地址
		 * @return 
		 * 
		 */		
		function getFillPath():String;
		/**
		 * 激活码页面
		 * @return 
		 * 
		 */		
		function getActivityCode():String;
		/**
		 * 资源
		 * @return 
		 * 
		 */		
		function getAssetPath(path:String,moduleId:int,language:String = "common"):String;
		/**
		 * 统计地址
		 * @return 
		 * 
		 */		
		function getStatPath():String;
		/**
		 * 动画地址
		 * @param path
		 * @return 
		 * 
		 */		
		function getMoviePath(path:String):String;
		/**
		 * 页面地址
		 * @param path
		 * @return 
		 * 
		 */		
		function getWebServicePath(path:String):String;
		/**
		 *	获取路径 
		 * @param path
		 * @return 
		 * 
		 */		
		function getPath(path:String):String;

	}
}
