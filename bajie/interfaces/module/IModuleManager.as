﻿package bajie.interfaces.module 
{
	import bajie.interfaces.layer.ILayerManager;
	import bajie.interfaces.path.IPathManager;
	import bajie.interfaces.loader.ILoaderApi;
	import bajie.interfaces.loader.IWaitLoading;
	
	public interface IModuleManager 
	{
		function setup(layerManager:ILayerManager, pathManager:IPathManager, loaderapi:ILoaderApi, loadingPanel:IWaitLoading):void;
		/**
		 * 状态模块
		 * @param moduleId
		 * @param moduleNeed 为null则直接加载moduleId，不为空则按顺序加载此数组(moduleId包含在数组里，不另加moduleId)
		 * @param data
		 * @param assetNeeds [path]需要的资源("资源"加密类型)
		 * @param modulePres 预加载资源 loaders
		 * @param showChange
		 * @param cancelAble
		 * 
		 */	
		function setModule(moduleId:int,moduleNeed:Array = null,data:* = null,assetNeeds:Array = null,modulePres:Array = null,showChange:Boolean = true,cancelAble:Boolean = true):void;

		/**
		 * 共存模块
		 * @param moduleId
		 * @param data
		 * @param addToStage是否自动添加到舞台
		 * @param assetNeeds 预加载资源path
		 * @param showLoading 是否显示加载进度
		 */	
		function addModule(moduleId:int,data:Object = null,addToStage:Boolean = false,assetNeeds:Array = null,showLoading:Boolean = true):void;

		/**
		 * 获取当前状态模块
		 * @return 
		 * 
		 */
		function getCurrentModule():IModule;
	}
	
}
