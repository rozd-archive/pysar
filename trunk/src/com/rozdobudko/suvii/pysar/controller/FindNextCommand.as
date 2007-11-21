package com.rozdobudko.suvii.pysar.controller
{
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.MacroCommand;

	public class FindNextCommand extends MacroCommand implements ICommand
	{
		public function FindNextCommand()
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