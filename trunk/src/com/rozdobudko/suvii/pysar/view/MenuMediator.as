package com.rozdobudko.suvii.pysar.view
{
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.model.MenuProxy;
	import com.rozdobudko.suvii.pysar.view.components.MenuModule;
	
	import flash.events.MouseEvent;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.patterns.mediator.Mediator;
	import org.puremvc.patterns.observer.Notification;

	public class MenuMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "MenuMediator";
		
		public function MenuMediator(viewComponent:Object=null)
		{
			super(viewComponent);
			
			this.component.saveBut.addEventListener(MouseEvent.CLICK, this.saveClickHandler);
			this.component.saveAsBut.addEventListener(MouseEvent.CLICK, this.saveAsClickHandler);
			this.component.openBut.addEventListener(MouseEvent.CLICK, this.openClickHandler);
			this.component.settingsBut.addEventListener(MouseEvent.CLICK, this.settingsClickHandler);
			this.component.printBut.addEventListener(MouseEvent.CLICK, this.printClickHandler);
		}
		
		// ------------------- PureMVC ------------------- //
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		private function get component():MenuModule
		{
			return this.getViewComponent() as MenuModule;
		}
		
		private function get proxy():MenuProxy
		{
			return this.facade.retrieveProxy(MenuProxy.NAME) as MenuProxy;
		}
		
		// -------------------- FIEDS -------------------- //



		// ------------------- METHODS ------------------- //
		
		
		
		// ------------------  HANDLERS ------------------- //
		
		
		
		// ---------------- USER INTRACTION --------------- //
		
		private function saveClickHandler(event:MouseEvent):void
		{
			this.facade.notifyObservers(new Notification(PysarFacade.MENU_SAVE));
		}
		private function saveAsClickHandler(event:MouseEvent):void
		{
			this.facade.notifyObservers(new Notification(PysarFacade.MENU_SAVE_AS));
		}
		private function openClickHandler(event:MouseEvent):void
		{
			this.facade.notifyObservers(new Notification(PysarFacade.MENU_OPEN));
		}
		private function settingsClickHandler(event:MouseEvent):void
		{
			this.facade.notifyObservers(new Notification(PysarFacade.SETTINGS_SHOW, this.component.stage));
		}
		private function printClickHandler(event:MouseEvent):void
		{
			this.facade.notifyObservers(new Notification(PysarFacade.MENU_PRINT));
		}
	}
}