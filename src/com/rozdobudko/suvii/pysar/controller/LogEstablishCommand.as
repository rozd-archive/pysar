package com.rozdobudko.suvii.pysar.controller
{
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.patterns.command.SimpleCommand;
	import org.puremvc.interfaces.INotification;
	import com.rozdobudko.suvii.pysar.model.LogProxy;
	import com.rozdobudko.suvii.pysar.model.SubjectsProxy;

	public class LogEstablishCommand extends SimpleCommand implements ICommand
	{
		public function LogEstablishCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			trace("LogEstablishCommand :: execute");
			
			var logProxy:LogProxy = this.facade.retrieveProxy(LogProxy.NAME) as LogProxy;
			var subjectsProxy:SubjectsProxy = this.facade.retrieveProxy(SubjectsProxy.NAME) as SubjectsProxy;
			
			subjectsProxy.classes = logProxy.classes;
			subjectsProxy.connections = logProxy.connections;
		}
		
	}
}