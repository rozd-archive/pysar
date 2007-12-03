package com.rozdobudko.suvii.pysar.controller
{
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.model.FindProxy;
	import com.rozdobudko.suvii.pysar.model.OutputProxy;
	import com.rozdobudko.suvii.pysar.model.data.FindDataRange;
	import com.rozdobudko.suvii.pysar.model.data.LogEntry;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryText;
	
	import mx.collections.CursorBookmark;
	import mx.collections.IViewCursor;
	
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;

	public class FindShowHightlightCommand extends SimpleCommand implements ICommand
	{
		public function FindShowHightlightCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			trace("FindShowHightlightCommand");
			
			var outputProxy:OutputProxy = this.facade.retrieveProxy(OutputProxy.NAME) as OutputProxy;
			
			var findProxy:FindProxy = this.facade.retrieveProxy(FindProxy.NAME) as FindProxy;
			
			var cursor:IViewCursor = outputProxy.cursor;
			
			var entriesBookmark:CursorBookmark = cursor.bookmark;
			
			cursor.seek(CursorBookmark.FIRST);
			
			while(!cursor.afterLast)
			{
				var entry:LogEntry = cursor.current as LogEntry;
				
				var entryBookmark:CursorBookmark = entry.findData.cursor.bookmark;
				
				entry.findData.cursor.seek(CursorBookmark.FIRST);
				
				entry.findData.ranges = [];
				
				while(!entry.findData.cursor.afterLast)
				{
					var logText:LogEntryText = entry.findData.cursor.current as LogEntryText;
					
					var index:int = logText.label.indexOf(findProxy.searchPhrase);
					
					while(index != -1)
					{
						entry.findData.ranges.push(new FindDataRange(index, index + findProxy.searchPhrase.length, logText));
						entry.findData.beginIndex = 0;
						entry.findData.endIndex = 0;
						
						index = logText.label.indexOf(findProxy.searchPhrase, index + findProxy.searchPhrase.length);
					}
					
					entry.findData.cursor.moveNext();
				}
				
				entry.findData.cursor.seek(entryBookmark);
				
				cursor.moveNext();
			}
			
			cursor.seek(entriesBookmark);

			this.sendNotification(PysarFacade.OUTPUT_UPDATE, null);
		}
	}
}