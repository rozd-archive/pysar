package com.rozdobudko.suvii.pysar.controller
{
	import mx.controls.Alert;
	
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;

	public class ShowAlertCommand extends SimpleCommand implements ICommand
	{
		public function ShowAlertCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			trace("ShowAlertCommand :: execute");
			
			Alert.show(notification.getBody().toString(), "Info");
		}
		
	}
}