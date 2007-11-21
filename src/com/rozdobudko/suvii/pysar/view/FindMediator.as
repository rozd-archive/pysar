package com.rozdobudko.suvii.pysar.view
{
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.model.FindProxy;
	import com.rozdobudko.suvii.pysar.view.components.FindModule;
	import com.rozdobudko.suvii.pysar.view.components.search.events.FindEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.patterns.mediator.Mediator;
	import org.puremvc.patterns.observer.Notification;
	
	public class FindMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "FindMediator"; 
		
		public function FindMediator(component:Object)
		{
			super(component);
			
			this.component.addEventListener(FindEvent.SEARCH, this.searchHandler);
			
			this.component.searchBox.addEventListener(Event.CHANGE, this.searchHandler);
			this.component.nextBut.addEventListener(MouseEvent.CLICK, this.nextHandler);
			this.component.previosBut.addEventListener(MouseEvent.CLICK, this.previosHandler);
			this.component.hightlightingBut.addEventListener(MouseEvent.CLICK, this.hightlightHandler);
		}
		
		
		// ------------------- PureMVC ------------------- //
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		private function get component():FindModule
		{
			return this.getViewComponent() as FindModule;
		}
		
		private function get proxy():FindProxy
		{
			return this.facade.retrieveProxy(FindProxy.NAME) as FindProxy;
		}
		
		// -------------------- FIEDS -------------------- //
		
		public function get searchPhrase():String
		{
			return this.component.searchBox.text;
		}
		
		public function get includePhrase():String
		{
			return this.component.includeBox.text;
		}
		
		public function get excludePhrase():String
		{
			return this.component.excludeBox.text;
		}
		
		public function get caseSensitive():Boolean
		{
			return this.component.caseBox.selected;
		}
		
		public function get hightlight():Boolean
		{
			return this.component.hightlightingBut.selected;
		}
		
		// ------------------  HANDLERS ------------------- //
		
		
		
		// ---------------- USER INTRACTION --------------- //
		
		private function searchHandler(event:Event):void
		{
			trace("FindMediator :: searchHandler");
			
			this.facade.notifyObservers(new Notification(PysarFacade.FIND_SEARCH));
		}
		
		
		private function nextHandler(event:Event):void
		{
			trace("FindMediator :: nextHandler");
			
			this.facade.notifyObservers(new Notification(PysarFacade.FIND_NEXT));
		}
		
		
		private function previosHandler(event:Event):void
		{
			trace("FindMediator :: previosHandler");
			
			this.facade.notifyObservers(new Notification(PysarFacade.FIND_PREVIOS));
		}
		
		
		private function hightlightHandler(event:Event):void
		{
			trace("FindMediator :: hightlightHandler");
			
			this.facade.notifyObservers(new Notification(PysarFacade.FIND_HIGHTLIGHT));
		}
	}
}