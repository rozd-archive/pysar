package com.rozdobudko.suvii.pysar.controller
{
	import org.puremvc.patterns.command.MacroCommand;
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;

	public class SettingsChangeCommand extends MacroCommand implements ICommand
	{
		public function SettingsChangeCommand()
		{
			super();
		}
		
		override protected function initializeMacroCommand():void
		{
			this.addSubCommand(SettingsCloseCommand);
			this.addSubCommand(FilteringCommand);
		} 
		
	}
}