package bajie.core.data.socketHandler.login 
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.interfaces.tick.ITick;
	
	public class LoginHeartDanceSocketHandler extends BaseSocketHandler implements ITick
	{

		public function LoginHeartDanceSocketHandler(handlerData:Object = null) 
		{
			// constructor code
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return 1;
		}
		
		override public function handlePackage():void
		{
			handComplete();
		}
		
		public static function startToDance():void
		{
			GlobalAPI.tickManager.addTick(new LoginHeartDanceSocketHandler);
		}
		
		public static function dance():void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(1);
			GlobalAPI.socketManager.send(pkg);
		}
		
		private var _time:Number = 0;
		public function update(times:int, dt:Number = 0.04):void
		{
			if(_time > 60)
			{
				LoginHeartDanceSocketHandler.dance();
				_time = 0;
			}
			else
			{
				_time += dt;
			}
		}

	}
	
}
