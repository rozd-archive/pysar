package com.rozdobudko.suvii.pysar.controller
{
	import org.puremvc.patterns.command.MacroCommand;
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;

	public class FindPreviosCommand extends MacroCommand implements ICommand
	{
		public function FindPreviosCommand()
		{
			super();
		}
		
		// ------------------- PureMVC ------------------- //
		
		override protected function initializeMacroCommand():void
		{
			this.addSubCommand(FindSearchCommnad);
		}
		
		// ------------------- PureMVC ------------------- //
	}
}