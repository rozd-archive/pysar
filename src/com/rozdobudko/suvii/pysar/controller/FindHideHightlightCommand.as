package com.rozdobudko.suvii.pysar.controller
{
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.patterns.command.SimpleCommand;
	import org.puremvc.interfaces.INotification;
	import com.rozdobudko.suvii.pysar.model.OutputProxy;
	import com.rozdobudko.suvii.pysar.model.FindProxy;
	import mx.collections.IViewCursor;
	import mx.collections.CursorBookmark;
	import com.rozdobudko.suvii.pysar.model.data.LogEntry;
	import com.rozdobudko.suvii.pysar.PysarFacade;

	public class FindHideHightlightCommand extends SimpleCommand implements ICommand
	{
		public function FindHideHightlightCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var outputProxy:OutputProxy = this.facade.retrieveProxy(OutputProxy.NAME) as OutputProxy;
			var findProxy:FindProxy = this.facade.retrieveProxy(FindProxy.NAME) as FindProxy;
			
			var cursor:IViewCursor = outputProxy.cursor;
			var bookmark:CursorBookmark = cursor.bookmark;
			
			cursor.seek(CursorBookmark.FIRST);
			
			while(!cursor.afterLast)
			{
				var entry:LogEntry = cursor.current as LogEntry;
				
				entry.findData.ranges = [];
				
				cursor.moveNext();
			}
			
			cursor.seek(bookmark);

			this.sendNotification(PysarFacade.OUTPUT_UPDATE, null);
		}
		
	}
}