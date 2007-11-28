package com.rozdobudko.suvii.pysar.view
{
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.model.OutputProxy;
	import com.rozdobudko.suvii.pysar.view.components.OutputModule;
	
	import mx.controls.DataGrid;
	import mx.controls.TextArea;
	import mx.events.FlexEvent;
	
	import org.puremvc.core.view.View;
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.interfaces.IObserver;
	import org.puremvc.patterns.mediator.Mediator;
	import mx.formatters.SwitchSymbolFormatter;
	
	public class OutputMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "OutputMediator";
		
		public function OutputMediator(component:Object)
		{
			super(component);
			
			this.table.dataProvider = this.proxy.entries;
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
					this.table.dataProvider = this.proxy.entries;
				break;
			}
		}
		
		// ------------------- PureMVC ------------------- //
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		private function get component():OutputModule
		{
			return this.getViewComponent() as OutputModule;
		}
		
		private function get proxy():OutputProxy
		{
			return this.facade.retrieveProxy(OutputProxy.NAME) as OutputProxy;
		}
		
		// -------------------- FIEDS -------------------- //
		
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