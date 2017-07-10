package bajie.utils
{
	import bajie.Test;
	import bajie.manager.drag.GlobalDragManager;
	import bajie.ui.bag.BagItem;
	import bajie.ui.strengthen.StrengthenItem;
	import bajie.ui.email.EmailItem;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import bajie.ui.fight.MineGrid;
	import fl.transitions.Fade;

	/**
	布雷工具类 通用
	*/
	public class LayMines
	{
		/**
		传入要布局的mc， 最大行数，最大列数, 是否可以拖拽, 横向间距， 纵向间距, 绘雷区专用
		*/
		public static function layMine(mc:String, scaleRow:int, scaleCol:int, canDrag:Boolean = false, marginX:int = 2, marginY:int = 1, gridSize:int = 0):Sprite
		{
			var sp:Sprite = new Sprite;
			var fa:Class = gridFactory(mc);
			var test:MovieClip;
			var index:int = 0;
			for (var i:int = 0; i < scaleRow; i++)
			{
				for (var j:int = 0; j < scaleCol; j++)
				{
					if(mc == "MineGrid")
					{
						test = new MineGrid(gridSize);
					}
					else
					{
						test = new fa as MovieClip;
					}
					
					test.name = j + "_" + i;
					test.index = index++;
					test.x = (test.width + marginX) * j;
					test.y = (test.height + marginY) * i;
					
					sp.addChild(test);
				}

			}
			return sp;
		}
		
		/**
		传入类名 得到对应格子类
		*/
		public static function gridFactory(na:String):Class
		{
			if(na == "Test")
			 return Test;
			else if(na == "BagItem")
			  return BagItem;
			else if(na == "StrengthenItem")
			  return StrengthenItem;
			 else if(na == "EmailItem")
			  return EmailItem;
			else if(na == "MineGrid")
			  return MineGrid;
			else 
			 return null;
		}
		
		/**
		*获取当前响应格子的周围九个格子</br>
		*gx:当前响应格子的逻辑坐标x</br>
		*gy:当前响应格子的逻辑坐标y</br>
		*gscaleX:横坐标最大逻辑坐标</br>
		*gscaleY:纵坐标最大逻辑坐标
		*/
		public static function getCurNineGrid(gx:int, gy:int, gscaleX:int, gscaleY:int):Array
		{
			var arr:Array = [];
			/*var i:int = -1;
			var j:int = -1;
			var s:String = "";*/
			if ((gx + 1 <= gscaleX) && (gy + 1 <= gscaleY) && 
			   (gx - 1 >= 0) && (gy - 1 >= 0))
			{//满足所有九宫
				arr = pushArr(gy, gx, -1, -1, 2, 2);
			}
			else if ((gx + 1 > gscaleX) && (gy + 1 > gscaleY) &&
			(gx - 1 >= 0) && (gy - 1 >= 0))
			{//返回左上角
				arr = pushArr(gy, gx, -1, -1, 1, 1);
			}
			else if ((gx + 1 > gscaleX) && (gy + 1 <= gscaleY) &&
			(gx - 1 >= 0) && (gy - 1 < 0))
			{//返回左下角
				arr = pushArr(gy, gx, 0, -1, 2, 1);
			}
			else if ((gx + 1 > gscaleX) && (gy + 1 <= gscaleY) &&
			(gx - 1 >= 0) && (gy - 1 >= 0))
			{//返回左边
				arr = pushArr(gy, gx, -1, -1, 2, 1);
			}
			else if ((gx + 1 <= gscaleX) && (gy + 1 > gscaleY) &&
			(gx - 1 < 0) && (gy -1 >= 0))
			{//返回右上角
				arr = pushArr(gy, gx, -1, 0, 1, 2);
			}
			else if ((gx + 1 <= gscaleX) && (gy + 1 <= gscaleY) &&
			(gx - 1 < 0) && (gy - 1 < 0))
			{//返回右下角
				arr = pushArr(gy, gx, 0, 0, 2, 2);
			}
			else if ((gx + 1 <= gscaleX) && (gy + 1 <= gscaleY) &&
			(gx - 1 < 0) && (gy - 1 >= 0))
			{//返回右边
				arr = pushArr(gy, gx, -1, 0, 2, 2);
			}
			else if ((gx + 1 <= gscaleX) && (gy + 1 > gscaleY) &&
			(gx - 1 >= 0) && (gy - 1 >= 0))
			{//返回上边
				arr = pushArr(gy, gx, -1, -1, 1, 2);
			}
			else if ((gx + 1 <= gscaleX) && (gy + 1 <= gscaleY) &&
			(gx - 1 >= 0) && (gy - 1 < 0))
			{//返回下边
				arr = pushArr(gy, gx, 0, -1, 2, 2);
			}
			return arr;
		}

		/**
		*九宫
		*oY:初始化x发起位置
		*oX:初始化y发起位置
		*gY:开始计算的逻辑起始位置y
		*gX:开始计算的逻辑起始位置x
		*yL:终止计算的逻辑终止位置y
		*xL:终止计算的逻辑终止位置x
		*/
		private static function pushArr(oY:int, oX:int, gY:int, gX:int, yL:int, xL:int):Array
		{
			var arr:Array = [];
			var i:int = 0;
			var j:int = 0;
			var s:String = "";
			for (i = gY; i < yL; i++)
			{
				for (j = gX; j < xL; j++)
				{
					s = (oX + j) + "_" + (oY + i);
					arr.push(s);
				}
			}
			return arr;
		}
	}
}