// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//riaidea.utils.zip.ZipFile

package riaidea.utils.zip{
    import flash.utils.ByteArray;
    import bajie.interfaces.loader.IZipFile;

    public class ZipFile implements IZipFile {

        public var _name:String;
		public var _data:ByteArray;
		public var _version:uint;
		public var _encrypted:Boolean = false;
		public var _compressionMethod:int = -1;
		public var _dostime:uint;
		public var _crc32:uint;
		public var _compressedSize:uint;
		public var _size:uint;
		public var _flag:uint;
		public var _extra:ByteArray;
		public var _comment:String;
		public var _encoding:String = "";
		public var _nameLength:uint;
		public var _extraLength:uint;

        public function ZipFile(name:String=null){
            if (name){
                this._name = name;
            };
            this._data = new ByteArray();
        }

        public function get name():String{
            return (this._name);
        }

        public function get version():uint{
            return (this._version);
        }

        public function get size():uint{
            return (this._size);
        }

        public function get compressionMethod():int{
            return (this._compressionMethod);
        }

        public function get crc32():uint{
            return (this._crc32);
        }

        public function get compressedSize():uint{
            return (this._compressedSize);
        }

		public function get encrypted():Boolean{
            return (this._encrypted);
        }

		public function get flag():uint{
            return (this._flag);
        }

		public function get extra():ByteArray{
            return (((this._extra) ? this._extra : null));
        }

		public function get comment():String{
            return (((this._comment) ? this._comment : null));
        }

        public function get data():ByteArray{
            return (this._data);
        }

        public function set data(ba:ByteArray):void{
            this._data = ba;
        }

        public function get date():Date{
            var sec:int = ((this._dostime & 31) << 1);
            var min:int = ((this._dostime >> 5) & 63);
            var hour:int = ((this._dostime >> 11) & 31);
            var day:int = ((this._dostime >> 16) & 31);
            var month:int = (((this._dostime >> 21) & 15) - 1);
            var year:int = (((this._dostime >> 25) & 127) + 1980);
            return (new Date(year, month, day, hour, min, sec));
        }

        public function set date(date:Date):void{
            this._dostime = ((((((((date.fullYear - 1980) & 127) << 25) | ((date.month + 1) << 21)) | (date.date << 16)) | (date.hours << 11)) | (date.minutes << 5)) | (date.seconds >> 1));
        }

        public function toString():String{
            var str:String = '[ZipFile Path="';
            str = (str + ((((((this._name + '"]\rsize:') + this._size) + " compressedSize:") + this.compressedSize) + " CRC32:") + this.crc32.toString(16).toLocaleUpperCase()));
            str = (str + (("\rLast modify time:" + this.date) + "\r"));
            return (str);
        }


    }
}//package riaidea.utils.zip

