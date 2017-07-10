package bajie.manager.language
{
	import flash.utils.Dictionary;
	
	public class LanguageManager
	{
		private static var _words:Dictionary = new Dictionary();
		
		public static function setup(data:String):void
		{
			var t:String = data;
			data = data.split("\\n").join("\n");
			var list:Array = data.split("\r\n");
			
			for(var i:int = 0; i < list.length; i++)
			{
				var s:String = list[i];
				if(s == "")
					continue;
				if(s.indexOf("//") == 0)
					continue;
				var n:int = s.indexOf(":");
				if(n != -1)
				{
					var name:String = s.substring(0, n);
					var value:String = s.substr(n + 1);
					_words[name] = value;
				}
			}
		}
		
		public static function getWord(id:String, ...args):String
		{
			var s:String = _words[id];
			if(s != null)
			{
				if(args.length > 0)
				{
					for(var i:int = 0; i < args.length; i++)
					{
						s = s.split("{" + (i + 1) + "}").join(args[i]);
					}
				}
				return s;
			}
			return "";
		}
		
		public static function getAlertTitle():String
		{
			return "提示";
		}
	}
}