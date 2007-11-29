package com.rozdobudko.suvii.pysar.controller
{
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.patterns.command.MacroCommand;

	public class FindExcludeCommand extends MacroCommand implements ICommand
	{
		public function FindExcludeCommand()
		{
			super();
		}
		
		override protected function initializeMacroCommand():void
		{
			this.addSubCommand(FilteringCommand);
		}
		
	}
}