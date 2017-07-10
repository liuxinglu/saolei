// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//dzhz.loader.resource.BaseDataFileInfo

package bajie.utils.loader.resource{
    import flash.utils.ByteArray;
    import bajie.interfaces.loader.*;

    public class BaseDataFileInfo implements IDataFileInfo {

        private var _path:String;
        private var _source:ByteArray;

        public function BaseDataFileInfo(path:String, data:ByteArray){
            this._path = path;
            this._source = data;
        }

        public function get path():String{
            return (this._path);
        }

        public function get rects():Array{
            return (null);
        }

        public function set rects(value:Array):void{
        }

        public function get datas():Array{
            return (null);
        }

        public function set datas(value:Array):void{
        }

        public function getSourceData():ByteArray{
            return (this._source);
        }

        public function dispose():void{
            if (this._source){
                this._source.length = 0;
                this._source = null;
            };
        }


    }
}//package dzhz.loader.resource

