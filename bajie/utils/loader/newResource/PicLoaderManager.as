// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//dzhz.loader.newResource.PicLoaderManager

package bajie.utils.loader.newResource{
    import flash.utils.Dictionary;
    import bajie.constData.SourceClearType;
    import bajie.interfaces.tick.*;

    public class PicLoaderManager implements ITick {

        public var caches:Dictionary;
        public var clearList:Array;

        public function PicLoaderManager(){
            this.caches = new Dictionary();
            this.clearList = [];
            super();
        }

        public function getFile(path:String, callback:Function, clearType:int, clearTime:int=214783647):void{
            var cache:PicLoaderList = this.caches[path];
            if (cache == null){
                cache = new PicLoaderList(path, callback, clearType, clearTime);
                this.caches[cache.path] = cache;
            }
            else {
                cache.addCallback(callback);
            };
            this.setCacheClearList(cache);
        }

        public function removeAQuote(path:String):void{
            var cache:PicLoaderList = this.caches[path];
            if (cache){
                cache.removeCallback();
                this.setCacheClearList(cache);
            };
        }

        public function setCacheClearList(cache:PicLoaderList):void{
            var index:int;
            if (cache.quoteCount <= 0){
                if (((!((cache.clearType == SourceClearType.CHANGESCENE_AND_TIME))) && (!((cache.clearType == SourceClearType.TIME))))){
                    return;
                };
                if (this.clearList.indexOf(cache) > -1){
                    return;
                };
                cache.start();
                this.clearList.push(cache);
            }
            else {
                cache.stop();
                index = this.clearList.indexOf(cache);
                if (index > -1){
                    this.clearList.splice(index, 1);
                };
            };
        }

        public function update(times:int, dt:Number=0.04):void{
            var cache:PicLoaderList;
            var len:int = this.clearList.length;
            var i:int = (len - 1);
            while (i >= 0) {
                cache = this.clearList[i];
                if (cache.getClear()){
                    delete this.caches[cache.path];
                    cache.dispose();
                    this.clearList.splice(i, 1);
                };
                i--;
            };
        }

        public function changeSceneClear():void{
            var i:PicLoaderList;
            var index:int;
            var tmp:Dictionary = new Dictionary();
            for each (i in this.caches) {
                if (i){
                    if ((((i.clearType == SourceClearType.CHANGE_SCENE)) || ((i.clearType == SourceClearType.CHANGESCENE_AND_TIME)))){
                        i.dispose();
                        index = this.clearList.indexOf(i);
                        if (index > -1){
                            this.clearList.splice(index, 1);
                        };
                    }
                    else {
                        tmp[i.path] = i;
                    };
                };
            };
            this.caches = tmp;
        }


    }
}//package dzhz.loader.newResource

