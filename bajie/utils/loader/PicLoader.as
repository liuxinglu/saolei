// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//dzhz.loader.PicLoader

package bajie.utils.loader{
    import bajie.events.LoaderEvent;
    import bajie.interfaces.loader.*;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import bajie.manager.loader.LoaderManager;

    public class PicLoader extends EventDispatcher implements ILoader {

        protected var _isStart:Boolean;
        protected var _url:String;
        private var _callbacks:Array;
        protected var _tryTime:int;
        protected var _hasTryTime:int;
        protected var _isfinish:Boolean;
        protected var _loader:Loader;
        public var bdData:BitmapData;

        public function PicLoader(path:String, callBack:Function=null, tryTime:int=1){
            this._url = path;
            this._callbacks = [];
            this._tryTime = tryTime;
            if (callBack != null){
                this._callbacks.push(callBack);
            };
            this._isfinish = false;
            this._hasTryTime = 0;
            this._loader = new Loader();
            this.initEvent();
        }

        private function initEvent():void{
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.completeHandler);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
            this._loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.progressHandler);
        }

        private function removeEvent():void{
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.completeHandler);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
            this._loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.progressHandler);
        }

        protected function completeHandler(evt:Event):void{
            var i:Function;
            var evt:Event = evt;
            this.bdData = (this._loader.content as Bitmap).bitmapData;
            this._isStart = false;
            this._isfinish = true;
            try {
                for each (i in this._callbacks) {
                    if (i != null){
                        (i(this));
                    };
                };
            }
            catch(err:Error) {
                trace(err.message, _url);
                trace(err.getStackTrace());
            };
            dispatchEvent(new LoaderEvent(LoaderEvent.LOAD_COMPLETE));
        }

        protected function progressHandler(evt:ProgressEvent):void{
            if ((((evt.bytesLoaded == evt.bytesTotal)) && ((evt.bytesLoaded == 1308)))){
                return;
            };
            dispatchEvent(new LoaderEvent(LoaderEvent.LOAD_PROGRESS, null, evt.bytesLoaded, evt.bytesTotal));
        }

        protected function ioErrorHandler(evt:IOErrorEvent):void{
            trace(("ioError:" + evt.text), this._url);
            this.onError();
        }

        protected function securityErrorHandler(evt:SecurityErrorEvent):void{
            trace(("securityError:" + evt.text), this._url);
            this.onError();
        }

        protected function onError():void{
            this._hasTryTime++;
            try {
                if (this._hasTryTime == this._tryTime){
                    this._isStart = false;
                    dispatchEvent(new LoaderEvent(LoaderEvent.LOAD_ERROR));
                }
                else {
                    this._isStart = false;
                    this.loadSync();
                };
            }
            catch(err:Error) {
                trace(err.message, _url);
                trace(err.getStackTrace());
            };
        }

        public function loadSync(context:LoaderContext=null):void{
            if (!(this._isStart)){
                this._loader.load(new URLRequest(LoaderManager.addVersionCode(this._url) ) );
            };
        }

        public function cancel():void{
            if (this._isStart){
                this._isStart = false;
                this.dispose();
            };
        }

        public function get isStart():Boolean{
            return (this._isStart);
        }

        public function get path():String{
            return (this._url);
        }

        public function set path(value:String):void{
            this._url = value;
        }

        public function get isFinish():Boolean{
            return (this._isfinish);
        }

        public function addCallBack(callBack:Function):void{
            if (this._callbacks != null){
                this._callbacks.push(callBack);
            };
        }

        public function setDataFormat(value:String):void{
        }

        public function getData():*{
            return (null);
        }

        public function dispose():void{
            this.removeEvent();
            try {
                if (this._loader){
                    this._loader.unload();
                    this._loader.close();
                };
            }
            catch(e:Error) {
            };
            if (this.bdData){
                this.bdData.dispose();
            };
            this.bdData = null;
            this._loader = null;
            this._callbacks = null;
        }


    }
}//package dzhz.loader

