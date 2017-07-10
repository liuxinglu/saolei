﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//riaidea.utils.zip.ZipInflater

package riaidea.utils.zip{
    import flash.utils.ByteArray;
    import flash.utils.Endian;
    import riaidea.utils.zip.*;

    public class ZipInflater {

        private static const MAXBITS:int = 15;
        private static const MAXLCODES:int = 286;
        private static const MAXDCODES:int = 30;
        private static const MAXCODES:int = (MAXLCODES + MAXDCODES);//316
        private static const FIXLCODES:int = 288;
        private static const LENS:Array = [3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258];
        private static const LEXT:Array = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0];
        private static const DISTS:Array = [1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 0x0101, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577];
        private static const DEXT:Array = [0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13];

        private var inbuf:ByteArray;
        private var incnt:uint;
        private var bitbuf:int;
        private var bitcnt:int;
        private var lencode:Object;
        private var distcode:Object;


		public function setInput(buf:ByteArray):void{
            this.inbuf = buf;
            this.inbuf.endian = Endian.LITTLE_ENDIAN;
        }

        public function inflate(buf:ByteArray):uint{
            var last:int;
            var type:int;
            this.incnt = (this.bitbuf = (this.bitcnt = 0));
            var err:int;
            do  {
                last = this.bits(1);
                type = this.bits(2);
                if (type == 0){
                    this.stored(buf);
                }
                else {
                    if (type == 3){
                        throw (new Error("invalid block type (type == 3)", -1));
                    };
                    this.lencode = {
                        count:[],
                        symbol:[]
                    };
                    this.distcode = {
                        count:[],
                        symbol:[]
                    };
                    if (type == 1){
                        this.constructFixedTables();
                    }
                    else {
                        if (type == 2){
                            err = this.constructDynamicTables();
                        };
                    };
                    if (err != 0){
                        return (err);
                    };
                    err = this.codes(buf);
                };
                if (err != 0) break;
            } while (!(last));
            return (err);
        }

        private function bits(need:int):int{
            var val:int = this.bitbuf;
            while (this.bitcnt < need) {
                if (this.incnt == this.inbuf.length){
                    throw (new Error("available inflate data did not terminate", 2));
                };
                val = (val | (this.inbuf[this.incnt++] << this.bitcnt));
                this.bitcnt = (this.bitcnt + 8);
            };
            this.bitbuf = (val >> need);
            this.bitcnt = (this.bitcnt - need);
            return ((val & ((1 << need) - 1)));
        }

        private function construct(h:Object, length:Array, n:int):int{
            var offs:Array = [];
            var len:int;
            while (len <= MAXBITS) {
                h.count[len] = 0;
                len++;
            };
            var symbol:int;
            while (symbol < n) {
                var _local8:* = h.count;
                var _local9:* = length[symbol];
                var _local10:* = (_local8[_local9] + 1);
                _local8[_local9] = _local10;
                symbol++;
            };
            if (h.count[0] == n){
                return (0);
            };
            var left:int = 1;
            len = 1;
            while (len <= MAXBITS) {
                left = (left << 1);
                left = (left - h.count[len]);
                if (left < 0){
                    return (left);
                };
                len++;
            };
            offs[1] = 0;
            len = 1;
            while (len < MAXBITS) {
                offs[(len + 1)] = (offs[len] + h.count[len]);
                len++;
            };
            symbol = 0;
            while (symbol < n) {
                if (length[symbol] != 0){
                    _local9 = offs;
                    _local10 = length[symbol];
                    var _local11:* = (_local9[_local10] + 1);
                    _local9[_local10] = _local11;
                    _local8 = _local9[_local10];
                    h.symbol[_local8] = symbol;
                };
                symbol++;
            };
            return (left);
        }

        private function decode(h:Object):int{
            var count:int;
            var code:int;
            var first:int;
            var index:int;
            var len:int = 1;
            while (len <= MAXBITS) {
                code = (code | this.bits(1));
                count = h.count[len];
                if (code < (first + count)){
                    return (h.symbol[(index + (code - first))]);
                };
                index = (index + count);
                first = (first + count);
                first = (first << 1);
                code = (code << 1);
                len++;
            };
            return (-9);
        }

        private function codes(buf:ByteArray):int{
            var symbol:int;
            var len:int;
            var dist:uint;
            do  {
                symbol = this.decode(this.lencode);
                if (symbol < 0){
                    return (symbol);
                };
                if (symbol < 0x0100){
                    buf[buf.length] = symbol;
                }
                else {
                    if (symbol > 0x0100){
                        symbol = (symbol - 0x0101);
                        if (symbol >= 29){
                            throw (new Error("invalid literal/length or distance code in fixed or dynamic block", -9));
                        };
                        len = (LENS[symbol] + this.bits(LEXT[symbol]));
                        symbol = this.decode(this.distcode);
                        if (symbol < 0){
                            return (symbol);
                        };
                        dist = (DISTS[symbol] + this.bits(DEXT[symbol]));
                        if (dist > buf.length){
                            throw (new Error("distance is too far back in fixed or dynamic block", -10));
                        };
                        while (len--) {
                            buf[buf.length] = buf[(buf.length - dist)];
                        };
                    };
                };
            } while (symbol != 0x0100);
            return (0);
        }

        private function stored(buf:ByteArray):void{
            this.bitbuf = 0;
            this.bitcnt = 0;
            if ((this.incnt + 4) > this.inbuf.length){
                throw (new Error("available inflate data did not terminate", 2));
            };
            var len:uint = this.inbuf[this.incnt++];
            var _temp1:* = len;
            len = (_temp1 | (this.inbuf[this.bitbuf++] << 8));
            if (((!((this.inbuf[this.incnt++] == (~(len) & 0xFF)))) || (!((this.inbuf[this.incnt++] == ((~(len) >> 8) & 0xFF)))))){
                throw (new Error("stored block length did not match one's complement", -2));
            };
            if ((this.incnt + len) > this.inbuf.length){
                throw (new Error("available inflate data did not terminate", 2));
            };
            while (len--) {
                buf[buf.length] = this.inbuf[this.incnt++];
            };
        }

        private function constructFixedTables():void{
            var lengths:Array = [];
            var symbol:int;
            while (symbol < 144) {
                lengths[symbol] = 8;
                symbol++;
            };
            while (symbol < 0x0100) {
                lengths[symbol] = 9;
                symbol++;
            };
            while (symbol < 280) {
                lengths[symbol] = 7;
                symbol++;
            };
            while (symbol < FIXLCODES) {
                lengths[symbol] = 8;
                symbol++;
            };
            this.construct(this.lencode, lengths, FIXLCODES);
            symbol = 0;
            while (symbol < MAXDCODES) {
                lengths[symbol] = 5;
                symbol++;
            };
            this.construct(this.distcode, lengths, MAXDCODES);
        }

        private function constructDynamicTables():int{
            var symbol:int;
            var len:int;
            var lengths:Array = [];
            var order:Array = [16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15];
            var nlen:int = (this.bits(5) + 0x0101);
            var ndist:int = (this.bits(5) + 1);
            var ncode:int = (this.bits(4) + 4);
            if ((((nlen > MAXLCODES)) || ((ndist > MAXDCODES)))){
                throw (new Error("dynamic block code description: too many length or distance codes", -3));
            };
            var index:int;
            while (index < ncode) {
                lengths[order[index]] = this.bits(3);
                index++;
            };
            while (index < 19) {
                lengths[order[index]] = 0;
                index++;
            };
            var err:int = this.construct(this.lencode, lengths, 19);
            if (err != 0){
                throw (new Error("dynamic block code description: code lengths codes incomplete", -4));
            };
            index = 0;
            while (index < (nlen + ndist)) {
                symbol = this.decode(this.lencode);
                if (symbol < 16){
                    var _local10:* = index++;
                    lengths[_local10] = symbol;
                }
                else {
                    len = 0;
                    if (symbol == 16){
                        if (index == 0){
                            throw (new Error("dynamic block code description: repeat lengths with no first length", -5));
                        };
                        len = lengths[(index - 1)];
                        symbol = (3 + this.bits(2));
                    }
                    else {
                        if (symbol == 17){
                            symbol = (3 + this.bits(3));
                        }
                        else {
                            symbol = (11 + this.bits(7));
                        };
                    };
                    if ((index + symbol) > (nlen + ndist)){
                        throw (new Error("dynamic block code description: repeat more than specified lengths", -6));
                    };
                    while (symbol--) {
                        _local10 = index++;
                        lengths[_local10] = len;
                    };
                };
            };
            err = this.construct(this.lencode, lengths, nlen);
            if ((((err < 0)) || ((((err > 0)) && (!(((nlen - this.lencode.count[0]) == 1))))))){
                throw (new Error("dynamic block code description: invalid literal/length code lengths", -7));
            };
            err = this.construct(this.distcode, lengths.slice(nlen), ndist);
            if ((((err < 0)) || ((((err > 0)) && (!(((ndist - this.distcode.count[0]) == 1))))))){
                throw (new Error("dynamic block code description: invalid distance code lengths", -8));
            };
            return (err);
        }


    }
}//package riaidea.utils.zip

