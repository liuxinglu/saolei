package bajie.core.data.email 
{
	import bajie.core.data.socketHandler.email.*;
	import bajie.core.data.GlobalData;
	import bajie.events.ParamEvent;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author azjune
	 */
	public class EmailInfo extends EventDispatcher
	{
		
		public function EmailInfo() 
		{
			
		}
		/*
		 *获取邮件列表
		 */
		public function getEmailList(index:int,type:int):void {
			GetEmailListSocketHandler.send(GlobalData.playerid,index,type);
		}
		/*
		 *显示邮件列表
		 */
		public function showEmailList(o:Object):void {
			this.dispatchEvent(new ParamEvent(ParamEvent.GET_MAIL_LIST, o));
		}
		/**
		 * 发送邮件道具获取信息
		 * @param	index  邮箱页数
		 * @param	bigidx  邮件列表编号
		 */
		public function sendMailProps(index:int,bigidx:int):void {
			MailReceivePropsSocketHandler.send(GlobalData.playerid, index, bigidx);
		}
		/**
		 * 发送邮件装备获取信息
		 * @param	index 邮箱页数
		 * @param	bigidx  邮件列表编号
		 */
		public function getEquipEmailDetails(index:int,bigidx:int):void {
			GetEquipEmailDetailsSocketHandler.send(GlobalData.playerid,index, bigidx);
		}
		/*
		 * 发送邮件装备获取信息
		 */
		public function showEmailDetails(o:Object):void {
			this.dispatchEvent(new ParamEvent(ParamEvent.SHOW_EMAIL_DETAILS, o));
		}
		public function removeEmail(index:int,bigidx:int):void {
			RemoveEmailSocketHandler.send(GlobalData.playerid,index, bigidx);
		}
		/*
		 * 发送邮件装备获取信息
		 */
		public function sendMailWeapons():void {
			
		}
		/*
		 * 发送邮件时装获取信息
		 */
		public function sendMailDress():void {
			
		}
		public var itemSp:Array = [];
	}

}