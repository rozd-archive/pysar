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
	import org.puremvc.patterns.observer.Notification;
	import com.rozdobudko.suvii.pysar.PysarFacade;

	public class FindNextCommand extends SimpleCommand implements ICommand
	{
		public function FindNextCommand()
		{
			super();
		}
		
		// ------------------- PureMVC ------------------- //
		
		override public function execute(notification:INotification):void
		{
//			trace("FindNextCommand :: execute : "+notification);
			
			var outputProxy:OutputProxy = this.facade.retrieveProxy(OutputProxy.NAME) as OutputProxy;
			var outputMediator:OutputMediator = this.facade.retrieveMediator(OutputMediator.NAME) as OutputMediator;
			
			var findProxy:FindProxy = this.facade.retrieveProxy(FindProxy.NAME) as FindProxy;
			
			var cursor:IViewCursor = outputProxy.cursor;
			
			var inited:Boolean;
			
			while(!cursor.afterLast)
			{
				var entry:LogEntry = cursor.current as LogEntry;
				
				while(!entry.findData.cursor.afterLast)
				{
					var logText:LogEntryText = entry.findData.cursor.current as LogEntryText;
					
					var index:int = logText.label.indexOf(findProxy.searchPhrase, entry.findData.endIndex);
					
					if(index == -1)
					{
						entry.findData.beginIndex = 0;
						entry.findData.endIndex = 0;
					}
					else
					{
						entry.findData.beginIndex = index;
						entry.findData.endIndex = index + findProxy.searchPhrase.length;
						
						this.sendNotification(PysarFacade.OUTPUT_UPDATE);
						return;
					}
					entry.findData.cursor.moveNext();
				}
				
				if(!inited)
				{
					var bookmark:CursorBookmark = cursor.bookmark; 
					
					cursor.seek(CursorBookmark.FIRST);
					while(!cursor.afterLast)
					{
						if(cursor.current != entry)
						{
							LogEntry(cursor.current).findData.cursor.seek(CursorBookmark.FIRST);
							LogEntry(cursor.current).findData.beginIndex = 0;
							LogEntry(cursor.current).findData.endIndex = 0;
						}
						cursor.moveNext();
					}
					
					cursor.seek(bookmark);
					
					inited = true;
				}
				
				cursor.moveNext();
			}
			
			cursor.seek(CursorBookmark.FIRST);

			this.facade.notifyObservers(new Notification(PysarFacade.FIND_NEXT));
		}
		
		// ------------------- PureMVC ------------------- //
		
	}
}