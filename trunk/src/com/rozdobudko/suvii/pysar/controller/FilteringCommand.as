package com.rozdobudko.suvii.pysar.controller
{
	import com.rozdobudko.suvii.pysar.model.LogProxy;
	import com.rozdobudko.suvii.pysar.model.OutputProxy;
	import com.rozdobudko.suvii.pysar.model.data.LogEntry;
	import com.rozdobudko.suvii.pysar.view.FindMediator;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;
	import com.rozdobudko.suvii.pysar.model.SettingsProxy;

	public class FilteringCommand extends SimpleCommand implements ICommand
	{
		public function FilteringCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var logProxy:LogProxy = this.facade.retrieveProxy(LogProxy.NAME) as LogProxy;
			var outputProxy:OutputProxy = this.facade.retrieveProxy(OutputProxy.NAME) as OutputProxy;
			var settingsProxy:SettingsProxy = this.facade.retrieveProxy(SettingsProxy.NAME) as SettingsProxy;
			var findMediator:FindMediator = this.facade.retrieveMediator(FindMediator.NAME) as FindMediator;
			
			outputProxy.entries = new ArrayCollection();
			
			var cursor:IViewCursor = logProxy.entries.createCursor();
			
			while(!cursor.afterLast)
			{
				var entry:LogEntry = cursor.current as LogEntry;
				
				if( settingsProxy.levels[entry.level] && 
					entry.phraseExist(findMediator.includePhrase) && 
					(findMediator.excludePhrase == "" || !entry.phraseExist(findMediator.excludePhrase)))
				{
					outputProxy.addItem(entry);
				}
				
				cursor.moveNext();
			}
			
			outputProxy.resetCursor();
		}
	}
}