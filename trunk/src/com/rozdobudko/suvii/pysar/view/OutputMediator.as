package com.rozdobudko.suvii.pysar.view
{
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.model.OutputProxy;
	import com.rozdobudko.suvii.pysar.model.data.LogEntry;
	import com.rozdobudko.suvii.pysar.view.components.OutputModule;
	
	import mx.controls.DataGrid;
	import mx.controls.TextArea;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.events.ScrollEvent;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.mediator.Mediator;
	import com.rozdobudko.suvii.pysar.model.LogProxy;
	
	public class OutputMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "OutputMediator";
		
		public function OutputMediator(component:Object)
		{
			super(component);
			
			this.table.dataProvider = this.proxy.entries;
		}
		
		// ------------------- PureMVC ------------------- //
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
			       	PysarFacade.OUTPUT_UPDATE
				   ]
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case PysarFacade.OUTPUT_UPDATE :
					
					var entry:LogEntry = notification.getBody() as LogEntry;
					
					var scrollPosition:Number = this.table.verticalScrollPosition;
					
					this.proxy.entries.refresh();
					
					this.table.verticalScrollPosition = scrollPosition;
					
					if(!entry)
					{
						return;
					}
					
					var index:int = this.proxy.entries.getItemIndex(entry);
					
					if(index > this.table.verticalScrollPosition + (this.table.rowCount - 1))
					{
						this.table.verticalScrollPosition = index - (this.table.rowCount - 1) ;
					}
					else if(index < this.table.verticalScrollPosition)
					{
						this.table.verticalScrollPosition = index;
					}
					
				break;
			}
		}
		
		// -------------------- FIEDS -------------------- //
		
		private function get component():OutputModule
		{
			return this.getViewComponent() as OutputModule;
		}
		
		private function get proxy():OutputProxy
		{
			return this.facade.retrieveProxy(OutputProxy.NAME) as OutputProxy;
		}
		
		public function get table():DataGrid
		{
			return this.component.outputDataGrid;
		}

		public function get area():TextArea
		{
			return this.component.outputTextArea;
		}
		
		// ------------------  HANDLERS ------------------- //
		

		
		// ---------------- USER INTERACTION -------------- //
		
		
	}
}