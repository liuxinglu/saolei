// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//dzhz.loader.newResource.PacckageFileData

package bajie.utils.loader.newResource{
    import flash.display.BitmapData;
    import bajie.interfaces.loader.*;

    public class PacckageFileData implements IPackageFileData {

        private var _data:BitmapData;
        private var _x:Number;
        private var _y:Number;

        public function PacckageFileData(bd:BitmapData, x:Number, y:Number){
            this._data = bd;
            this._x = x;
            this._y = y;
        }

        public function getBD():BitmapData{
            return (this._data);
        }

        public function getX():Number{
            return (this._x);
        }

        public function getY():Number{
            return (this._y);
        }

        public function dispose():void{
            if (this._data){
                this._data.dispose();
            };
            this._data = null;
        }


    }
}//package dzhz.loader.newResource

