package com.rozdobudko.suvii.pysar.controller
{
	import com.rozdobudko.suvii.pysar.view.FindMediator;
	import com.rozdobudko.suvii.pysar.view.MenuMediator;
	import com.rozdobudko.suvii.pysar.view.OutputMediator;
	
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;
	
	public class DeployCommand extends SimpleCommand implements ICommand
	{
		/**
		 * Deploy application. Register proxies and mediators.
		 */
		override public function execute(note:INotification):void	
		{
			trace("DeployCommand :: execute");
			
			var application:Pysar = note.getBody() as Pysar;
			
			this.facade.registerMediator(new FindMediator(application.findModule));
			this.facade.registerMediator(new OutputMediator(application.outputModule));
			this.facade.registerMediator(new MenuMediator(application.menuModule));
		}
	}
}