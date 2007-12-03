package com.rozdobudko.suvii.pysar.controller
{
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.model.FindProxy;
	import com.rozdobudko.suvii.pysar.model.OutputProxy;
	import com.rozdobudko.suvii.pysar.model.data.LogEntry;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryText;
	import com.rozdobudko.suvii.pysar.view.FindMediator;
	import com.rozdobudko.suvii.pysar.view.OutputMediator;
	
	import mx.collections.CursorBookmark;
	import mx.collections.IViewCursor;
	
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;
	import org.puremvc.patterns.observer.Notification;

	public class FindPreviosCommand extends SimpleCommand implements ICommand
	{
		public function FindPreviosCommand()
		{
			super();
		}
		
		// ------------------- PureMVC ------------------- //
		
		override public function execute(notification:INotification):void
		{
//			trace("FindPreviosCommand :: execute : "+notification);
			
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
					LogEntry(cursor.current).findData.cursor.seek(CursorBookmark.LAST);
					LogEntry(cursor.current).findData.beginIndex = -1;
					LogEntry(cursor.current).findData.endIndex = -1;
				}
				cursor.moveNext();
			}
			
			cursor.seek(bookmark);
			
			var entry:LogEntry;
			var logText:LogEntryText;
			var index:int;
			
			while(!cursor.beforeFirst)
			{
				entry = cursor.current as LogEntry;
				
				while(!entry.findData.cursor.beforeFirst)
				{
					logText = entry.findData.cursor.current as LogEntryText;
					
					if(entry.findData.beginIndex == -1)
					{
						index = logText.label.lastIndexOf(findProxy.searchPhrase, logText.label.length);
					}
					else
					{
						index = logText.label.lastIndexOf(findProxy.searchPhrase, 2*entry.findData.beginIndex - entry.findData.endIndex);
					}

					if(index == -1)
					{
						entry.findData.beginIndex = -1;
						entry.findData.endIndex = -1;
					}
					else
					{
						entry.findData.beginIndex = index;
						entry.findData.endIndex = index + findProxy.searchPhrase.length;
						
						this.sendNotification(PysarFacade.OUTPUT_UPDATE, entry);
						return;
					}
					
					entry.findData.cursor.movePrevious();
				}
				
				cursor.movePrevious();
			}
			
			cursor.seek(CursorBookmark.LAST);
			
			while(cursor.bookmark.getViewIndex() >= bookmark.getViewIndex())
			{
				entry = cursor.current as LogEntry;
				
				while(!entry.findData.cursor.beforeFirst)
				{
					logText = entry.findData.cursor.current as LogEntryText;
					
					if(entry.findData.beginIndex == -1)
					{
						index = logText.label.lastIndexOf(findProxy.searchPhrase, logText.label.length);
					}
					else
					{
						index = logText.label.lastIndexOf(findProxy.searchPhrase, 2*entry.findData.beginIndex - entry.findData.endIndex);
					}

					if(index == -1)
					{
						entry.findData.beginIndex = -1;
						entry.findData.endIndex = -1;
					}
					else
					{
						entry.findData.beginIndex = index;
						entry.findData.endIndex = index + findProxy.searchPhrase.length;
						
						this.sendNotification(PysarFacade.OUTPUT_UPDATE, entry);
						return;
					}
					
					entry.findData.cursor.movePrevious();
				}
				
				cursor.movePrevious();
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
		}
		
		// ------------------- PureMVC ------------------- //
	}
}