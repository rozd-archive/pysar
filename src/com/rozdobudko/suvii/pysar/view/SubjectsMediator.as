package com.rozdobudko.suvii.pysar.view
{
	import org.puremvc.patterns.mediator.Mediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.interfaces.IMediator;

	public class SubjectsMediator extends Mediator implements IMediator
	{
		public function SubjectsMediator(viewComponent:Object=null)
		{
			super(viewComponent);
		}
		
		public function getMediatorName():String
		{
			return null;
		}
		
		public function getViewComponent():Object
		{
			return null;
		}
		
		public function listNotificationInterests():Array
		{
			return null;
		}
		
		public function handleNotification(notification:INotification):void
		{
		}
		
	}
}