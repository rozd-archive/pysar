package com.rozdobudko.suvii.pysar.controller
{
	import com.rozdobudko.suvii.pysar.model.FindProxy;
	import com.rozdobudko.suvii.pysar.model.OutputProxy;
	import com.rozdobudko.suvii.pysar.model.data.LogEntry;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryText;
	import com.rozdobudko.suvii.pysar.view.FindMediator;
	import com.rozdobudko.suvii.pysar.view.OutputMediator;
	
	import mx.collections.IViewCursor;
	
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;

	public class FindPreviosCommand extends SimpleCommand implements ICommand
	{
		public function FindPreviosCommand()
		{
			super();
		}
		
		// ------------------- PureMVC ------------------- //
		
		override public function execute(notification:INotification):void
		{
			trace("FindPreviosCommand :: execute : "+notification);
			
			var outputProxy:OutputProxy = this.facade.retrieveProxy(OutputProxy.NAME) as OutputProxy;
			var outputMediator:OutputMediator = this.facade.retrieveMediator(OutputMediator.NAME) as OutputMediator;
			
			var findProxy:FindProxy = this.facade.retrieveProxy(FindProxy.NAME) as FindProxy;
			var findMediator:FindMediator = this.facade.retrieveMediator(FindMediator.NAME) as FindMediator;
			
			//var cursor:IViewCursor = outputProxy.entries.createCursor();
			var cursor:IViewCursor = outputProxy.cursor;
			
			while(!cursor.beforeFirst)
			{
				var entry:LogEntry = cursor.current as LogEntry;
				
				while(!entry.findData.cursor.beforeFirst)
				{
					if(entry.findData.cursor.afterLast)
					{
						entry.findData.cursor.movePrevious();
					}
					
					var logText:LogEntryText = entry.findData.cursor.current as LogEntryText;
					
					var index:int = logText.text.lastIndexOf(findProxy.searchPhrase, 
																					(entry.findData.endIndex - entry.findData.beginIndex - 1) > 0
																					? entry.findData.endIndex - entry.findData.beginIndex - 1
																					: findProxy.searchPhrase.length);
//					var index:int = logText.text.lastIndexOf(findProxy.searchPhrase, Math.max(entry.findData.beginIndex - 1, 0));
					
					trace("----------------------------");
					trace(entry.findData.beginIndex);
					trace(entry.findData.endIndex);
					trace(findProxy.searchPhrase+" : "+logText.text);
					trace((entry.findData.endIndex - entry.findData.beginIndex - 1));
					trace(index);
					trace("----------------------------");
					
					if(index == -1)
					{
						entry.findData.beginIndex = 0;
						entry.findData.endIndex = 0;
					}
					else
					{
						entry.findData.beginIndex = index;
						entry.findData.endIndex = index + findProxy.searchPhrase.length;
						
						/**
						 * TODO: Знайти інший спосіб оновити вихідний інтерфейс.
						 */
						outputMediator.table.dataProvider = outputProxy.entries;
						return;
					}
					
					entry.findData.cursor.movePrevious();
				}
				
				cursor.movePrevious();
			}
		}
		
		// ------------------- PureMVC ------------------- //
	}
}