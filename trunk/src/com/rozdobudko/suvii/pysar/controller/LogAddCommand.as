package com.rozdobudko.suvii.pysar.controller
{
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.patterns.command.SimpleCommand;
	import org.puremvc.interfaces.INotification;
	import com.rozdobudko.suvii.pysar.model.LogProxy;
	import com.rozdobudko.suvii.pysar.model.OutputProxy;
	import com.rozdobudko.suvii.pysar.model.data.LogEntry;

	public class LogAddCommand extends SimpleCommand implements ICommand
	{
		public function LogAddCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			trace("LogAddCommand :: execute");
			
			var outputProxy:OutputProxy = this.facade.retrieveProxy(OutputProxy.NAME) as OutputProxy;
			
			outputProxy.addItem(notification.getBody() as LogEntry);
		}
		
	}
}