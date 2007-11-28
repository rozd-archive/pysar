package com.rozdobudko.suvii.pysar.controller
{
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.patterns.command.MacroCommand;

	public class FindIncludeCommnad extends MacroCommand implements ICommand
	{
		public function FindIncludeCommnad()
		{
			super();
		}
		
		override protected function initializeMacroCommand():void
		{
			this.addSubCommand(FindMaskCommand);
		}
	}
}