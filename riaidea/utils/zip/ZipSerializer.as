// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//riaidea.utils.zip.ZipSerializer

package riaidea.utils.zip{
    import flash.utils.ByteArray;
    import riaidea.utils.zip.ZipFile;
    import flash.utils.Endian;
    import riaidea.utils.zip.ZipArchive;

    public class ZipSerializer {

        private namespace header = "riaidea.utils.zip:ZipSerializer/private:header";
        private namespace zipfile = "riaidea.utils.zip:ZipSerializer/private:zipfile";
        private namespace zipend = "riaidea.utils.zip:ZipSerializer/private:zipend";

        private var stream:ByteArray;


        public function serialize(zip:ZipArchive, method:uint=8):ByteArray{
            var offset:uint;
            var file:ZipFile;
            var data:ByteArray;
            if (!(zip.length)){
                return (null);
            };
            this.stream = new ByteArray();
            var centralData:ByteArray = new ByteArray();
            this.stream.endian = (centralData.endian = Endian.LITTLE_ENDIAN);
            var i:uint;
            var filenum:uint = zip.length;
            while (i < filenum) {
                file = (zip.getFileAt(i) as ZipFile);
                data = this.zipfile::serialize(file, method);
                this.header::serialize(this.stream, file, true);
                this.stream.writeBytes(data);
                this.header::serialize(centralData, file, false, offset);
                offset = this.stream.position;
                i++;
            };
            this.stream.writeBytes(centralData);
            this.zipend::serialize(offset, (this.stream.length - offset), filenum);
            return (this.stream);
        }

        header function serialize(stream:ByteArray, file:ZipFile, local:Boolean=true, offset:uint=0):void{
            if (local){
                stream.writeUnsignedInt(ZipTag.LOCSIG);
            }
            else {
                stream.writeUnsignedInt(ZipTag.CENSIG);
                stream.writeShort(file._version);
            };
            stream.writeShort(file._version);
            stream.writeShort(file._flag);
            stream.writeShort(file._compressionMethod);
            stream.writeUnsignedInt(file._dostime);
            stream.writeUnsignedInt(file._crc32);
            stream.writeUnsignedInt(file._compressedSize);
            stream.writeUnsignedInt(file._size);
            var ba:ByteArray = new ByteArray();
            if (file._encoding == "utf-8"){
                ba.writeUTFBytes(file._name);
            }
            else {
                ba.writeMultiByte(file._name, file._encoding);
            };
            file._nameLength = ba.position;
            stream.writeShort(file._nameLength);
            stream.writeShort(((file._extra) ? file._extra.length : 0));
            if (!(local)){
                stream.writeShort(((file._comment) ? file._comment.length : 0));
                stream.writeShort(0);
                stream.writeShort(0);
                stream.writeUnsignedInt(0);
                stream.writeUnsignedInt(offset);
            };
            stream.writeBytes(ba);
            if (file._extra){
                stream.writeBytes(file._extra);
            };
            if (((!(local)) && (file._comment))){
                stream.writeUTFBytes(file._comment);
            };
        }

        zipfile function serialize(file:ZipFile, compressionMethod:uint=8):ByteArray{
            var tmpdata:ByteArray;
            var file:ZipFile = file;
            file._compressionMethod = compressionMethod;
            file._flag = 0;
            var data:ByteArray = new ByteArray();
            data.writeBytes(file.data);
            if (compressionMethod == ZipTag.DEFLATED){
                try {
                    data.compress();
                }
                catch(e:Error) {
                };
                file._compressedSize = (data.length - 6);
                tmpdata = new ByteArray();
                tmpdata.writeBytes(data, 2, (data.length - 6));
                return (tmpdata);
            };
            if (compressionMethod == ZipTag.STORED){
                file._compressedSize = data.length;
            };
            return (data);
        }

        zipend function serialize(offset:uint, length:uint, filenum:uint):void{
            this.stream.writeUnsignedInt(ZipTag.ENDSIG);
            this.stream.writeShort(0);
            this.stream.writeShort(0);
            this.stream.writeShort(filenum);
            this.stream.writeShort(filenum);
            this.stream.writeUnsignedInt(length);
            this.stream.writeUnsignedInt(offset);
            this.stream.writeShort(0);
        }


    }
}//package riaidea.utils.zip

