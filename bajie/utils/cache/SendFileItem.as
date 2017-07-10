// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//dzhz.cache.SendFileItem

package dzhz.cache{
    import flash.events.EventDispatcher;
    import flash.utils.Timer;
    import flash.utils.ByteArray;
    import flash.events.TimerEvent;

    public class SendFileItem extends EventDispatcher {

        private var _timer:Timer;
        private var _path:String;
        private var _value:ByteArray;
        private var _index:int;

        public function SendFileItem(path:String, value:ByteArray){
            _path = path;
            _value = value;
            _value.position = 0;
            _index = 0;
        }

        public function get size():int{
            return (_value.length);
        }

        public function start():void{
            _timer = new Timer(20);
            _timer.addEventListener(TimerEvent.TIMER, timerHandler);
            _timer.start();
        }

        private function timerHandler(evt:TimerEvent):void{
            var tmp:ByteArray;
            if (_value.bytesAvailable > 0){
                tmp = new ByteArray();
                _value.readBytes(tmp, 0, Math.min(_value.bytesAvailable, 35000));
                dispatchEvent(new FileItemEvent(FileItemEvent.SEND_DATA, _index, tmp));
                _index++;
            }
            else {
                complete();
            };
        }

        public function get path():String{
            return (_path);
        }

        public function complete():void{
            _timer.stop();
            dispatchEvent(new FileItemEvent(FileItemEvent.SEND_COMPLETE, 0, null));
        }

        public function dispose():void{
            if (_timer){
                _timer.removeEventListener(TimerEvent.TIMER, timerHandler);
                _timer.stop();
            };
            _timer = null;
            if (_value){
            };
            _value = null;
        }


    }
}//package dzhz.cache

