package com.rozdobudko.suvii.pysar.controller
{
	import com.rozdobudko.suvii.pysar.view.FindMediator;
	import com.rozdobudko.suvii.pysar.view.MenuMediator;
	import com.rozdobudko.suvii.pysar.view.OutputMediator;
	
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.view.SubjectsMediator;
	import com.rozdobudko.suvii.pysar.model.LogProxy;
	import com.rozdobudko.suvii.pysar.model.SubjectsProxy;
	
	public class DeployCommand extends SimpleCommand implements ICommand
	{
		/**
		 * Deploy application. Register proxies and mediators.
		 */
		override public function execute(note:INotification):void	
		{
				// register the Mediators
			
			var application:Pysar = note.getBody() as Pysar;
			
			this.facade.registerMediator(new FindMediator(application.findModule));
			this.facade.registerMediator(new OutputMediator(application.outputModule));
			this.facade.registerMediator(new MenuMediator(application.menuModule));
			this.facade.registerMediator(new SubjectsMediator(application.subjectModule));
				
				// binding subjects sources
				
			var logProxy:LogProxy = this.facade.retrieveProxy(LogProxy.NAME) as LogProxy;
			var subjectsProxy:SubjectsProxy = this.facade.retrieveProxy(SubjectsProxy.NAME) as SubjectsProxy;
			
			subjectsProxy.classes = logProxy.classes;
			subjectsProxy.connections = logProxy.connections;
				
				/**
				 * TODO: Remove temp command
				 */
				
			this.sendNotification(PysarFacade.TEMP);
		}
	}
}