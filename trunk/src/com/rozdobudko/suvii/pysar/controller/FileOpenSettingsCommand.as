package com.rozdobudko.suvii.pysar.controller
{
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.patterns.command.SimpleCommand;
	import org.puremvc.interfaces.INotification;
	import flash.filesystem.File;

	public class FileOpenSettingsCommand extends SimpleCommand implements ICommand
	{
		public function FileOpenSettingsCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			
			
		}
		
	}
}