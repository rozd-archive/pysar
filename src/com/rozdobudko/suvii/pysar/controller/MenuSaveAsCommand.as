package com.rozdobudko.suvii.pysar.controller
{
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.patterns.command.SimpleCommand;
	import org.puremvc.interfaces.INotification;

	public class MenuSaveAsCommand extends SimpleCommand implements ICommand
	{
		public function MenuSaveAsCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			trace("MenuSaveAsCommand :: execute");
		}
		
	}
}