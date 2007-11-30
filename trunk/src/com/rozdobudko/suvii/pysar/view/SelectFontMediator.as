package com.rozdobudko.suvii.pysar.view
{
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.model.SelectFontProxy;
	import com.rozdobudko.suvii.pysar.view.components.ui.SelectFontPanel;
	
	import flash.events.Event;
	import flash.text.Font;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.patterns.mediator.Mediator;
	import org.puremvc.patterns.observer.Notification;

	public class SelectFontMediator extends Mediator implements IMediator
	{
		// ---------------- STATIC FIELDS ---------------- //

		public static const NAME:String = "SelectFontMediator";

		// ---------------- PRIVATE FIELDS --------------- //

		
		// ----------------- CONSTRUCTOR ----------------- //
		
		public function SelectFontMediator(viewComponent:Object=null)
		{
			super(viewComponent);
			
			this.component.addEventListener(Event.CLOSE, this.closeHandler);
			this.component.addEventListener(Event.CANCEL, this.cancelHandler);
			
			this.component.fontsList = this.proxy.fonts;
		}
		
		// ------------------- PureMVC ------------------- //
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		private function get component():SelectFontPanel
		{
			return this.getViewComponent() as SelectFontPanel;
		}
		
		private function get proxy():SelectFontProxy
		{
			return this.facade.retrieveProxy(SelectFontProxy.NAME) as SelectFontProxy;
		}
		
		// -------------------- FIEDS -------------------- //
		
		
		
		// --------------- PRIVATE METHODS --------------- //
		
		
		
		// ------------------- HANDLERS ------------------ //
		
		private function closeHandler(event:Event):void
		{
			this.proxy.selectedFont = this.component.fontsBox.selectedItem as Font;
			this.proxy.selectedSize = this.component.sizeBox.value as uint;
			
			this.facade.notifyObservers(new Notification(PysarFacade.SETTINGS_HIDE_FONT_PANEL, this.proxy.owner));
		}


		private function cancelHandler(event:Event):void
		{
			this.sendNotification(PysarFacade.SETTINGS_HIDE_FONT_PANEL, this.proxy.owner);
		}
		
	}
}