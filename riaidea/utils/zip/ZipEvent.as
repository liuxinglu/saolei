// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//riaidea.utils.zip.ZipEvent

package riaidea.utils.zip{
    import flash.events.Event;

    public class ZipEvent extends Event {

        public static var ZIP_INIT:String = "zip_init";
        public static var ZIP_CONTENT_LOADED:String = "zip_content_loaded";
        public static var ZIP_FAILED:String = "zip_failed";
		public static var ZIP_PARSE_COMPLETED:String = "zip_parse_completed";
		public static var ZIP_PARSE_ERROR:String = "zip_parse_error";

        private var _content:Object;

        public function ZipEvent(type:String, content:Object=null, bubbles:Boolean=false, cancelable:Boolean=false){
            super(type, bubbles, cancelable);
            this._content = content;
        }

        public function get content():Object{
            return (this._content);
        }


    }
}//package riaidea.utils.zip

