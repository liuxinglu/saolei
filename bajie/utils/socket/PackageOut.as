package bajie.utils.socket
{
	import bajie.constData.*;
	import bajie.interfaces.socket.IPackageOut;
	import flash.utils.ByteArray;
	
	public class PackageOut extends ByteArray implements IPackageOut
    {
        private var _code:int;

        public function PackageOut(code:int)
        {
            _code = code;
			//writeShort(code);
            return;
        }// end function

        public function writeNumber(n:Number) : void
        {
            var _loc_2:* = new ByteArray();
            _loc_2.writeUnsignedInt(int(n / 4294967295));
            _loc_2.writeUnsignedInt(int(n));
            writeBytes(_loc_2);
            _loc_2 = null;
            return;
        }// end function
		
		override public function toString():String
		{
			this.position = 0;
			return this.readMultiByte(this.bytesAvailable, "utf-8");
		}

        public function writeString(str:String) : void
        {
            if (str == null)
            {
              //  writeShort(0);
                writeUTFBytes("");
            }
            else
            {
                this.writeMultiByte(str, "utf-8");
				//this.writeByte(0);
				//trace(str);
            }
            return;
        }// end function

        public function get code() : int
        {
            return _code;
        }// end function

        public function setPackageLen() : void
        {
            var byArr:ByteArray = new ByteArray();
            byArr.writeShort(length);		// - 2
            this[0] = byArr[0];
            this[1] = byArr[1];
            return;
        }// end function

        public function doCompress() : void
        {
			var _loc_1:ByteArray = null;
            _loc_1 = new ByteArray();
            var _loc_2:* = new ByteArray();
            readBytes(_loc_2, 0, length);
           // _loc_2.compress();
            length = 0;
            
            writeBytes(_loc_2);
            this[2] = 1;
            return;
        }// end function

        public function writeDate(date:Date) : void
        {
            writeInt(int(date.getTime() / 1000));
            return;
        }// end function

    }

}
