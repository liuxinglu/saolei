// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//dzhz.loader.WebserviceLoader

package bajie.utils.loader{
    import flash.net.URLVariables;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import flash.utils.ByteArray;

    public class WebserviceLoader extends BytesLoader {

        private var _data:URLVariables;
        private var _isCompress:Boolean;

        public function WebserviceLoader(path:String, param:Object=null, callBack:Function=null, isCompress:Boolean=false, tryTime:int=1){
            var s:String;
            this._isCompress = isCompress;
            super(path, callBack, tryTime);
            this._data = new URLVariables();
            if (param != null){
                for (s in param) {
                    this._data[s] = param[s];
                };
            };
            setDataFormat(URLLoaderDataFormat.BINARY);
        }

        override public function load(request:URLRequest):void{
            this._data["rnd"] = int((Math.random() * 1000));
            request.data = this._data;
            super.load(request);
        }

        override public function loadSync(context:LoaderContext=null):void{
            if (!(_isStart)){
                this.load(new URLRequest(_url));
            };
        }

        override protected function onCompleted():void{
            var t:ByteArray;
            try {
                if (this._isCompress){
                    t = (data as ByteArray);
                    t.uncompress();
                };
                super.onCompleted();
            }
            catch(e:Error) {
            };
        }


    }
}//package dzhz.loader

