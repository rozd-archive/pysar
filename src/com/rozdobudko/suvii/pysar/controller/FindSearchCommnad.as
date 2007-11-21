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

	public class FindSearchCommnad extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			trace("SearchCommnad :: execute : "+notification);
			
			var outputProxy:OutputProxy = this.facade.retrieveProxy(OutputProxy.NAME) as OutputProxy;
			var findProxy:FindProxy = this.facade.retrieveProxy(FindProxy.NAME) as FindProxy;
			
			var findMediator:FindMediator = this.facade.retrieveMediator(FindMediator.NAME) as FindMediator;
			var outputMediator:OutputMediator = this.facade.retrieveMediator(OutputMediator.NAME) as OutputMediator;
			
			//var cursor:IViewCursor = outputProxy.entries.createCursor();
			var cursor:IViewCursor = outputProxy.cursor;
			
			while(!cursor.afterLast && !cursor.beforeFirst)
			{
				var entry:LogEntry = cursor.current as LogEntry;
				
				if(entry.findData.cursor.afterLast)
				{
					entry.findData.cursor.movePrevious();
				}
				if(entry.findData.cursor.beforeFirst)
				{
					entry.findData.cursor.moveNext();
				}
				
				while(!entry.findData.cursor.afterLast && !entry.findData.cursor.beforeFirst)
				{
					var logText:LogEntryText = entry.findData.cursor.current as LogEntryText;
					
					var index:int;
					
					switch(notification.getName())
					{
						case PysarFacade.FIND_SEARCH :
							index = logText.text.indexOf(findProxy.searchPhrase, 0);
						break;
						case PysarFacade.FIND_NEXT :
							index = logText.text.indexOf(findProxy.searchPhrase, entry.findData.endIndex);
						break;
						case PysarFacade.FIND_PREVIOS :
							index = logText.text.lastIndexOf(findProxy.searchPhrase, entry.findData.endIndex - findProxy.searchPhrase.length - 1);
							trace(logText.text+" "+findProxy.searchPhrase);
							trace(index+" "+(entry.findData.beginIndex - 1));
						break;
					}
					
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
						 * TODO: Знайти інший спосіб обновити вихідний інтерфейс.
						 */
						outputMediator.table.dataProvider = outputProxy.entries;
						return;
					}
					
					if(notification.getName() == PysarFacade.FIND_PREVIOS)
					{
						//trace("entry cursor move to previos");
						entry.findData.cursor.movePrevious();
					}
					else
					{
						entry.findData.cursor.moveNext();
					}
				}
				
				if(notification.getName() == PysarFacade.FIND_PREVIOS)
				{
					//trace("output cursor move to previos");
					cursor.movePrevious();
				}
				else
				{
					cursor.moveNext();
				}
			}
			outputMediator.table.dataProvider = outputProxy.entries;
			/**
			 * TODO: Use IViewCursor for navigation in output data.
			 */
//			for(var i:uint; i<outputProxy.length; i++)
//			{
//				var entry:LogEntry = outputProxy.getItemAt(i);
//				
//				var textes:Array = [
//									entry.message,
//									entry.className,
//									entry.connectionName
//									];
//				
//				for(var j:uint=0; j<textes.length; j++)
//				{
//					var logText:LogEntryText = textes[j] as LogEntryText;
//					
//					logText.findData = new LogEntryFindData([]);
//					
//					var index:int = findProxy.searchPhrase != "" ?
//									logText.text.indexOf(findProxy.searchPhrase, 0) :
//									-1;
//					var length:int = findProxy.searchPhrase.length;
//					
//					if(index != -1)
//					{
//						logText.findData.ranges.push(new LogEntryFindDataRange(index, index + length));
//					}
//				}
//			}
		}
	}
}