// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//dzhz.cache.FileItemEvent

package dzhz.cache{
    import flash.events.Event;
    import flash.utils.ByteArray;

    public class FileItemEvent extends Event {

        public static const SEND_COMPLETE:String = "sendComplete";
        public static const SEND_DATA:String = "sendData";
        public static const SET_COMPLETE:String = "setComplete";

        public var value:ByteArray;
        public var index:int;

        public function FileItemEvent(type:String, index:int, data:ByteArray, bubbles:Boolean=false, cancelable:Boolean=false){
            this.index = index;
            value = data;
            super(type, bubbles, cancelable);
        }

    }
}//package dzhz.cache

