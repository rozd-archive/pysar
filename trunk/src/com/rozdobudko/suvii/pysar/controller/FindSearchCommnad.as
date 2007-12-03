package com.rozdobudko.suvii.pysar.controller
{
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.model.FindProxy;
	import com.rozdobudko.suvii.pysar.model.OutputProxy;
	import com.rozdobudko.suvii.pysar.model.data.LogEntry;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryText;
	import com.rozdobudko.suvii.pysar.view.FindMediator;
	import com.rozdobudko.suvii.pysar.view.OutputMediator;
	
	import mx.collections.IViewCursor;
	
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.patterns.command.MacroCommand;
	import mx.collections.CursorBookmark;
	import org.puremvc.patterns.observer.Notification;

	public class FindSearchCommnad extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			trace("FindSearchCommnad");
			
			var outputProxy:OutputProxy = this.facade.retrieveProxy(OutputProxy.NAME) as OutputProxy;
			var outputMediator:OutputMediator = this.facade.retrieveMediator(OutputMediator.NAME) as OutputMediator;
			
			var findProxy:FindProxy = this.facade.retrieveProxy(FindProxy.NAME) as FindProxy;
			var findMediator:FindMediator = this.facade.retrieveMediator(FindMediator.NAME) as FindMediator;
			
			var cursor:IViewCursor = outputProxy.cursor;
			
			var bookmark:CursorBookmark = cursor.bookmark;
			
			cursor.seek(CursorBookmark.FIRST);
			
			while(!cursor.afterLast)
			{
				if(cursor.current != bookmark.value)
				{
					LogEntry(cursor.current).findData.cursor.seek(CursorBookmark.FIRST);
					LogEntry(cursor.current).findData.beginIndex = 0;
					LogEntry(cursor.current).findData.endIndex = 0;
				}
				cursor.moveNext();
			}
			
			cursor.seek(bookmark);
			
			var entry:LogEntry;
			var logText:LogEntryText;
			var index:int;
			
			while(!cursor.afterLast)
			{
				entry = cursor.current as LogEntry;
				
				while(!entry.findData.cursor.afterLast)
				{
					logText = entry.findData.cursor.current as LogEntryText;
					
					index = logText.label.indexOf(findProxy.searchPhrase, entry.findData.beginIndex);
					
					if(index == -1)
					{
						entry.findData.beginIndex = 0;
						entry.findData.endIndex = 0;
					}
					else
					{
						entry.findData.beginIndex = index;
						entry.findData.endIndex = index + findProxy.searchPhrase.length;
						
						this.sendNotification(PysarFacade.FIND_PHRASE, true);
						this.sendNotification(PysarFacade.OUTPUT_UPDATE, entry);
						
						return;
					}
					
					entry.findData.cursor.moveNext();
				}
				
				cursor.moveNext();
			}
			
			cursor.seek(CursorBookmark.FIRST);
			
			while(cursor.bookmark.getViewIndex() <= bookmark.getViewIndex())
			{
				entry = cursor.current as LogEntry;
				
				while(!entry.findData.cursor.afterLast)
				{
					logText = entry.findData.cursor.current as LogEntryText;
					
					index = logText.label.indexOf(findProxy.searchPhrase, entry.findData.beginIndex);
					
					if(index == -1)
					{
						entry.findData.beginIndex = 0;
						entry.findData.endIndex = 0;
					}
					else
					{
						entry.findData.beginIndex = index;
						entry.findData.endIndex = index + findProxy.searchPhrase.length;
						
						this.sendNotification(PysarFacade.FIND_PHRASE, true);
						this.sendNotification(PysarFacade.OUTPUT_UPDATE, entry);
						
						return;
					}
					
					entry.findData.cursor.moveNext();
				}
				
				cursor.moveNext();
			}
			
			cursor.seek(CursorBookmark.FIRST);
			while(!cursor.afterLast)
			{
				LogEntry(cursor.current).findData.cursor.seek(CursorBookmark.FIRST);
				LogEntry(cursor.current).findData.beginIndex = 0;
				LogEntry(cursor.current).findData.endIndex = 0;
				
				cursor.moveNext();
			}
			cursor.seek(CursorBookmark.FIRST);
			
			outputMediator.table.dataProvider = outputProxy.entries;
			
			this.facade.notifyObservers(new Notification(PysarFacade.FIND_PHRASE, false));
		}
	}
}