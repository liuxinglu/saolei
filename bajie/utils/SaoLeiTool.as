package bajie.utils
{
	import bajie.constData.CommonConfig;
	import bajie.core.data.GlobalAPI;

	public class SaoLeiTool
	{
		public function SaoLeiTool()
		{
			
		}
		
		/**
		 * 让元件跳转到指定帧数
		 * @param instance 需要控制的元件队列
		 * @param needShowSprite 需要显示的元件名
		 * @param index 需要跳转的帧数
		 * @param otherSpriteIndex 其他元件所在帧数
		 * @author 刘兴禄
		 */		
		public static function currentFrames(instance:Array, needShowSprite:Object, index:int, otherSpriteIndex:uint):void
		{
			var len:int = instance.length;
			for(var i:int = 0; i < len; i++)
			{
				instance[i].gotoAndStop(otherSpriteIndex);
			}
			needShowSprite.gotoAndStop(index);
		}
		
		/**
		 *当前时间流水戳 
		 * @return 
		 * 
		 */		
		public static function getCurrentTime():String
		{
			var date:Date = new Date();
			return date.fullYear.toString()+date.month.toString() + date.day.toString() + date.hours.toString() + date.minutes.toString() + date.seconds.toString();
		}
		
		/**
		 *将秒数转为—天—小时—秒格式
		 * @return *天*小时*分*秒
		 * 
		 */		
		public static function SecondTurnToTimeString(i:int):String
		{
			
			var day:int = i/(3600 *24);
			var hour:int = (i - day*(3600*24))/3600;
			var minute:int = (i - day*(3600*24) - (hour*3600))/60;
			var second:int = i- day*(3600*24) - hour*3600 - minute*60;
			return day + "天" + hour + "小时" + minute + "分" + second + "秒";
		}
		
		/**
		 *获取地图名称 
		 * @param id 地图id
		 * @return 地图名
		 * 
		 */		
		public static function getMapName(id:int):String
		{
			for each(var xml:XML in GlobalAPI.configData.config.maps.map)
			{
				if(id == xml.@id)
				{
					return xml.@names;
				}
			}
			return "";
		}
		
		/**
		 *获取房间模式名 
		 * @param mode 模式id
		 * @param grade 难度id
		 * @return 房间模式名
		 * 
		 */		
		public static function getModeName(mode:int, grade:int):String
		{
			var s:String = "";
			switch(mode)
			{
				case CommonConfig.PROP_ROOM:
					 s = s.concat("道具房");
					break;
				case CommonConfig.NO_PROP_ROOM:
					s = s.concat("竞技房");
					break;
				case CommonConfig.CLASSIC_ROOM:
					s = s.concat("传统房");
					break;
			}
			switch(grade)
			{
				case CommonConfig.JUNIOR_LEVEL:
					s = s.concat("(初级)");
					break;
				case CommonConfig.NORMAL_LEVEL:
					s = s.concat("(中级)");
					break;
				case CommonConfig.HIGH_LEVEL:
					s = s.concat("(高级)");
					break;
			}
			return s;
		}
		
		/**
		 *根据后端数据得到需要切换的帧 
		 * @param s
		 * @return 帧<br/>
		 * 1,2,3,4,5,6,7,8,9,_  10,_  11,_   12,_   13<br/>
		 * 1,2,3,4,5,6,7,8,空,排,怀疑,排错,没排
		 */		
		public static function changeTurnFrame(s:String):int
		{
			var i:int = 1;
			switch(s)
			{
				case "a":
					i = 9;//空
					break;
				case "b":
					i = 1;
					break;
				case "c":
					i = 2
					break;
				case "d":
					i = 3;
					break;
				case "e":
					i = 4;
					break;
				case "f":
					i = 5;
					break;
				case "g":
					i = 6;
					break;
				case "h":
					i = 7;
					break;
				case "i":
					i = 8;
					break;
				case "j":
					i = 10;//插旗
					break;
				case "k":
					i = 13;//没排
					break;
				case "l":
					i = 12;//暴雷
					break;
			}
			return i;
		}

	}
}