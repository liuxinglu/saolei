package bajie.utils.socket
{
	import bajie.interfaces.socket.IPackageIn;
	import flash.utils.ByteArray;
	import bajie.constData.CommonConfig;
	import bajie.core.data.GlobalData;

	public class PackageIn extends ByteArray implements IPackageIn
    {
        private var _code:int;
        private var _packageLen:int;
        private var _autoDecode:Boolean;
		private var _o:Object;

        public function PackageIn(src:ByteArray, len:int, autoDecode:Boolean = true)
        {
            var _loc_5:int = 0;
            src.readBytes(this, 0, len); 
			//var sdata:String = JSON. (src.toString());
			//trace(this.toString());
			
			
			var s:String = this.readUTFBytes(this.bytesAvailable);
			_o = JSON.parse(s);
			//writeUTF(s);
            _packageLen = len;//readUnsignedShort() + 2;
			if(_o.code == undefined || _o.code == null || _o.code == 0)
			{
				_o.code = CommonConfig.SUCCESS;
			}
			//_o.body = o;
            _code = _o.protocol; 
			

            return;
        }// end function

        public function readNumber() : Number
        {
            readShort();
            var _loc_1:* = readShort();
            return (_loc_1 << 8) * 256 * 256 * 256 + readUnsignedInt();
        }// end function

        public function readString() : String
        {
            return readMultiByte(_packageLen, "utf-8");
        }// end function
		
		public function readObj():Object
		{
			//var o:Object = JSON.parse(_o.body.toString());
			//_o.body = o;
			return _o;
		}

        public function readId() : String
        {
            return readUTFBytes(32);
        }// end function

        public function readDate64() : Date
        {
            return new Date(readNumber());
        }// end function

        public function readDate() : Date
        {
            return new Date(Number(readInt()) * 1000);
        }// end function

        public function get packageLen() : int
        {
            return _packageLen;
        }// end function

        public function get code() : int
        {
            return _code;
        }// end function

        public function doUncompress() : void
        {
            var _loc_1:ByteArray = null;
            _loc_1 = new ByteArray();
            readBytes(_loc_1, 0, _packageLen);
            _loc_1.uncompress();
            writeBytes(_loc_1, 0, _loc_1.length);
            _packageLen = _loc_1.length;
            return;
        }// end function

    }

}