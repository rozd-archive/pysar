package com.rozdobudko.suvii.pysar.controller
{
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.patterns.command.MacroCommand;
	
	public class DeployCommand extends MacroCommand implements ICommand
	{
		override protected function initializeMacroCommand():void
		{
			this.addSubCommand(RegisterMediartorsCommand);
			this.addSubCommand(FileOpenSettingsCommand);
		}
	}
}