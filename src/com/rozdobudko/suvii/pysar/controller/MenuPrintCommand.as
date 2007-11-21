package com.rozdobudko.suvii.pysar.controller
{
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.patterns.command.SimpleCommand;
	import org.puremvc.interfaces.INotification;

	public class MenuPrintCommand extends SimpleCommand implements ICommand
	{
		public function MenuPrintCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			trace("MenuPrintCommand :: execute");
		}
		
	}
}