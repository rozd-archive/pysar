package com.rozdobudko.suvii.pysar.controller.filesystem
{
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.patterns.command.SimpleCommand;
	import org.puremvc.interfaces.INotification;

	public class PreferencesFileOpenCommand extends SimpleCommand implements ICommand
	{
		public function PreferencesFileOpenCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
		}
		
	}
}