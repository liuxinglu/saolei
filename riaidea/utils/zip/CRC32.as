// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//riaidea.utils.zip.CRC32

package riaidea.utils.zip{
    import flash.utils.ByteArray;

    public class CRC32 {

        private static var crcTable:Array = makeCrcTable();


        private static function makeCrcTable():Array{
            var c:uint;
            var k:int;
            var crcTable:Array = [];
            var n:int;
            while (n < 0x0100) {
                c = n;
                k = 8;
                while (--k >= 0) {
                    if ((c & 1) != 0){
                        c = (3988292384 ^ (c >>> 1));
                    }
                    else {
                        c = (c >>> 1);
                    };
                };
                crcTable[n] = c;
                n++;
            };
            return (crcTable);
        }


        public function getCRC32(data:ByteArray, start:uint=0, len:uint=0):uint{
            var i:uint;
            if (start >= data.length){
                start = data.length;
            };
            if (len == 0){
                len = (data.length - start);
            };
            if ((len + start) > data.length){
                len = (data.length - start);
            };
            var c:uint = 0xFFFFFFFF;
            i = start;
            while (i < len) {
                c = (uint(crcTable[((c ^ data[i]) & 0xFF)]) ^ (c >>> 8));
                i++;
            };
            return ((c ^ 0xFFFFFFFF));
        }


    }
}//package riaidea.utils.zip

