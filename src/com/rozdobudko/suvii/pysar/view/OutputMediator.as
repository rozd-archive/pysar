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
	
	public class OutputMediator extends Mediator implements IMediator, IObserver
	{
		public static const NAME:String = "OutputMediator";
		
		public function OutputMediator(component:Object)
		{
			super(component);
			
			View.getInstance().registerObserver(PysarFacade.OUTPUT_UPDATE, this);
			
			this.table.dataProvider = this.proxy.entries;
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
		
		public function notifyObserver(notification:INotification):void
		{
			trace("OutputMediator :: notification : "+notification.getName());
			
			/**
			 * TODO: Add binding to bind "output" field from OutputProxy, and remove this notification.
			 */
//			this.area.text = this.proxy.output.toString();
		}
		
		public function compareNotifyContext(object:Object):Boolean
		{
			return false;
		}
		
		public function setNotifyContext(notifyContext:Object):void
		{
			
		}
		
		public function setNotifyMethod(notifyMethod:Function):void
		{
			
		}
		
		// ---------------- USER INTERACTION -------------- //
		
		
	}
}