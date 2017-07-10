package bajie.core.data.dataFormat {
	
	/**
	 * 协议数据结构
	 * @author liuxinglu<br/>
	 * protocol 协议<br/>
	 * version   版本号<br/>
	 * number  流水号<br/>
	 * body      协议数据
	 */	
	public class JSONObject {

		private var _o:Object;
		
		public function JSONObject() {
			// constructor code
		}
		
		/**
		 *设置发送包 
		 * @param prototol 协议号
		 * @param version 版本号
		 * @param number 流水号
		 * @param o body体
		 * 
		 */		
		public function setObject(prototol:uint, version:String, number:String, o:Object):void
		{
			_o = new Object;
			_o = o;
			_o.protocol = prototol.toString();
			_o.version =  version;
			_o.number = number;
			
		}
		
		/**
		返回json格式字符串*/
		public function getString():String
		{
			return JSON.stringify(_o);
		}

	}
	
}
