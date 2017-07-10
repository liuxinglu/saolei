// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//dzhz.loader.newResource.PicLoaderList

package bajie.utils.loader.newResource{
    import bajie.utils.loader.PicLoader;
    import flash.display.BitmapData;
    import flash.utils.getTimer;

    public class PicLoaderList {

        public var path:String;
        public var callbacks:Array;
        private var _picLoader:PicLoader;
        public var clearType:int;
        private var _data:BitmapData;
        public var quoteCount:int;
        public var clearTime:int;
        public var currentTime:int;

        public function PicLoaderList(path:String, callback:Function, clearType:int = 0, clearTime:int=2147483647){
            this.path = path;
            this.callbacks = [];
            this.clearTime = clearTime;
            this.currentTime = int.MAX_VALUE;
            this.quoteCount = 0;
            this.addCallback(callback);
            this.clearType = clearType;
            this.initLoad();
        }

        private function initLoad():void{
            this._picLoader = new PicLoader(this.path, this.loadComplete, 3);
            this._picLoader.loadSync();
        }

        private function loadComplete(loader:PicLoader):void{
            var i:Function;
            this._data = loader.bdData;
            for each (i in this.callbacks) {
                (i(this._data));
            };
            this.callbacks.length = 0;
        }

        public function addCallback(func:Function):void{
            if (this._data){
                (func(this._data));
                this.quoteCount++;
            }
            else {
                if (this.callbacks.indexOf(func) == -1){
                    this.callbacks.push(func);
                    this.quoteCount++;
                };
            };
        }

        public function removeCallback():void{
            this.quoteCount--;
            if (this.quoteCount < 0){
                this.quoteCount = 0;
            };
        }

        public function start():void{
            this.currentTime = getTimer();
        }

        public function stop():void{
            this.currentTime = int.MAX_VALUE;
        }

        public function getClear():Boolean{
            return (((getTimer() - this.currentTime) > this.clearTime));
        }

        public function dispose():void{
            if (this._picLoader){
                this._picLoader.dispose();
                this._picLoader = null;
            };
            this._data = null;
            this.callbacks = null;
        }


    }
}//package dzhz.loader.newResource

