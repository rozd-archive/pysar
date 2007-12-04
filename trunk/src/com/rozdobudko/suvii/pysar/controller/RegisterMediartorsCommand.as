package com.rozdobudko.suvii.pysar.controller
{
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.view.FindMediator;
	import com.rozdobudko.suvii.pysar.view.MenuMediator;
	import com.rozdobudko.suvii.pysar.view.OutputMediator;
	import com.rozdobudko.suvii.pysar.view.SubjectsMediator;
	
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;

	public class RegisterMediartorsCommand extends SimpleCommand implements ICommand
	{
		public function RegisterMediartorsCommand()
		{
			super();
		}
		
		/**
		 * @public
		 * Deploy application. Register proxies and mediators.
		 */
		override public function execute(notification:INotification):void
		{
			var application:Pysar = notification.getBody() as Pysar;
			
			this.facade.registerMediator(new FindMediator(application.findModule));
			this.facade.registerMediator(new OutputMediator(application.outputModule));
			this.facade.registerMediator(new MenuMediator(application.menuModule));
			this.facade.registerMediator(new SubjectsMediator(application.subjectModule));
				
			/**
			 * TODO: Remove temp command
			 */
			this.sendNotification(PysarFacade.TEMP);
		}
		
	}
}