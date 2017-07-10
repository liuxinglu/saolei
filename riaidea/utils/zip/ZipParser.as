// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//riaidea.utils.zip.ZipParser

package riaidea.utils.zip{
    import flash.events.EventDispatcher;
    import flash.utils.ByteArray;
    import riaidea.utils.zip.ZipArchive;
    import flash.utils.Endian;
    import flash.net.URLStream;
    import flash.net.URLRequest;
    import flash.events.ProgressEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import riaidea.utils.zip.ZipEvent;
    import riaidea.utils.zip.ZipFile;
    import riaidea.utils.zip.*;

    public class ZipParser extends EventDispatcher {

        private namespace localfile = "riaidea.utils.zip:ZipParser/private:localfile";

        private var data:ByteArray;
        private var zip:ZipArchive;
        private var _decode:int;

        public function ZipParser(decode:int=0){
            this._decode = decode;
        }

		public function writeZipFromFile(zip:ZipArchive, filename:String):void{
            if (!(zip)){
                return;
            };
            this.zip = zip;
            this.data = new ByteArray();
            this.data.endian = Endian.LITTLE_ENDIAN;
            this.load(filename);
        }

		public function writeZipFromStream(zip:ZipArchive, data:ByteArray):void{
            if (!(zip)){
                return;
            };
            this.zip = zip;
            this.data = data;
            data.position = 0;
            this.parse();
        }

        private function load(filename:String):void{
            var stream:URLStream = new URLStream();
            stream.load(new URLRequest(filename));
            stream.addEventListener(ProgressEvent.PROGRESS, this.fileloading);
            stream.addEventListener(Event.COMPLETE, this.fileLoaded);
            stream.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
        }

        private function onError(evt:IOErrorEvent):void{
            var stream:URLStream = (evt.currentTarget as URLStream);
            stream.removeEventListener(ProgressEvent.PROGRESS, this.fileloading);
            stream.removeEventListener(Event.COMPLETE, this.fileLoaded);
            stream.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
            this.zip.dispatchEvent(evt.clone());
        }

        private function fileloading(evt:ProgressEvent):void{
            this.zip.dispatchEvent(evt.clone());
        }

        private function fileLoaded(evt:Event):void{
            var stream:URLStream = (evt.currentTarget as URLStream);
            stream.removeEventListener(ProgressEvent.PROGRESS, this.fileloading);
            stream.removeEventListener(Event.COMPLETE, this.fileLoaded);
            stream.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
            var t:ByteArray = new ByteArray();
            stream.readBytes(t);
            t.position = 0;
            t.readBytes(this.data);
            this.parse();
        }

        private function parse():void{
            try {
                do  {
                } while (this.parseFile());
                dispatchEvent(new ZipEvent(ZipEvent.ZIP_PARSE_COMPLETED));
            }
            catch(e:Error) {
                zip.dispatchEvent(new ZipEvent(ZipEvent.ZIP_FAILED, e.message));
                trace(e);
            };
            this.data = null;
        }

        private function parseFile():Boolean{
            var _local2:ZipFile;
            var tag:uint = this.data.readUnsignedInt();
            switch (tag){
                case ZipTag.LOCSIG:
                    _local2 = new ZipFile();
                    this.localfile::parseHeader(_local2);
                    if (((_local2._nameLength) || (_local2._extraLength))){
                        this.localfile::parseExt(_local2);
                    };
                    this.localfile::parseContent(_local2);
                    this.zip._list.push(_local2);
                    if (_local2._name){
                        this.zip._entry[_local2._name] = _local2;
                    };
                    return (true);
                case ZipTag.ENDSIG:
                    return (true);
                case ZipTag.CENSIG:
                    return (true);
            };
            return (false);
        }

        localfile function parseContent(file:ZipFile):void{
            var _local3:ByteArray;
            var _local4:ZipInflater;
            if (!(file._compressedSize)){
                return;
            };
            var compressedData:ByteArray = new ByteArray();
            this.data.readBytes(compressedData, 0, file._compressedSize);
            switch (file._compressionMethod){
                case ZipTag.STORED:
                    file._data = compressedData;
                    break;
                case ZipTag.DEFLATED:
                    _local3 = new ByteArray();
                    _local4 = new ZipInflater();
                    _local4.setInput(compressedData);
                    _local4.inflate(_local3);
                    file._data = _local3;
                    break;
                default:
                    throw (new Error("invalid compression method"));
            };
        }

        localfile function parseExt(file:ZipFile):void{
            var id:uint;
            var size:uint;
            if (file._encoding == "utf-8"){
                file._name = this.data.readUTFBytes(file._nameLength);
            }
            else {
                file._name = this.data.readMultiByte(file._nameLength, file._encoding);
            };
            var len:uint = file._extraLength;
            if (len > 4){
                id = this.data.readUnsignedShort();
                size = this.data.readUnsignedShort();
                if (size > len){
                    throw (new Error("Parse Error: extra field data size too big"));
                };
                if (!(((id === 0xDADA)) && ((size === 4)))){
                    if (size > 0){
                        file._extra = new ByteArray();
                        this.data.readBytes(file._extra, 0, size);
                    };
                };
                len = (len - (size + 4));
            };
            if (len > 0){
                this.data.position = (this.data.position + len);
            };
        }

        localfile function parseHeader(file:ZipFile):void{
            file._version = this.data.readUnsignedShort();
            file._flag = this.data.readUnsignedShort();
            file._compressionMethod = this.data.readUnsignedShort();
            file._encrypted = !(((file._flag & 1) === 0));
            if ((file._flag & 800) !== 0){
                file._encoding = "utf-8";
            };
            file._dostime = this.data.readUnsignedInt();
            file._crc32 = this.data.readUnsignedInt();
            file._compressedSize = this.data.readUnsignedInt();
            file._size = this.data.readUnsignedInt();
            file._nameLength = this.data.readUnsignedShort();
            file._extraLength = this.data.readUnsignedShort();
        }


    }
}//package riaidea.utils.zip

