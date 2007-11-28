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
	import mx.collections.CursorBookmark;
	import com.rozdobudko.suvii.pysar.PysarFacade;
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
			
			var inited:Boolean;
			
			while(!cursor.beforeFirst)
			{
				var entry:LogEntry = cursor.current as LogEntry;
				
				while(!entry.findData.cursor.beforeFirst)
				{
					var logText:LogEntryText = entry.findData.cursor.current as LogEntryText;
					
					entry.findData.beginIndex = isNaN(entry.findData.beginIndex) ? logText.label.length : entry.findData.beginIndex;
					entry.findData.endIndex = isNaN(entry.findData.beginIndex) ? logText.label.length : entry.findData.endIndex;
					
					var index:int
					index = logText.label.lastIndexOf(findProxy.searchPhrase, 2*entry.findData.beginIndex - entry.findData.endIndex);
					
					if(index == -1)
					{
						entry.findData.beginIndex = logText.label.length;
						entry.findData.endIndex = logText.label.length;
					}
					else
					{
						entry.findData.beginIndex = index;
						entry.findData.endIndex = index + findProxy.searchPhrase.length;
						
						this.sendNotification(PysarFacade.OUTPUT_UPDATE);
						return;
					}
					
					entry.findData.cursor.movePrevious();
				}
				
				if(!inited)
				{
					var bookmark:CursorBookmark = cursor.bookmark;
					
					cursor.seek(CursorBookmark.FIRST);
					while(!cursor.afterLast)
					{
						if(cursor.current != entry)
						{
							LogEntry(cursor.current).findData.cursor.seek(CursorBookmark.LAST);
							LogEntry(cursor.current).findData.beginIndex = null;
							LogEntry(cursor.current).findData.endIndex = null;
						}
						cursor.moveNext();
					}
					
					cursor.seek(bookmark);
					
					inited = true;
				}
				
				cursor.movePrevious();
			}
			
			cursor.seek(CursorBookmark.LAST);
			
			this.facade.notifyObservers(new Notification(PysarFacade.FIND_PREVIOS));
		}
		
		// ------------------- PureMVC ------------------- //
	}
}