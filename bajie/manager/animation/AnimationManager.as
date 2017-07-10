package bajie.manager.animation
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;

	import flash.display.DisplayObject;

	public class AnimationManager {

		import com.greensock.plugins.*;
		import com.greensock.easing.*;
		import flash.geom.Point;

		TweenPlugin.activate([TransformAroundCenterPlugin, TransformAroundPointPlugin, ShortRotationPlugin, GlowFilterPlugin]);


		public function AnimationManager() {

		}
		
		

		public static function playFadeIn(target:*, time:int = 0.3):void {
			target.scaleX = target.scaleY = 1.8;

			TweenLite.to(target, time, {transformAroundCenter: {scaleX: 1, scaleY: 1}, ease: Back.easeOut});
		}

		public static function playFlashGlow(target:*, time:int = 1, c:int = 0xffffff, a:int = 1, bx:int = 10, by:int = 10):void {
			TweenMax.to(target, time * 0.5, {glowFilter: {color: c, alpha: a, blurX: bx, blurY: by}});

			TweenLite.delayedCall(0.5, tbak);

			function tbak():void {
				TweenMax.to(target, time * 0.5, {glowFilter: {color: c, alpha: a, blurX: 0, blurY: 0, remove: true}});
			}
		}

		public static function transfromAroundCenter(mc:DisplayObject, onPlayEnd:Function = null):void {
			TweenLite.to(mc, 0, {transformAroundCenter: {scaleX: 0.3, scaleY: 0.3}});
			TweenLite.to(mc, 0.3, {transformAroundCenter: {scaleX: 1, scaleY: 1}, ease: Back.easeOut, onComplete: onPlayEnd});
		}


	}
}