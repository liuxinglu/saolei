// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//dzhz.cache.GetFileItem

package dzhz.cache{
    import flash.events.EventDispatcher;
    import flash.utils.ByteArray;

    public class GetFileItem extends EventDispatcher {

        private var _values:Array;
        public var path:String;
        public var size:int;
        private var _currentBytes:int;
        public var completeCallBack:Function;

        public function GetFileItem(path:String, completeCallBack:Function){
            this.path = path;
            this.completeCallBack = completeCallBack;
        }

        public function setSize(size:int):void{
            this.size = size;
            var len:int = Math.ceil((size / 35000));
            _values = new Array(len);
        }

        public function get file():ByteArray{
            var value:ByteArray;
            var bytes:ByteArray = new ByteArray();
            for each (value in _values) {
                if (value){
                    bytes.writeBytes(value, 0, value.length);
                };
            };
            return (bytes);
        }

        public function setFile(index:int, value:ByteArray):void{
            _values[index] = value;
            _currentBytes = (_currentBytes + value.length);
            if (_currentBytes >= size){
                dispatchEvent(new FileItemEvent(FileItemEvent.SET_COMPLETE, 0, null));
            };
        }

        public function dispose():void{
            _values = null;
            completeCallBack = null;
        }


    }
}//package dzhz.cache

