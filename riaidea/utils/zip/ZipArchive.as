// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//riaidea.utils.zip.ZipArchive

package riaidea.utils.zip{
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;
    import flash.utils.ByteArray;
    import bajie.interfaces.loader.IZipFile;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.display.LoaderInfo;
    import bajie.interfaces.loader.IZipArchive;
    import bajie.interfaces.loader.IZipFile;

    public class ZipArchive extends EventDispatcher implements IZipArchive {

        private var _name:String;
		public var _list:Array;
		public var _entry:Dictionary;
        private var _decode:int;

        public function ZipArchive(name:String=null, decode:int=0){
            this._list = [];
            this._entry = new Dictionary(true);
            if (name){
                this._name = name;
            };
            this._decode = decode;
        }

        public function load(request:String):void{
            var parser:ZipParser;
            var request:String = request;
            try {
                if (!(this._name)){
                    this._name = request;
                };
                parser = new ZipParser(this._decode);
                parser.addEventListener(ZipEvent.ZIP_PARSE_COMPLETED, this.parseCompleted);
                parser.writeZipFromFile(this, request);
            }
            catch(e:Error) {
            };
        }

        public function open(data:ByteArray):Boolean{
            var parser:ZipParser;
            var data:ByteArray = data;
            parser = new ZipParser();
            parser.writeZipFromStream(this, data);
            return (true);
        }

        public function addFile(file:ZipFile, index:int=-1):ZipFile{
            if (file){
                if ((((index < 0)) || ((index >= this._list.length)))){
                    this._list.push(file);
                }
                else {
                    this._list.splice(index, 0, file);
                };
                this._entry[this.name] = file;
                return (file);
            };
            return (null);
        }

        public function addFileFromBytes(name:String, data:ByteArray=null, index:int=-1):ZipFile{
            var name:String = name;
            var data:ByteArray = data;
            var index:int = index;
            if (this._entry[name]){
                throw (new Error((("file: " + name) + " already exists.")));
            };
            var file:ZipFile = new ZipFile(name);
            try {
                data.uncompress();
            }
            catch(e:Error) {
            };
            data.position = 0;
            file._data = data;
            file.date = new Date();
            file._size = data.length;
            file._version = 20;
            file._flag = 0;
            file._crc32 = new CRC32().getCRC32(data);
            if ((((index < 0)) || ((index >= this._list.length)))){
                this._list.push(file);
            }
            else {
                this._list.splice(index, 0, file);
            };
            this._entry[name] = file;
            return (file);
        }

        public function addFileFromString(name:String, content:String, index:int=-1):ZipFile{
            if (content == null){
                return (null);
            };
            var data:ByteArray = new ByteArray();
            data.writeUTFBytes(content);
            return (this.addFileFromBytes(name, data, index));
        }

        public function getFileByName(name:String):ZipFile{
            return (((this._entry[name]) ? this._entry[name] : null));
        }

        public function getFileAt(index:uint):IZipFile{
            return ((((this._list.length)>index) ? this._list[index] : null));
        }

        public function getBitmapByName(name:String):void{
            var file:ZipFile = this.getFileByName(name);
            if (!(file)){
                return;
            };
            file.data.position = 0;
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.getBitmapCompleted);
            loader.loadBytes(file.data);
        }

        public function removeFileByName(name:String):ZipFile{
            var i:uint;
            if (this._entry[name]){
                i = 0;
                while (i < this._list.length) {
                    if (name == this._list[i].name){
                        return (this.removeFileAt(i));
                    };
                    i++;
                };
            };
            return (null);
        }

        public function removeFileAt(index:uint):ZipFile{
            var file:ZipFile;
            if (index < this._list.length){
                file = this._list[index];
                if (file){
                    this._list.splice(index, 1);
                    delete this._entry[file.name];
                    return (file);
                };
            };
            return (null);
        }

        public function output(method:uint=8):ByteArray{
            var zs:ZipSerializer = new ZipSerializer();
            return ((zs.serialize(this, method) as ByteArray));
        }

        private function parseCompleted(evt:ZipEvent):void{
            var parser:ZipParser = (evt.currentTarget as ZipParser);
            parser.removeEventListener(ZipEvent.ZIP_PARSE_COMPLETED, this.parseCompleted);
            parser = null;
            if (this._list.length == 0){
                dispatchEvent(new ZipEvent(ZipEvent.ZIP_FAILED, "unsupported or unknow format"));
            }
            else {
                dispatchEvent(new ZipEvent(ZipEvent.ZIP_INIT));
            };
        }

        private function getBitmapCompleted(evt:Event):void{
            var info:LoaderInfo = (evt.currentTarget as LoaderInfo);
            info.removeEventListener(Event.COMPLETE, this.getBitmapCompleted);
            dispatchEvent(new ZipEvent(ZipEvent.ZIP_CONTENT_LOADED, info.content));
        }

        public function get name():String{
            return (this._name);
        }

        public function set name(name:String):void{
            this._name = name;
        }

        public function get length():uint{
            return (this._list.length);
        }

        override public function toString():String{
            var str:String = (('[ZipArchive Name="' + this.name) + '"]\r');
            var i:int;
            while (i < this.length) {
                str = (str + ((("Index:" + i) + " --> ") + this._list[i].toString()));
                i++;
            };
            return ((str + "\r"));
        }


    }
}//package riaidea.utils.zip

