// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//dzhz.cache.ConnectionClient

package dzhz.cache{
    import dzhz.interfaces.loader.*;
    
    import flash.events.StatusEvent;
    import flash.net.LocalConnection;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;

    public class ConnectionClient implements dzhz.cache.ICacheApi {

        private var _conn2:LocalConnection;
        private var _conn:LocalConnection;
        private var _setFiles:Dictionary;


        public function getCanCache():Boolean{
            return (true);
        }

        private function sendCompleteHandler(evt:FileItemEvent):void{
            var send:SendFileItem = (evt.currentTarget as SendFileItem);
            send.removeEventListener(FileItemEvent.SEND_DATA, sendDataHandler);
            send.removeEventListener(FileItemEvent.SEND_COMPLETE, sendCompleteHandler);
        }

        private function setCompleteHandler(evt:FileItemEvent):void{
            var item:GetFileItem = (evt.currentTarget as GetFileItem);
            setItemCompleteHandler(item);
        }

        public function saveCacheList():Boolean{
            return (true);
        }

        public function getFile(path:String, callBack:Function, backup:Boolean=true):void{
            var setFile:GetFileItem;
            if (_setFiles[path] == null){
                setFile = new GetFileItem(path, callBack);
                _setFiles[path] = setFile;
                setFile.addEventListener(FileItemEvent.SET_COMPLETE, setCompleteHandler);
            };
            _conn.send("mhsmServer", "getFile", path);
        }

        public function getFileCallBack(path:String, size:int, index:int, value:ByteArray):void{
            if (size == 0){
                setItemCompleteHandler(_setFiles[path]);
            }
            else {
                if (_setFiles[path]){
                    if (_setFiles[path].size == 0){
                        _setFiles[path].setSize(size);
                    };
                    _setFiles[path].setFile(index, value);
                };
            };
        }

        private function statusHandler(evt:StatusEvent):void{
            switch (evt.level){
                case "status":
                    break;
                case "error":
                    break;
            };
        }

        public function setCanCache(value:Boolean):void{
        }

        private function setItemCompleteHandler(item:GetFileItem):void{
            if (item == null){
                return;
            };
            var values:ByteArray = item.file;
            if (values){
                values.position = 0;
            };
            item.removeEventListener(FileItemEvent.SET_COMPLETE, setCompleteHandler);
            if (item.completeCallBack != null){
                item.completeCallBack((((values.length == 0)) ? null : values));
            };
            delete _setFiles[item.path];
            item.dispose();
        }

        public function setup(updateList:String, sitePath:String):void{
            var updateList:String = updateList;
            var sitePath:String = sitePath;
            _setFiles = new Dictionary();
            _conn = new LocalConnection();
            _conn.addEventListener(StatusEvent.STATUS, statusHandler);
            _conn2 = new LocalConnection();
            _conn2.client = this;
            try {
                _conn2.connect("mhsmClient");
            }
            catch(e:Error) {
                trace("mhsmClient connect failed");
            };
            _conn.send("mhsmServer", "setup", updateList, sitePath);
        }

        public function setFile(path:String, data:ByteArray, backup:Boolean=true):void{
            var send:SendFileItem = new SendFileItem(path, data);
            send.addEventListener(FileItemEvent.SEND_DATA, sendDataHandler);
            send.addEventListener(FileItemEvent.SEND_COMPLETE, sendCompleteHandler);
            send.start();
        }

        private function sendDataHandler(evt:FileItemEvent):void{
            var send:SendFileItem = (evt.currentTarget as SendFileItem);
            _conn.send("mhsmServer", "setFile", send.path, send.size, evt.index, evt.value);
        }


    }
}//package dzhz.cache

