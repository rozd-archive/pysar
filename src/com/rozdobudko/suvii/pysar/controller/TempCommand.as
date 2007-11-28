package com.rozdobudko.suvii.pysar.controller
{
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.patterns.command.SimpleCommand;
	import org.puremvc.interfaces.INotification;
	import com.rozdobudko.suvii.pysar.model.LogProxy;

	public class TempCommand extends SimpleCommand implements ICommand
	{
		public function TempCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			trace("TempCommand :: execute");
			
			var logProxy:LogProxy = this.facade.retrieveProxy(LogProxy.NAME) as LogProxy;
			
			logProxy.log(0, "TEST Lorem ipsum, dolorem", "className", "connectionName");
			logProxy.log(3, "TEST Lorem ipsum, dolorem", "className", "connectionName");
			logProxy.log(4, "TEST Lorem ipsum, dolorem", "className", "connectionName");
			logProxy.log(1, "TEST Lorem ipsum, dolorem", "className", "connectionName");
		}
		
	}
}